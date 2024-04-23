import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_sutra/core/main_cubit/main_cubit.dart';
import 'package:my_sutra/features/data/client/doctor_client.dart';
import 'package:my_sutra/features/data/client/patient_client.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/data/datasource/remote_datasource/doctor_datasource.dart';
import 'package:my_sutra/features/data/datasource/remote_datasource/patient_datasource.dart';
import 'package:my_sutra/features/data/repositories/doctor_repo/doctor_repository_impl.dart';
import 'package:my_sutra/features/data/repositories/patient_repo/patient_repository_impl.dart';
import 'package:my_sutra/features/domain/repositories/doctor_repository.dart';
import 'package:my_sutra/features/domain/repositories/patient_repository.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/get_patient_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/get_time_slots_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/update_about_or_fees_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/update_time_slots_usecases.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/confirm_appointment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/follow_doctor_usecase.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/get_available_slots_usecase.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/get_doctor_details_usecase.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/schedule_appointment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/search_doctor_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/generate_usernames_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/get_profile_details_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/get_selected_account_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/registration_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/select_account_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/specialisation_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/upload_document_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/verify_otp_usecase.dart';
import 'package:my_sutra/features/presentation/common/home/cubit/home_cubit.dart';
import 'package:my_sutra/features/presentation/common/login/cubit/select_account_cubit.dart';
import 'package:my_sutra/features/presentation/common/profile_screen/bloc/profile_cubit.dart';
import 'package:my_sutra/features/presentation/common/registration/cubit/registration_cubit.dart';
import 'package:my_sutra/features/presentation/doctor_screens/setting_screen/bloc/setting_cubit.dart';
import 'package:my_sutra/features/presentation/patient/bloc/appointment_cubit.dart';
import 'package:my_sutra/features/presentation/patient/search/cubit/search_doctor_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_sutra/core/components/config/theme/theme.dart';
import 'package:my_sutra/core/components/custom_widgets/custom_widgets.dart';
import 'package:my_sutra/core/config/my_shared_pref.dart';
import 'package:my_sutra/core/network/network_info.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/data/client/user_client.dart';
import 'package:my_sutra/features/data/datasource/remote_datasource/user_datasource.dart';
import 'package:my_sutra/features/data/repositories/user_repo/user_repository_impl.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/login_usecase.dart';
import 'package:my_sutra/features/presentation/common/login/cubit/login_cubit.dart';
import 'package:my_sutra/features/presentation/common/login/cubit/otp_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Blocs and Cubits

  sl.registerLazySingleton(() => MainCubit(sl<LocalDataSource>()));
  sl.registerFactory(() => HomeCubit(sl<LocalDataSource>()));
  sl.registerFactory(() => LoginCubit(sl<LoginUsecase>()));
  sl.registerLazySingleton(() => SelectAccountCubit(
      sl<SelectAccountUsecase>(), sl<GetSelectedAccountUsecase>()));
  sl.registerFactory(() => OtpCubit(
      sl<LoginUsecase>(), sl<OtpUsecase>(), sl<RegistrationUsecase>()));
  sl.registerFactory(() => RegistrationCubit(
      sl<SpecialisationUsecase>(),
      sl<RegistrationUsecase>(),
      sl<UploadDocumentUsecase>(),
      sl<GenerateUsernamesUseCase>()));
  sl.registerFactory(() => SearchDoctorCubit(
        searchDoctorUsecase: sl<SearchDoctorUsecase>(),
        followDoctorUseCase: sl<FollowDoctorUseCase>(),
        getDoctorDetailsUseCase: sl<GetDoctorDetailsUseCase>(),
      ));
  sl.registerFactory(() => SettingCubit(
      updateTimeSlotsUseCase: sl<UpdateTimeSlotsUseCase>(),
      updateAboutOrFeesUseCase: sl<UpdateAboutOrFeesUseCase>(),
      getTimeSlotsUseCase: sl<GetTimeSlotsUseCase>()));
  sl.registerFactory(() => AppointmentCubit(
      getAvailableSlotsUseCase: sl<GetAvailableSlotsUseCase>(),
      scheduleAppointmentUseCase: sl<ScheduleAppointmentUseCase>(),
      confirmAppointmentUseCase: sl<ConfirmAppointmentUseCase>()));
  sl.registerFactory(() => ProfileCubit(
      getProfileDetailsUseCase: sl<GetProfileDetailsUseCase>(),
      getPatientUseCaseUseCase: sl<GetPatientUseCaseUseCase>()));

  // UseCases
  sl.registerLazySingleton(() => LoginUsecase(sl<UserRepository>()));
  sl.registerLazySingleton(() => OtpUsecase(sl<UserRepository>()));
  sl.registerLazySingleton(() => SelectAccountUsecase(sl<UserRepository>()));
  sl.registerLazySingleton(
      () => GetSelectedAccountUsecase(sl<UserRepository>()));
  sl.registerLazySingleton(() => SpecialisationUsecase(sl<UserRepository>()));
  sl.registerLazySingleton(() => RegistrationUsecase(sl<UserRepository>()));
  sl.registerLazySingleton(() => UploadDocumentUsecase(sl<UserRepository>()));
  sl.registerFactory(() => SearchDoctorUsecase(sl<PatientRepository>()));
  sl.registerFactory(() => FollowDoctorUseCase(sl<PatientRepository>()));
  sl.registerFactory(() => UpdateTimeSlotsUseCase(sl<DoctorRepository>()));
  sl.registerFactory(() => UpdateAboutOrFeesUseCase(sl<DoctorRepository>()));
  sl.registerFactory(() => GetDoctorDetailsUseCase(sl<PatientRepository>()));
  sl.registerFactory(() => GetAvailableSlotsUseCase(sl<PatientRepository>()));
  sl.registerFactory(() => ScheduleAppointmentUseCase(sl<PatientRepository>()));
  sl.registerFactory(() => ConfirmAppointmentUseCase(sl<PatientRepository>()));
  sl.registerFactory(() => GetProfileDetailsUseCase(sl<UserRepository>()));
  sl.registerFactory(() => GetTimeSlotsUseCase(sl<DoctorRepository>()));
  sl.registerFactory(() => GetPatientUseCaseUseCase(sl<DoctorRepository>()));
  sl.registerLazySingleton(
      () => GenerateUsernamesUseCase(sl<UserRepository>()));

  /// Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      localDataSource: sl<LocalDataSource>(),
      remoteDataSource: sl<UserDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );
  sl.registerLazySingleton<PatientRepository>(
    () => PatientRepositoryImpl(
      localDataSource: sl<LocalDataSource>(),
      remoteDataSource: sl<PatientDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );
  sl.registerLazySingleton<DoctorRepository>(() => DoctorRepositoryImpl(
        localDataSource: sl<LocalDataSource>(),
        remoteDataSource: sl<DoctorDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ));

  /// DataSource
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sl<MySharedPref>()));
  sl.registerLazySingleton<UserDataSource>(() => UserDataSourceImpl(
      client: sl<UserRestClient>(), localDataSource: sl<LocalDataSource>()));
  sl.registerLazySingleton<PatientDataSource>(() => PatientDataSourceImpl(
      client: sl<PatientRestClient>(), localDataSource: sl<LocalDataSource>()));
  sl.registerLazySingleton<DoctorDataSource>(() => DoctorDataSourceImpl(
      client: sl<DoctorClient>(), localDataSource: sl<LocalDataSource>()));

  sl.registerLazySingleton<AppTheme>(() => AppTheme());
  sl.registerLazySingleton<CustomWidgets>(() => CustomWidgets());

  /// Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<MySharedPref>(() => MySharedPref(sl()));

  /// initializing dio
  final dio = Dio(
    BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: const Duration(milliseconds: 500000),
      receiveTimeout: const Duration(milliseconds: 500000),
      sendTimeout: const Duration(milliseconds: 500000),
    ),
  );
  dio.interceptors.add(
    LogInterceptor(
      request: true,
      responseHeader: true,
      logPrint: (value) => log(value.toString()),
      responseBody: true,
      requestBody: true,
      requestHeader: true,
      error: true,
    ),
  );

  ///Others
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerLazySingleton<UserRestClient>(() => UserRestClient(dio, sl()));
  sl.registerLazySingleton<PatientRestClient>(
      () => PatientRestClient(dio, sl()));
  sl.registerLazySingleton<DoctorClient>(() => DoctorClient(dio, sl()));
}
