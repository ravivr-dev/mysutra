import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_sutra/core/main_cubit/main_cubit.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/batches_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/my_academy_centers_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/user_profile_usecase.dart';
import 'package:my_sutra/features/presentation/pages/common/home/cubit/home_cubit.dart';
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
import 'package:my_sutra/features/domain/usecases/user_usecases/academy_centers_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/change_email_otp_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/change_email_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/change_phone_otp_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/change_phone_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/checkin_status_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/checkin_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/checkout_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/get_batch_students_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/login_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/mark_attendance_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/training_program_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/verify_otp_usecase.dart';
import 'package:my_sutra/features/presentation/pages/coach/attendance/cubit/attendance_cubit.dart';
import 'package:my_sutra/features/presentation/pages/coach/dashboard/cubit/dashboard_cubit.dart';
import 'package:my_sutra/features/presentation/pages/coach/my_batches/cubit/my_batches_cubit.dart';
import 'package:my_sutra/features/presentation/pages/common/login/cubit/login_cubit.dart';
import 'package:my_sutra/features/presentation/pages/common/login/cubit/otp_cubit.dart';
import 'package:my_sutra/features/presentation/pages/common/profile/cubit/profile_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Blocs and Cubits

  sl.registerLazySingleton(() => MainCubit(sl<LocalDataSource>()));
  sl.registerFactory(() => HomeCubit(sl<MyAcademyCenterUsecase>(),
      sl<MyBatchesUsecase>(), sl<LocalDataSource>(), sl<UserProfileUsecase>()));
  sl.registerFactory(
      () => LoginCubit(sl<AcademyCenterUsecase>(), sl<LoginUsecase>()));
  sl.registerLazySingleton(() => MyBatchesCubit(sl<TrainingProgramUsecase>()));
  // sl.registerLazySingleton(() => MyBatchesCubit(sl<MyAcademyCenterUsecase>()));
  sl.registerFactory(() => DashboardCubit(
      sl<CheckinUsecase>(),
      sl<CheckoutUsecase>(),
      sl<CheckinStatusUsecase>(),
      sl<MyBatchesUsecase>(),
      sl<LocalDataSource>()));
  sl.registerFactory(
      () => OtpCubit(sl<LoginUsecase>(), sl<VerifyOtpUsecase>()));
  sl.registerLazySingleton(() => ProfileCubit(
      sl<UserProfileUsecase>(),
      sl<ChangePhoneUsecase>(),
      sl<ChangeEmailUsecase>(),
      sl<ChangePhoneOtpUsecase>(),
      sl<ChangeEmailOtpUsecase>()));
  sl.registerLazySingleton(() => AttendanceCubit(
      sl<GetBatchStudentsUsecase>(), sl<MarkAttendanceUsecase>()));

  // UseCases
  sl.registerLazySingleton(() => AcademyCenterUsecase(sl<UserRepository>()));
  sl.registerLazySingleton(() => LoginUsecase(sl<UserRepository>()));
  sl.registerLazySingleton(() => VerifyOtpUsecase(sl<UserRepository>()));
  sl.registerLazySingleton(() => MyAcademyCenterUsecase(sl<UserRepository>()));
  sl.registerLazySingleton(() => MyBatchesUsecase(sl<UserRepository>()));
  sl.registerLazySingleton(() => TrainingProgramUsecase(sl<UserRepository>()));
  sl.registerLazySingleton(() => CheckinUsecase(sl<UserRepository>()));
  sl.registerLazySingleton(() => CheckoutUsecase(sl<UserRepository>()));
  sl.registerLazySingleton(() => UserProfileUsecase(sl<UserRepository>()));
  sl.registerLazySingleton(() => ChangeEmailUsecase(sl<UserRepository>()));
  sl.registerLazySingleton(() => ChangeEmailOtpUsecase(sl<UserRepository>()));
  sl.registerLazySingleton(() => ChangePhoneUsecase(sl<UserRepository>()));
  sl.registerLazySingleton(() => ChangePhoneOtpUsecase(sl<UserRepository>()));
  sl.registerLazySingleton(() => GetBatchStudentsUsecase(sl<UserRepository>()));
  sl.registerLazySingleton(() => MarkAttendanceUsecase(sl<UserRepository>()));
  sl.registerLazySingleton(() => CheckinStatusUsecase(sl<UserRepository>()));

  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      localDataSource: sl<LocalDataSource>(),
      remoteDataSource: sl<UserDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  /// DataSource
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sl<MySharedPref>()));
  sl.registerLazySingleton<UserDataSource>(
      () => UserDataSourceImpl(client: sl(), localDataSource: sl()));

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

  // final dbProvider = DBProvider();

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  // sl.registerLazySingleton<DBProvider>(() => dbProvider);
  //sl.registerLazySingleton(() => EventClient(dio, sl()));

  sl.registerLazySingleton(() => InternetConnectionChecker());
  // sl.registerLazySingleton<MySharedPref>(() => MySharedPref(sl()));
  // sl.registerLazySingleton<LocalDataSource>(
  //   () => LocalDataSourceImpl(mySharedPref: sl(), dbProvider: sl()),
  // );
  // sl.registerLazySingleton(
  //   () => MyRemoteConfig(/*remoteConfig*/
  //       ),
  // );
  sl.registerLazySingleton<UserRestClient>(() => UserRestClient(dio, sl()));
}
