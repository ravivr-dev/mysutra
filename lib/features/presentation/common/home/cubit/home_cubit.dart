import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/domain/entities/coach_entities/batch_entity.dart';
import 'package:my_sutra/features/domain/entities/user_entities/academy_center_entity.dart';
import 'package:my_sutra/features/domain/entities/user_entities/user_profile_entity.dart';


part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
final LocalDataSource localDataSource;
  HomeCubit(this.localDataSource) : super(HomeInitial());

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
