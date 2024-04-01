import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/domain/entities/coach_entities/batch_entity.dart';
import 'package:my_sutra/features/domain/entities/coach_entities/checkin_entity.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/batches_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/checkin_status_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/checkin_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/checkout_usecase.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final CheckinUsecase checkinUsecase;
  final CheckoutUsecase checkoutUsecase;
  final CheckinStatusUsecase checkinStatusUscase;
  final MyBatchesUsecase batchesUsecase;
  final LocalDataSource localDataSource;

  DashboardCubit(
    this.checkinUsecase,
    this.checkoutUsecase,
    this.checkinStatusUscase,
    this.batchesUsecase,
    this.localDataSource,
  ) : super(DashboardInitial());

  List<CheckinItem> checkinRecords = [];
  String? currentCheckInBatchId;
  List<BatchItem> batches = [];
  String? location;
  String? userName;

  void checkIn() async {
    final result = await checkinUsecase(NoParams());
    result.fold(
      (l) => _emitFailure(l),
      (data) => emit(
        CinLoaded(data),
      ),
    );
  }

  void getCheckinStatus() async {
    final result = await checkinStatusUscase(PaginationParams());
    result.fold(
      (l) => _emitFailure(l),
      (data) {
        checkinRecords = data.items;
        currentCheckInBatchId = data.currentCheckingBatchId;
        emit(CheckinStatusState(data));
      },
    );
  }

  void getMyBatches() async {
    final result =
        await batchesUsecase(GetBatchesParams(limit: 100, pageNumber: 1));

    result.fold((l) => _emitFailure(l), (data) {
      batches = data;
      emit(UpdateBatchesState());
    });
  }

  void checkOut() async {
    final result = await checkoutUsecase(NoParams());
    result.fold(
      (l) => _emitFailure(l),
      (data) => emit(
        CoutLoaded(data),
      ),
    );
  }

  void setLocation(String? val) {
    location = val;
    emit(LocationState());
  }

  String getUserNaem() {
    return userName ?? localDataSource.getUsername();
  }

  FutureOr<void> _emitFailure(
    Failure failure,
  ) async {
    if (failure is ServerFailure) {
      emit(DashboardError(failure.message));
    } else if (failure is CacheFailure) {
      emit(DashboardError(failure.message));
    } else {
      emit(DashboardError(failure.message));
    }
  }
}
