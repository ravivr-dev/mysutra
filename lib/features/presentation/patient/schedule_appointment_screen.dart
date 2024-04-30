import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_button.dart';
import 'package:my_sutra/core/common_widgets/custom_dropdown.dart';
import 'package:my_sutra/core/common_widgets/user_name_textfield.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/models/user_helper.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/core/utils/utils.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/schedule_appointment_usecase.dart';
import 'package:my_sutra/features/presentation/common/registration/cubit/registration_cubit.dart';
import 'package:my_sutra/features/presentation/patient/bloc/appointment_cubit.dart';
import 'package:my_sutra/features/presentation/patient/bottom_sheets/confirm_your_booking_bottom_sheet.dart';
import 'package:my_sutra/features/presentation/patient/widgets/week_picker.dart';

import '../../../injection_container.dart';
import '../../domain/entities/patient_entities/available_time_slot_entity.dart';

class ScheduleAppointmentScreen extends StatefulWidget {
  final ScheduleAppointmentScreenArgs args;

  const ScheduleAppointmentScreen({
    super.key,
    required this.args,
  });

  @override
  State<ScheduleAppointmentScreen> createState() =>
      _RescheduleAppointmentState();
}

class _RescheduleAppointmentState extends State<ScheduleAppointmentScreen> {
  final DateFormat _serverDateFormat = DateFormat('yyyy-MM-dd');
  final List<String> _genderList = ['Male', 'Female'];
  DateTime _selectedDate = DateTime.now();
  String? _selectedTimeSlot;
  List<AvailableTimeSlotEntity> _availableTImeSlots = [];
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  String? _selectedGender;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getDoctorAvailableSlots(
          doctorId: widget.args.doctorId,
          date: _serverDateFormat.format(_selectedDate));
    });
    super.initState();
  }

  @override
  void dispose() {
    _disposeAllController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentCubit, AppointmentState>(
      listener: (context, state) {
        if (state is GetAvailableAppointmentSuccessState) {
          _availableTImeSlots = state.timeSlots;
        } else if (state is ScheduleAppointmentSuccessState) {
          if (widget.args.isNewAppointment) {
            _showConfirmBottomSheet(state.entity.token!);
            return;
          }
          _showToast(message: 'Appointment Updated Successfully');
          AiloitteNavigation.back(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                AiloitteNavigation.back(context);
              },
              child: Icon(Icons.arrow_back,
                  color: AppColors.color0xFF00082F.withOpacity(.27)),
            ),
            title: component.text(
                context.stringForKey(widget.args.isNewAppointment
                    ? StringKeys.newAppointment
                    : StringKeys.rescheduleAppointment),
                style: theme.publicSansFonts.mediumStyle(
                  fontSize: 20,
                )),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WeekPicker(
                            onDateTimeSelected: (dateTime) {
                              _initSelectedDate(dateTime);
                            },
                          ),
                          component.spacer(height: 24),
                          _buildText(
                              value: context
                                  .stringForKey(StringKeys.availableTime)),
                          component.spacer(height: 16),
                          Wrap(
                              spacing: 8,
                              runSpacing: 12,
                              children: List.generate(
                                  _availableTImeSlots.length,
                                  (index) => _buildTimeWidget(
                                      _availableTImeSlots[index]))),
                          if (widget.args.isNewAppointment) ...[
                            component.spacer(height: 24),
                            _buildText(
                                value: context
                                    .stringForKey(StringKeys.patientDetails),
                                fontSize: 16),
                            component.spacer(height: 16),
                            _buildText(
                                value:
                                    context.stringForKey(StringKeys.fullName)),
                            component.spacer(height: 10),
                            if (UserHelper.role == UserRole.guest)
                              BlocProvider(
                                create: (_) => sl<RegistrationCubit>(),
                                child: UserNameTextField(
                                    userNameController: _nameController),
                              )
                            else
                              _buildTextField(
                                  controller: _nameController,
                                  errorText: 'Name'),
                            _buildText(
                                value: context.stringForKey(StringKeys.age)),
                            component.spacer(height: 10),
                            _buildTextField(
                                controller: _ageController, errorText: 'Age'),
                            _buildText(
                                value: context
                                    .stringForKey(StringKeys.phoneNumber)),
                            component.spacer(height: 10),
                            _buildTextField(
                                controller: _phoneNumberController,
                                textInputType: TextInputType.number,
                                maxLength: 10,
                                errorText: 'Phone Number'),
                            _buildText(
                                value: context.stringForKey(StringKeys.email)),
                            component.spacer(height: 10),
                            _buildTextField(
                                controller: _emailController,
                                errorText: 'Email'),
                            _buildText(
                                value: context.stringForKey(StringKeys.gender)),
                            component.spacer(height: 10),
                            CustomDropdown(
                              onChanged: (value) {
                                _selectedGender =
                                    '${value.value}'.toUpperCase();
                              },
                              validator: (value) {
                                return _selectedGender == null
                                    ? 'Please Select Gender'
                                    : null;
                              },
                              dropDownList: List.generate(
                                _genderList.length,
                                (index) => DropDownValueModel(
                                    name: _genderList[index],
                                    value: _genderList[index]),
                              ),
                              height: 95,
                              borderRadius: 90,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 33),
                            ),
                            _buildText(
                                value: context.stringForKey(
                                    widget.args.isNewAppointment
                                        ? StringKeys.reasonForVisit
                                        : StringKeys.writeYourProblem)),
                            component.spacer(height: 10),
                            _buildTextField(
                                maxLines: 5,
                                controller: _reasonController,
                                errorText: 'Reason'),
                          ],
                          component.spacer(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
                CustomButton(
                  text: context.stringForKey(
                    widget.args.isNewAppointment
                        ? StringKeys.proceedToPay
                        : StringKeys.confirmBooking,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_selectedTimeSlot == null) {
                        _showToast(message: 'Please Select Available Time');
                        return;
                      }
                      _scheduleAppointment();
                    }
                  },
                ),
                component.spacer(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showConfirmBottomSheet(String token) {
    context.showBottomSheet(
        BlocProvider(
          create: (BuildContext context) {
            return sl<AppointmentCubit>();
          },
          child: ConfirmYourBookingBottomSheet(
            token: token,
          ),
        ),
        isScrollControlled: true);
  }

  void _showToast({required String message}) {
    widget.showErrorToast(context: context, message: message);
  }

  void _initSelectedDate(DateTime dateTime) {
    _selectedDate = dateTime;
  }

  String get _getServerDate {
    return _serverDateFormat.format(_selectedDate);
  }

  void _scheduleAppointment() {
    final isNewAppointment = widget.args.isNewAppointment;
    context.read<AppointmentCubit>().scheduleAppointment(
            data: ScheduleAppointmentParams(
          doctorID: isNewAppointment ? widget.args.doctorId : null,
          date: _getServerDate,
          patientNumber: isNewAppointment
              ? int.parse(_phoneNumberController.text.trim())
              : null,
          patientAge: isNewAppointment ? _ageController.text : null,
          patientGender: isNewAppointment ? _selectedGender! : null,
          patientEmail: isNewAppointment ? _emailController.text : null,
          patientName: isNewAppointment ? _nameController.text : null,
          patientProblem: isNewAppointment ? _reasonController.text : null,
          time: _selectedTimeSlot!,
          appointmentId: isNewAppointment ? null : widget.args.appointmentId,
        ));
  }

  void _getDoctorAvailableSlots(
      {required String doctorId, required String date}) {
    context
        .read<AppointmentCubit>()
        .getAvailableSlots(doctorId: doctorId, date: date);
  }

  Widget _buildTextField({
    required TextEditingController controller,
    int? maxLines,
    required String? errorText,
    TextInputType? textInputType,
    int? maxLength,
  }) {
    return SizedBox(
      height: maxLines == null ? 95 : null,
      child: component.textField(
        controller: controller,
        fillColor: AppColors.white,
        textInputType: textInputType,
        maxLength: maxLength,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Fill ${errorText ?? 'Empty'} Field';
          }
          return null;
        },
        hintText: '',
        contentPadding: const EdgeInsets.only(top: 25, bottom: 25, left: 33),
        borderRadius: maxLines != null ? 30 : 90,
        maxLines: maxLines,
        filled: true,
        focusedBorderColor: AppColors.color0xFFDADCE0,
        borderColor: AppColors.color0xFFDADCE0,
      ),
    );
  }

  Widget _buildTimeWidget(AvailableTimeSlotEntity entity) {
    final timeSlot = Utils.getTimeFromMinutes(entity.startTime);
    final isSelected = timeSlot == _selectedTimeSlot;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedTimeSlot = timeSlot;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isSelected ? AppColors.color0xFF8338EC : AppColors.white,
            border: Border.all(color: AppColors.greyEC)),
        child: component.text(timeSlot,
            style: theme.publicSansFonts.regularStyle(
              fontSize: 12,
              fontColor: isSelected ? AppColors.white : AppColors.black81,
            )),
      ),
    );
  }

  Widget _buildText({required String value, double? fontSize}) {
    return component.text(value,
        style: theme.publicSansFonts.mediumStyle(fontSize: fontSize));
  }

  void _disposeAllController() {
    _nameController.dispose();
    _ageController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _reasonController.dispose();
  }
}

class ScheduleAppointmentScreenArgs {
  final String doctorId;
  bool isNewAppointment;
  final String? appointmentId;

  ScheduleAppointmentScreenArgs({
    required this.doctorId,
    bool? isNewAppointment,
    this.appointmentId,
  }) : isNewAppointment = isNewAppointment ?? false;
}
