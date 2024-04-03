import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/domain/entities/coach_entities/batch_entity.dart';
import 'package:my_sutra/features/domain/entities/user_entities/academy_center_entity.dart';
import 'package:my_sutra/features/domain/entities/user_entities/user_profile_entity.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/batches_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/my_academy_centers_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/user_profile_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final MyAcademyCenterUsecase academyCenterUsecase;
  final MyBatchesUsecase batchesUsecase;
  final LocalDataSource localDataSource;
  final UserProfileUsecase userProfileUsecase;
  HomeCubit(this.academyCenterUsecase, this.batchesUsecase,
      this.localDataSource, this.userProfileUsecase)
      : super(HomeInitial());

  initialDataLoader() async {
    getUserRole();
    await getProfileData();
    await getMyAcademyCenters();
    await getMyBatches();
  }

  List<BatchItem> batches = [];
  List<AcademyCenter> academies = [];

  AcademyCenter? currentAcademy;
  String? userRole;
  UserProfileEntity? userData;

  getMyAcademyCenters() async {
    final result =
        await academyCenterUsecase(GetAcademyParams(limit: 100, pageNumber: 1));

    result.fold((l) => _emitFailure(l), (data) {
      academies = data;
      String? academyId = localDataSource.getCurrentAcademy();

      emit(AcademyCentersLoaded(data));
      if (data.isNotEmpty) {
        AcademyCenter currentCenter = data.firstWhere(
            (element) => academyId == element.id,
            orElse: () => data.first);

        changeAcademy(currentCenter);
      }
    });
  }

  changeAcademy(AcademyCenter data) {
    currentAcademy = data;
    emit(ChangeAcademy(data));
  }

  getMyBatches() async {
    final result =
        await batchesUsecase(GetBatchesParams(limit: 100, pageNumber: 1));

    result.fold((l) => _emitFailure(l), (data) {
      batches = data;
      emit(MyBatchesLoaded(data));
    });
  }

  getProfileData() async {
    final result = await userProfileUsecase(NoParams());
    result.fold((l) => _emitFailure(l), (data) {
      userData = data;
      emit(UserProfileState(data));
    });
  }

  getUserRole() {
    userRole = localDataSource.getUserRole();
  }

  FutureOr<void> _emitFailure(
    Failure failure,
  ) async {
    if (failure is ServerFailure) {
      emit(HomeError(failure.message));
    } else if (failure is CacheFailure) {
      emit(HomeError(failure.message));
    } else {
      emit(HomeError(failure.message));
    }
  }
}
