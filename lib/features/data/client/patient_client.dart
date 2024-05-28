import 'package:dio/dio.dart';
import 'package:my_sutra/core/extension/custom_ext.dart';
import 'package:my_sutra/core/extension/dio_error.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/core/utils/endpoint_constants.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/data/model/patient_models/search_doctor_model.dart';
import 'package:retrofit/http.dart';

import '../model/patient_models/available_time_slot.dart';
import '../model/patient_models/get_appointment_response_model.dart';
import '../model/patient_models/schedule_appointment_response_model.dart';

part 'patient_client.g.dart';

/// Use below command to generate
/// fvm flutter pub run build_runner build --delete-conflicting-outputs

@RestApi()
abstract class PatientRestClient {
  factory PatientRestClient(
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
    return _PatientRestClient(
      dio,
      baseUrl: Constants.baseUrl,
    );
  }

  @GET(EndPoints.patientSearch)
  Future<SearchDoctorModel> searchDoctors(
    @Query("search") String? search,
    @Query("experience") int? experience,
    @Query("pagination") int? start,
    @Query("limit") int? limit,
    @Query("reviews") int? reviews,
    @Query("specializationId") String? specializationId,
  );

  @GET(EndPoints.availableSlots)
  Future<AvailableTimeSlotResponse> getAvailableSlots(
      @Queries() Map<String, dynamic> map);

  @GET('${EndPoints.doctorDetails}/{doctorId}')
  Future<dynamic> getDoctorDetails(@Path('doctorId') String doctorID);

  @POST(EndPoints.scheduleAppointment)
  Future<ScheduleAppointmentResponseModel> scheduleAppointment(
      @Body() Map<String, dynamic> data);

  @POST(EndPoints.confirmAppointment)
  Future<dynamic> confirmAppointment(@Body() Map<String, dynamic> data,
      @Header(Constants.authorization) token);

  @GET(EndPoints.appointments)
  Future<GetAppointmentResponseModel> getAppointments(
      @Queries() Map<String, dynamic> map);

  @POST(EndPoints.cancelAppointment)
  Future<dynamic> cancelAppointment(@Body() Map<String, dynamic> map);

  @GET(EndPoints.pastAppointment)
  Future<GetAppointmentResponseModel> pastAppointments(
      @Queries() Map<String, dynamic> map);
}
