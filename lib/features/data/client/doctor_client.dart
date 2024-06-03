import 'package:dio/dio.dart';
import 'package:my_sutra/core/extension/custom_ext.dart';
import 'package:my_sutra/core/extension/dio_error.dart';
import 'package:my_sutra/core/utils/endpoint_constants.dart';
import 'package:my_sutra/features/data/model/doctor_models/get_bank_accounts_model.dart';
import 'package:my_sutra/features/data/model/doctor_models/get_bookings_model.dart';
import 'package:my_sutra/features/data/model/doctor_models/get_withdrawal_model.dart';
import 'package:my_sutra/features/data/model/patient_models/available_time_slot.dart';
import 'package:my_sutra/features/data/model/success_message_model.dart';
import 'package:retrofit/http.dart';
import '../../../core/utils/constants.dart';
import '../datasource/local_datasource/local_datasource.dart';
import '../model/doctor_models/get_doctor_appointment_model.dart';
import '../model/doctor_models/get_time_slots_response_model.dart';
import '../model/patient_models/get_patient_response_model.dart';
import '../model/user_models/home_response_model.dart';

part 'doctor_client.g.dart';

@RestApi()
abstract class DoctorClient {
  factory DoctorClient(
    final Dio dio,
    final LocalDataSource localDataSource,
  ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.addRequestOptions(localDataSource);
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          e.printErrorPath();
          return handler.next(e);
        },
      ),
    );
    return _DoctorClient(
      dio,
      baseUrl: Constants.baseUrl,
    );
  }

  @POST(EndPoints.timeSlots)
  Future<dynamic> updateTimeSlots(@Body() Map<String, dynamic> map);

  @PUT(EndPoints.profile)
  Future<dynamic> updateAboutOrFees(@Body() Map<String, dynamic> map);

  @GET(EndPoints.patients)
  Future<GetPatientResponseModel> getPatients(
      @Queries() Map<String, dynamic> map);

  @GET(EndPoints.timeSlots)
  Future<GetTimeSlotsResponseModel> getTimeSlots(
      @Queries() Map<String, dynamic> map);

  @GET(EndPoints.home)
  Future<HomeResponseModel> getUserDetails();

  @GET(EndPoints.doctorAppointments)
  Future<GetDoctorAppointmentModel> getAppointments(
    @Queries() Map<String, dynamic> map,
  );

  @POST(EndPoints.doctorAppointmentReSchedule)
  Future<SuccessMessageModel> rescheduleAppointment(
    @Body() Map<String, dynamic> map,
  );

  @POST(EndPoints.doctorAppointmentCancel)
  Future<SuccessMessageModel> cancelAppointment(
    @Body() Map<String, dynamic> map,
  );

  @GET(EndPoints.doctorAvailableSlots)
  Future<AvailableTimeSlotResponse> getAvailableSlots(
    @Queries() Map<String, dynamic> map,
  );

  @POST(EndPoints.createContact)
  Future<SuccessMessageModel> createPayoutContact(
      @Body() Map<String, dynamic> map);

  @POST(EndPoints.createFundAccount)
  Future<dynamic> createFundAccount(@Body() Map<String, Object> map);

  @POST(EndPoints.createUpi)
  Future<dynamic> createUpi(@Field('vpa') String upi);

  @GET(EndPoints.fundAccounts)
  Future<GetBankAccountsModel> getFundAccounts();

  @PATCH(EndPoints.fundAccounts)
  Future<dynamic> activateDeactivateBankAccount(
      @Body() Map<String, Object> map);

  @GET(EndPoints.payout)
  Future<GetWithdrawalModel> getWithdrawals(@Queries() Map<String, Object> map);

  @GET(EndPoints.payout)
  Future<GetBookingsModel> getBookings(@Queries() Map<String, Object> map);
}
