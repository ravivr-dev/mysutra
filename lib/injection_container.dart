import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_sutra/core/main_cubit/main_cubit.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/get_selected_account_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/select_account_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/verify_otp_usecase.dart';
import 'package:my_sutra/features/presentation/common/home/cubit/home_cubit.dart';
import 'package:my_sutra/features/presentation/common/login/cubit/select_account_cubit.dart';
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
  sl.registerFactory(() => OtpCubit(sl<LoginUsecase>(), sl<OtpUsecase>()));

  // UseCases
  sl.registerLazySingleton(() => LoginUsecase(sl<UserRepository>()));
  sl.registerLazySingleton(() => OtpUsecase(sl<UserRepository>()));
  sl.registerLazySingleton(() => SelectAccountUsecase(sl<UserRepository>()));
  sl.registerLazySingleton(
      () => GetSelectedAccountUsecase(sl<UserRepository>()));

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
