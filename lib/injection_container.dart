import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_sutra/core/components/config/theme/theme.dart';
import 'package:my_sutra/core/components/custom_widgets/custom_widgets.dart';
import 'package:my_sutra/core/config/my_shared_pref.dart';
import 'package:my_sutra/core/main_cubit/main_cubit.dart';
import 'package:my_sutra/core/network/network_info.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/data/client/article_client.dart';
import 'package:my_sutra/features/data/client/doctor_client.dart';
import 'package:my_sutra/features/data/client/patient_client.dart';
import 'package:my_sutra/features/data/client/post_client.dart';
import 'package:my_sutra/features/data/client/user_client.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/data/datasource/remote_datasource/article_datasource.dart';
import 'package:my_sutra/features/data/datasource/remote_datasource/doctor_datasource.dart';
import 'package:my_sutra/features/data/datasource/remote_datasource/firebase_datasource.dart';
import 'package:my_sutra/features/data/datasource/remote_datasource/patient_datasource.dart';
import 'package:my_sutra/features/data/datasource/remote_datasource/post_datasource.dart';
import 'package:my_sutra/features/data/datasource/remote_datasource/user_datasource.dart';
import 'package:my_sutra/features/data/repositories/article_repo/article_repository_impl.dart';
import 'package:my_sutra/features/data/repositories/doctor_repo/doctor_repository_impl.dart';
import 'package:my_sutra/features/data/repositories/patient_repo/patient_repository_impl.dart';
import 'package:my_sutra/features/data/repositories/post_repo/post_repository_impl.dart';
import 'package:my_sutra/features/data/repositories/user_repo/user_repository_impl.dart';
import 'package:my_sutra/features/domain/repositories/article_repository.dart';
import 'package:my_sutra/features/domain/repositories/chat_repository.dart';
import 'package:my_sutra/features/domain/repositories/doctor_repository.dart';
import 'package:my_sutra/features/domain/repositories/patient_repository.dart';
import 'package:my_sutra/features/domain/repositories/post_repository.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';
import 'package:my_sutra/features/domain/usecases/article_usecases/create_article_usecase.dart';
import 'package:my_sutra/features/domain/usecases/article_usecases/get_articles_usecase.dart';
import 'package:my_sutra/features/domain/usecases/chat_usecases/listen_messages_usecase.dart';
import 'package:my_sutra/features/domain/usecases/chat_usecases/listen_user_data_usecase.dart';
import 'package:my_sutra/features/domain/usecases/chat_usecases/send_message_usecase.dart';
import 'package:my_sutra/features/domain/usecases/chat_usecases/set_user_data_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/doctor_cancel_appointment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/doctor_reschedule_appointment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/get_available_slots_for_doctor_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/get_doctor_appointments_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/get_patient_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/get_time_slots_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/update_about_or_fees_usecase.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/update_time_slots_usecases.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/cancel_appointment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/confirm_appointment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/get_appointments_usecase.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/get_available_slots_for_patient_usecase.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/get_doctor_details_usecase.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/schedule_appointment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/search_doctor_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/create_post_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/delete_post_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/edit_post_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/get_comment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/get_post_detail_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/get_posts_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/like_dislike_comment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/like_dislike_post_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/like_dislike_reply_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/new_comment_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/new_reply_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/report_post_usecase.dart';
import 'package:my_sutra/features/domain/usecases/post_usecases/repost_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/change_email_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/change_phone_number_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/follow_user_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/generate_usernames_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/get_following_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/get_home_data_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/get_profile_details_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/get_selected_account_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/get_video_room_id_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/login_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/registration_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/select_account_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/specialisation_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/upload_document_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/verify_change_email_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/verify_change_phone_number_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/verify_otp_usecase.dart';
import 'package:my_sutra/features/presentation/article/cubit/article_cubit.dart';
import 'package:my_sutra/features/presentation/common/home/cubit/home_cubit.dart';
import 'package:my_sutra/features/presentation/common/login/cubit/login_cubit.dart';
import 'package:my_sutra/features/presentation/common/login/cubit/otp_cubit.dart';
import 'package:my_sutra/features/presentation/common/login/cubit/select_account_cubit.dart';
import 'package:my_sutra/features/presentation/common/profile_screen/bloc/profile_cubit.dart';
import 'package:my_sutra/features/presentation/common/registration/cubit/registration_cubit.dart';
import 'package:my_sutra/features/presentation/doctor_screens/setting_screen/bloc/setting_cubit.dart';
import 'package:my_sutra/features/presentation/patient/bloc/appointment_cubit.dart';
import 'package:my_sutra/features/presentation/patient/search/cubit/search_doctor_cubit.dart';
import 'package:my_sutra/features/presentation/post_screens/cubit/posts_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/data/repositories/chat_repo/chat_repository_impl.dart';
import 'features/presentation/common/chat_screen/chat_cubit/chat_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Blocs and Cubits

  sl.registerLazySingleton(() => MainCubit(sl<LocalDataSource>()));
  sl.registerFactory(() => HomeCubit(
        localDataSource: sl<LocalDataSource>(),
        getAppointmentUseCase: sl<GetAppointmentUseCase>(),
        getHomeDataUseCase: sl<GetHomeDataUseCase>(),
        getDoctorAppointmentUseCase: sl<GetDoctorAppointmentsUseCase>(),
        doctorCancelAppointmentsUseCase: sl<DoctorCancelAppointmentsUseCase>(),
        getAvailableSlotsForDoctorUseCase:
            sl<GetAvailableSlotsForDoctorUseCase>(),
        doctorRescheduleAppointmentsUseCase:
            sl<DoctorRescheduleAppointmentsUseCase>(),
        getVideoRoomIdUseCase: sl<GetVideoRoomIdUseCase>(),
      ));
  sl.registerFactory(() => LoginCubit(sl<LoginUsecase>()));
  sl.registerFactory(() => SelectAccountCubit(
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
        followDoctorUseCase: sl<FollowUserUseCase>(),
        getDoctorDetailsUseCase: sl<GetDoctorDetailsUseCase>(),
      ));
  sl.registerFactory(() => SettingCubit(
      updateTimeSlotsUseCase: sl<UpdateTimeSlotsUseCase>(),
      updateAboutOrFeesUseCase: sl<UpdateAboutOrFeesUseCase>(),
      getTimeSlotsUseCase: sl<GetTimeSlotsUseCase>()));
  sl.registerFactory(() => AppointmentCubit(
      getAvailableSlotsUseCase: sl<GetAvailableSlotsForPatientUseCase>(),
      scheduleAppointmentUseCase: sl<ScheduleAppointmentUseCase>(),
      confirmAppointmentUseCase: sl<ConfirmAppointmentUseCase>(),
      cancelAppointmentUseCase: sl<CancelAppointmentUseCase>()));
  sl.registerFactory(() => ProfileCubit(
        getFollowingUseCase: sl<GetFollowingUseCase>(),
        getProfileDetailsUseCase: sl<GetProfileDetailsUseCase>(),
        getPatientUseCaseUseCase: sl<GetPatientUseCaseUseCase>(),
        changeEmailUseCase: sl<ChangeEmailUseCase>(),
        verifyChangeEmailUseCase: sl<VerifyChangeEmailUseCase>(),
        changePhoneNumberUseCase: sl<ChangePhoneNumberUseCase>(),
        verifyChangePhoneNumberUseCase: sl<VerifyChangePhoneNumberUseCase>(),
      ));
  sl.registerFactory(() => ChatCubit(
        listenMessagesUseCase: sl<ListenMessagesUseCase>(),
        sendMessageUseCase: sl<SendMessageUseCase>(),
        listenRoomUseCase: sl<ListenUserDataUseCase>(),
        setUserDataUseCase: sl<SetUserDataUseCase>(),
      ));
  sl.registerFactory(() => PostsCubit(
        uploadDocumentUsecase: sl<UploadDocumentUsecase>(),
        createPostUsecase: sl<CreatePostUsecase>(),
        likeUnlikePostUsecase: sl<LikeDislikePostUsecase>(),
        getPostsUsecase: sl<GetPostsUsecase>(),
        getPostDetailUsecase: sl<GetPostDetailUsecase>(),
        getCommentUsecase: sl<GetCommentUsecase>(),
        newCommentUsecase: sl<NewCommentUsecase>(),
        newReplyUsecase: sl<NewReplyUsecase>(),
        likeDislikeCommentUsecase: sl<LikeDislikeCommentUsecase>(),
        likeDislikeReplyUsecase: sl<LikeDislikeReplyUsecase>(),
        reportPostUsecase: sl<ReportPostUsecase>(),
        rePostUsecase: sl<RePostUsecase>(),
        deletePostUsecase: sl<DeletePostUsecase>(),
        editPostUsecase: sl<EditPostUsecase>(),
      ));
  sl.registerFactory(() => ArticleCubit(
      getArticlesUsecase: sl<GetArticlesUsecase>(),
      createArticleUsecase: sl<CreateArticleUsecase>()));

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
  sl.registerFactory(() => FollowUserUseCase(sl<UserRepository>()));
  sl.registerFactory(() => UpdateTimeSlotsUseCase(sl<DoctorRepository>()));
  sl.registerFactory(() => UpdateAboutOrFeesUseCase(sl<DoctorRepository>()));
  sl.registerFactory(() => GetDoctorDetailsUseCase(sl<PatientRepository>()));
  sl.registerFactory(
      () => GetAvailableSlotsForPatientUseCase(sl<PatientRepository>()));
  sl.registerFactory(
      () => GetAvailableSlotsForDoctorUseCase(sl<DoctorRepository>()));
  sl.registerFactory(() => ScheduleAppointmentUseCase(sl<PatientRepository>()));
  sl.registerFactory(() => ConfirmAppointmentUseCase(sl<PatientRepository>()));
  sl.registerFactory(() => CancelAppointmentUseCase(sl<PatientRepository>()));
  sl.registerFactory(() => GetProfileDetailsUseCase(sl<UserRepository>()));
  sl.registerFactory(() => GetFollowingUseCase(sl<UserRepository>()));
  sl.registerFactory(() => GetTimeSlotsUseCase(sl<DoctorRepository>()));
  sl.registerFactory(() => GetPatientUseCaseUseCase(sl<DoctorRepository>()));
  sl.registerLazySingleton(
      () => GenerateUsernamesUseCase(sl<UserRepository>()));
  sl.registerFactory(() => GetAppointmentUseCase(sl<PatientRepository>()));
  sl.registerFactory(() => GetHomeDataUseCase(sl<UserRepository>()));
  sl.registerFactory(
      () => GetDoctorAppointmentsUseCase(sl<DoctorRepository>()));
  sl.registerLazySingleton(() => ChangeEmailUseCase(sl<UserRepository>()));
  sl.registerLazySingleton(
      () => VerifyChangeEmailUseCase(sl<UserRepository>()));
  sl.registerLazySingleton(
      () => ChangePhoneNumberUseCase(sl<UserRepository>()));
  sl.registerLazySingleton(
      () => VerifyChangePhoneNumberUseCase(sl<UserRepository>()));
  sl.registerFactory(
      () => DoctorCancelAppointmentsUseCase(sl<DoctorRepository>()));
  sl.registerFactory(
      () => DoctorRescheduleAppointmentsUseCase(sl<DoctorRepository>()));
  sl.registerFactory(() => SendMessageUseCase(sl<ChatRepository>()));
  sl.registerFactory(() => ListenMessagesUseCase(sl<ChatRepository>()));
  sl.registerFactory(() => GetVideoRoomIdUseCase(sl<UserRepository>()));
  sl.registerFactory(() => ListenUserDataUseCase(sl<ChatRepository>()));
  sl.registerFactory(() => SetUserDataUseCase(sl<ChatRepository>()));

  sl.registerFactory(() => CreatePostUsecase(sl<PostRepository>()));
  sl.registerFactory(() => GetPostsUsecase(sl<PostRepository>()));
  sl.registerFactory(() => GetPostDetailUsecase(sl<PostRepository>()));
  sl.registerFactory(() => GetCommentUsecase(sl<PostRepository>()));
  sl.registerFactory(() => LikeDislikePostUsecase(sl<PostRepository>()));
  sl.registerFactory(() => NewCommentUsecase(sl<PostRepository>()));
  sl.registerFactory(() => NewReplyUsecase(sl<PostRepository>()));
  sl.registerFactory(() => LikeDislikeCommentUsecase(sl<PostRepository>()));
  sl.registerFactory(() => LikeDislikeReplyUsecase(sl<PostRepository>()));
  sl.registerLazySingleton(() => ReportPostUsecase(sl<PostRepository>()));
  sl.registerFactory(() => RePostUsecase(sl<PostRepository>()));
  sl.registerFactory(() => DeletePostUsecase(sl<PostRepository>()));
  sl.registerFactory(() => EditPostUsecase(sl<PostRepository>()));
  sl.registerFactory(() => CreateArticleUsecase(sl<ArticleRepository>()));
  sl.registerFactory(() => GetArticlesUsecase(sl<ArticleRepository>()));

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
  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(
      localDataSource: sl<LocalDataSource>(),
      remoteDatasource: sl<PostDatasource>(),
      networkInfo: sl<NetworkInfo>()));
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(
        dataSource: sl<FirebaseDataSource>(), networkInfo: sl<NetworkInfo>()),
  );
  sl.registerLazySingleton<ArticleRepository>(() => ArticleRepositoryImpl(
      localDataSource: sl<LocalDataSource>(),
      remoteDatasource: sl<ArticleDatasource>(),
      networkInfo: sl<NetworkInfo>()));

  /// DataSource
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sl<MySharedPref>()));
  sl.registerLazySingleton<UserDataSource>(() => UserDataSourceImpl(
      client: sl<UserRestClient>(), localDataSource: sl<LocalDataSource>()));
  sl.registerLazySingleton<PatientDataSource>(() => PatientDataSourceImpl(
      client: sl<PatientRestClient>(), localDataSource: sl<LocalDataSource>()));
  sl.registerLazySingleton<DoctorDataSource>(() => DoctorDataSourceImpl(
      client: sl<DoctorClient>(), localDataSource: sl<LocalDataSource>()));
  sl.registerLazySingleton<PostDatasource>(() => PostDatasourceImpl(
      client: sl<PostRestClient>(), localDataSource: sl<LocalDataSource>()));
  sl.registerLazySingleton<FirebaseDataSource>(() => FirebaseDataSourceImpl());
  sl.registerLazySingleton<ArticleDatasource>(() => ArticleDatasourceImpl(
      client: sl<ArticleRestClient>(), localDataSource: sl<LocalDataSource>()));

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
  sl.registerLazySingleton<PostRestClient>(() => PostRestClient(dio, sl()));
  sl.registerLazySingleton<ArticleRestClient>(
      () => ArticleRestClient(dio, sl()));
}
