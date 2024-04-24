import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/core/common_widgets/custom_button.dart';
import 'package:my_sutra/core/common_widgets/custom_dropdown.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/core/utils/utils.dart';
import 'package:my_sutra/features/presentation/doctor_screens/setting_screen/bloc/setting_cubit.dart';
import 'package:my_sutra/generated/assets.dart';
import '../../../../ailoitte_component_injector.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../data/model/doctor_models/time_slot_model.dart';
import '../../../domain/entities/doctor_entities/get_time_slots_response_data_entity.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List<String> _daysList = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat'
  ];
  final List<String> _selectedDays = [];
  String _selectedDuration = '30';

  final List<String> _durationOptions = [
    '30 min',
    '60 min',
    '90 min',
    '120 min'
  ];
  final List<TimeOfDay> _timeOptions = [];

  TimeOfDay? _session1StartTime;
  TimeOfDay? _session1EndTime;
  TimeOfDay? _session2StartTime;
  TimeOfDay? _session2EndTime;
  final SingleValueDropDownController _session1StartController =
      SingleValueDropDownController();
  final SingleValueDropDownController _session1EndController =
      SingleValueDropDownController();

  final SingleValueDropDownController _session2StartController =
      SingleValueDropDownController();
  final SingleValueDropDownController _session2EndController =
      SingleValueDropDownController();
  final TextEditingController _feesController = TextEditingController();

  @override
  void initState() {
    _updateTimeOptions();
    super.initState();
  }

  @override
  void dispose() {
    _session1StartController.dispose();
    _session1EndController.dispose();
    _session2StartController.dispose();
    _session2EndController.dispose();
    _feesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.transparent,
        leading: InkWell(
          onTap: () => AiloitteNavigation.back(context),
          child: Icon(
            Icons.arrow_back,
            color: AppColors.color0xFF00082F.withOpacity(.27),
          ),
        ),
        title: component.text(context.stringForKey(StringKeys.settings)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: BlocConsumer<SettingCubit, SettingState>(
          listener: (context, state) {
            if (state is UpdateTimeSlotSuccessState) {
              _showToast(message: 'Session Updated Successfully');
              AiloitteNavigation.back(context);
            } else if (state is UpdateAboutOrFeesSuccessState) {
              _showToast(message: 'Fees Updated Successfully');
              AiloitteNavigation.back(context);
            } else if (state is UpdateTimeSlotErrorState) {
              _showToast(message: state.message);
            } else if (state is UpdateAboutOrFeesErrorState) {
              _showToast(message: state.message);
            } else if (state is GetTimeSlotsSuccessState) {
              if (state.list.isNotEmpty) {
                _initSelectedDuration(state.list[0].slotType ?? '30_MINS');
                _initSelectedDays(state.list);
                _initTimingController(state.list);
              }
            }
          },
          builder: (BuildContext context, SettingState state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildScheduleRow(),
                component.spacer(height: 21),
                _buildHeader(
                    text: context.stringForKey(StringKeys.sessionDuration)),
                component.spacer(height: 8),

                ///we need to send time like this 30_MINS to server
                _buildDropDown(
                  hintText: _selectedDuration,
                  borderRadius: 12,
                  onChanged: (model) {
                    _selectedDuration = model!.value.split(' ')[0];
                    _updateTimeOptions();
                    _reInitSessionsValue();
                    setState(() {});
                  },
                  items: _durationOptions,
                ),
                component.spacer(height: 20),
                _buildHeader(text: context.stringForKey(StringKeys.selectDays)),
                component.spacer(height: 8),
                _buildDaysWidget(),
                component.spacer(height: 20),
                _buildHeader(
                    text: context.stringForKey(StringKeys.session1Timing)),
                component.spacer(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildDropDown(
                        controller: _session1StartController,
                        items: _getTimeList(),
                        onChanged: (model) {
                          setState(() {
                            _session1StartTime =
                                _getTimeOfDayFromString(model!.value);
                          });
                        },
                      ),
                    ),
                    component.spacer(width: 8),
                    Expanded(
                        child: _buildDropDown(
                      controller: _session1EndController,
                      items: _getTimeList(moreThan: _session1StartTime),
                      onChanged: (model) {
                        if (_session1StartTime == null) {
                          setState(() {
                            _session1EndController.dropDownValue = null;
                          });

                          _showToast(
                              message: 'Please Selection Session1Start Time');
                          return;
                        }
                        setState(() {
                          _session1EndTime =
                              _getTimeOfDayFromString(model!.value);
                        });
                      },
                    )),
                  ],
                ),
                component.spacer(height: 20),
                _buildHeader(
                    text: context.stringForKey(StringKeys.session2Timing)),
                component.spacer(height: 8),
                Row(
                  children: [
                    Expanded(
                        child: _buildDropDown(
                      controller: _session2StartController,
                      items: _getTimeList(moreThan: _session1EndTime),
                      onChanged: (model) {
                        if (_session1EndTime == null) {
                          setState(() {
                            _session2StartController.dropDownValue = null;
                          });

                          _showToast(message: 'Please Select Session 1 Timing');
                          return;
                        }
                        setState(() {
                          _session2StartTime =
                              _getTimeOfDayFromString(model!.value);
                        });
                      },
                    )),
                    component.spacer(width: 8),
                    Expanded(
                        child: _buildDropDown(
                      controller: _session2EndController,
                      items: _getTimeList(moreThan: _session2StartTime),
                      onChanged: (model) {
                        if (_session2StartTime == null) {
                          setState(() {
                            _session2EndController.dropDownValue = null;
                          });

                          _showToast(
                              message: 'Please Select Session2 Start Timing');
                          return;
                        }
                        _session2EndTime =
                            _getTimeOfDayFromString(model!.value);
                      },
                    )),
                  ],
                ),
                component.spacer(height: 20),
                CustomButton(
                  text: 'Save Changes',
                  onPressed: () {
                    if (_selectedDays.isEmpty) {
                      _showToast(message: 'Please select Days');
                      return;
                    } else if (_session1StartTime == null ||
                        _session1EndTime == null ||
                        _session2StartTime == null ||
                        _session2EndTime == null) {
                      _showToast(message: 'Please fill timings');
                      return;
                    }
                    context.read<SettingCubit>().updateTimeSlot(DoctorTimeSlot(
                        timeSlots: _selectedDays
                            .map((e) => TimeSlot(day: e, slots: [
                                  Slots(
                                      startTime:
                                          _getMinFromTime(_session1StartTime!),
                                      endTime:
                                          _getMinFromTime(_session1EndTime!)),
                                  Slots(
                                      startTime:
                                          _getMinFromTime(_session2StartTime!),
                                      endTime:
                                          _getMinFromTime(_session2EndTime!)),
                                ]))
                            .toList(),
                        slotType: _getServerSlot));
                  },
                  fontSize: 14,
                  height: 50,
                ),
                component.spacer(height: 35),
                const Divider(color: AppColors.color0xFFDADCE0),
                component.spacer(height: 35),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.color0xFF8338EC, width: 2)),
                    ),
                    component.spacer(width: 4),
                    component.text('Session fees',
                        style: theme.publicSansFonts.semiBoldStyle(
                            fontSize: 16, fontColor: AppColors.black21))
                  ],
                ),
                component.spacer(height: 20),
                _buildHeader(
                    text: context.stringForKey(StringKeys.sessionFees)),
                component.spacer(height: 8),
                _buildTextField(),
                component.spacer(height: 18),
                CustomButton(
                  onPressed: () {
                    final fees = int.tryParse(_feesController.text);
                    if (_feesController.text.isEmpty) {
                      _showToast(message: 'Please add fees');
                      return;
                    } else if (fees == null) {
                      _showToast(message: 'Please add Valid Fees');
                      return;
                    }
                    _updateFees(fees);
                  },
                  text: context.stringForKey(StringKeys.saveChanges),
                  buttonColor: AppColors.color0xFF8338EC,
                  fontSize: 14,
                  height: 50,
                )
              ],
            );
          },
        ),
      ),
    );
  }

  void _initTimingController(List<GetTimeSlotsResponseDataEntity> list) {
    final session1StartValue = Utils.getTimeFromMinutes(list[0].startTime ?? 0);
    final session1EndValue = Utils.getTimeFromMinutes(list[0].endTime ?? 0);
    _initSession1Timings(session1StartValue, session1EndValue);

    if (list.length > 1) {
      final session2StartValue =
          Utils.getTimeFromMinutes(list[1].startTime ?? 0);
      final session2EndValue = Utils.getTimeFromMinutes(list[1].endTime ?? 0);
      _session2StartController.dropDownValue = DropDownValueModel(
          name: session2StartValue, value: session2StartValue);
      _session2EndController.dropDownValue =
          DropDownValueModel(name: session2EndValue, value: session2EndValue);
      _session2StartTime = _getTimeOfDayFromString(session2StartValue);
      _session2EndTime = _getTimeOfDayFromString(session2EndValue);
    }
  }

  void _initSession1Timings(
      String session1StartValue, String session1EndValue) {
    _session1StartController.dropDownValue =
        DropDownValueModel(name: session1StartValue, value: session1StartValue);
    _session1EndController.dropDownValue =
        DropDownValueModel(name: session1EndValue, value: session1EndValue);
    _session1StartTime = _getTimeOfDayFromString(session1StartValue);
    _session1EndTime = _getTimeOfDayFromString(session1EndValue);
  }

  void _initSelectedDuration(String timeSlot) {
    _selectedDuration = _convertServerTimeSlotToLocal(timeSlot);
  }

  void _initSelectedDays(List<GetTimeSlotsResponseDataEntity> list) {
    _selectedDays.clear();
    for (var element in list) {
      if (!_selectedDays.contains(element.day)) {
        _selectedDays.add(element.day ?? '');
      }
    }
  }

  void _updateFees(int fees) {
    context.read<SettingCubit>().updateAboutOrFees(fees: fees);
  }

  void _reInitSessionsValue() {
    _session1StartTime = null;
    _session1EndTime = null;
    _session2StartTime = null;
    _session2EndTime = null;
    _session1StartController.dropDownValue = null;
    _session1EndController.dropDownValue = null;
    _session2StartController.dropDownValue = null;
    _session2EndController.dropDownValue = null;
  }

  void _updateTimeOptions() {
    _timeOptions.clear();
    int duration = int.parse(_selectedDuration);
    const startHour = 6;
    TimeOfDay timeOfDay = const TimeOfDay(hour: startHour, minute: 0);
    for (int hour = startHour; hour < 24; hour++) {
      ///All the checks are for handling session duration > 60
      ///This check for for adding starting time like if doctor time starts from 6:00 Am
      if (duration > 60 && hour == startHour) {
        _timeOptions.add(timeOfDay);
        continue;
      } else if (duration > 60) {
        int hour = duration ~/ 60;
        int min = duration - (hour * 60);
        final testTime = TimeOfDay(
            hour: timeOfDay.hour + hour, minute: timeOfDay.minute + min);

        ///This condition will execute when our _selectedDuration would be 120 or greater than that (like 2,3,4,5 hours and so on )
        if (testTime.hour > 24) {
          break;
        }

        /// This check is for (if previous time is 6:30 and duration is 90 than our new time would be 8:00)
        if (timeOfDay.minute + min >= 60) {
          hour = hour + ((timeOfDay.minute + min) ~/ 60);
          min = 0;
          timeOfDay = TimeOfDay(hour: timeOfDay.hour + hour, minute: min);
          if (timeOfDay.hour >= 24 && timeOfDay.minute > 0) {
            break;
          }
          _timeOptions.add(timeOfDay);
          continue;
        }
        timeOfDay = TimeOfDay(
            hour: timeOfDay.hour + hour, minute: timeOfDay.minute + min);
        if (timeOfDay.hour >= 24 && timeOfDay.minute > 0) {
          break;
        }
        _timeOptions.add(timeOfDay);
        continue;
      }

      for (int minute = 0; minute < 60; minute += duration) {
        _timeOptions.add(TimeOfDay(hour: hour, minute: minute));
      }
    }
  }

  void _showToast({required String message}) {
    widget.showErrorToast(context: context, message: message);
  }

  int _getMinFromTime(TimeOfDay time) {
    return (time.hour * 60) + time.minute;
  }

  String get _getServerSlot {
    return '${_selectedDuration}_MINS';
  }

  /// This timeSlot (parameter) would be like this 30_MINS and we want to make it like 30
  String _convertServerTimeSlotToLocal(String timeSlot) {
    return timeSlot.split('_')[0];
  }

  List<String> _getTimeList({TimeOfDay? moreThan}) {
    return _timeOptions
        .where((element) => (element.hour > (moreThan?.hour ?? 0) ||
            (element.hour == (moreThan?.hour ?? 0)
                ? element.minute > (moreThan?.minute ?? 0)
                : false)))
        .map((e) =>
            '${e.hour.toString().padLeft(2, '0')}:${e.minute.toString().padLeft(2, '0')} ${e.period.name.toUpperCase()}')
        .toList();
  }

  TimeOfDay _getTimeOfDayFromString(String value) {
    List<String> parts = value.split(' ');
    List<String> timeParts = parts[0].split(':');
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);

    // Adjust hours for AM/PM
    // if (parts[1].toLowerCase() == 'pm') {
    //   hours += 12;
    // }

    return TimeOfDay(hour: hours, minute: minutes);
  }

  Widget _buildScheduleRow() {
    return Row(
      children: [
        component.assetImage(path: Assets.iconsCalendar),
        component.spacer(width: 4),
        component.text('Schedule',
            style: theme.publicSansFonts
                .semiBoldStyle(fontSize: 16, fontColor: AppColors.black21))
      ],
    );
  }

  Widget _buildDaysWidget() {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        clipBehavior: Clip.none,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) => _buildDay(text: _daysList[i]),
        separatorBuilder: (_, __) => component.spacer(width: 20),
        itemCount: _daysList.length,
      ),
    );
  }

  Widget _buildDay({
    required String text,
  }) {
    final isSelected = _selectedDays.contains(text);
    return InkWell(
      onTap: () {
        if (isSelected) {
          _selectedDays.remove(text);
        } else {
          _selectedDays.add(text);
        }
        setState(() {});
      },
      child: Container(
        width: 46,
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected
              ? AppColors.color0xFF8338EC
              : AppColors.color0xFFE8E9E9,
        ),
        child: component.text(text,
            style: theme.publicSansFonts.regularStyle(
              fontColor: isSelected
                  ? AppColors.color0xFFFEFEFE
                  : AppColors.color0xFF989898,
            )),
      ),
    );
  }

  Widget _buildTextField() {
    return SizedBox(
      height: 48,
      child: component.textField(
        controller: _feesController,
        fillColor: AppColors.white,
        textInputType: TextInputType.number,
        borderRadius: 90,
        filled: true,
        focusedBorderColor: AppColors.color0xFFDADCE0,
        borderColor: AppColors.color0xFFDADCE0,
      ),
    );
  }

  Widget _buildDropDown({
    String? hintText,
    double borderRadius = 90,
    required List<String> items,
    Function(String name)? value,
    Function(DropDownValueModel?)? onChanged,
    String? Function(String?)? validator,
    SingleValueDropDownController? controller,
  }) {
    return CustomDropdown(
        hintText: hintText,
        borderRadius: borderRadius,
        onChanged: onChanged,
        validator: validator,
        dropDownList: items
            .map((e) => DropDownValueModel(
                name: e, value: value != null ? value.call(e) : e))
            .toList(),
        controller: controller);
  }

  Widget _buildHeader({
    required String text,
  }) {
    return component.text(
      text,
      style: theme.publicSansFonts.mediumStyle(
        fontSize: 14,
        fontColor: AppColors.color0xFF40444C,
      ),
    );
  }
}
