part of 'package:my_sutra/features/presentation/common/home/screens/reschedule_appointment_screen.dart';

class _DoctorRescheduleState extends _RescheduleAppointmentScreenState {
  final DateFormat _serverDateFormat = DateFormat('yyyy-MM-dd');
  DateTime _selectedDate = DateTime.now();
  final GlobalKey<FormState> _formKey = GlobalKey();
  List<AvailableTimeSlotEntity> _availableTImeSlots = [];
  String? _selectedTimeSlot;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getAvailableTimeSlotsForDoctor(_serverDateFormat.format(_selectedDate));
    });
    super.initState();
  }

  void _initSelectedDate(DateTime dateTime) {
    _selectedDate = dateTime;
    _getAvailableTimeSlotsForDoctor(_serverDateFormat.format(_selectedDate));
  }

  void _getAvailableTimeSlotsForDoctor(String date) {
    context.read<HomeCubit>().getAvailableTimeSlotsForDoctors(date: date);
  }

  Widget _buildText({required String value, double? fontSize}) {
    return component.text(value,
        style: theme.publicSansFonts.mediumStyle(fontSize: fontSize));
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

  void _showToast({required String message}) {
    widget.showErrorToast(context: context, message: message);
  }

  void _rescheduleAppointment() {
    context.read<HomeCubit>().rescheduleAppointmentForDoctor(
        appointmentId: widget.appointmentId,
        date: _serverDateFormat.format(_selectedDate),
        time: _selectedTimeSlot!);
  }

  @override
  Widget _buildBody(HomeState state) {
    if (state is GetAvailableSlotsLoadedState) {
      _availableTImeSlots = state.availableSlots;
    }
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WeekPicker(
                onDateTimeSelected: (dateTime) {
                  _initSelectedDate(dateTime);
                },
              ),
              component.spacer(height: 24),
              _buildText(value: context.stringForKey(StringKeys.availableTime)),
              component.spacer(height: 16),
              Wrap(
                  spacing: 8,
                  runSpacing: 12,
                  children: List.generate(_availableTImeSlots.length,
                      (index) => _buildTimeWidget(_availableTImeSlots[index]))),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: CustomButton(
          text: 'Reschedule',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (_selectedTimeSlot == null) {
                _showToast(message: 'Please Select Available Time');
                return;
              }
              _rescheduleAppointment();
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
