part of 'dashboard_cubit.dart';

sealed class DashboardState {}

class DashboardInitial extends DashboardState {}

class CinLoading extends DashboardState {}

class CinLoaded extends DashboardState {
  final String message;

  CinLoaded(this.message);
}

class CoutLoaded extends DashboardState {
  final String message;

  CoutLoaded(this.message);
}

class DashboardError extends DashboardState {
  final String error;

  DashboardError(this.error);
}

class CheckinStatusState extends DashboardState {
  final CheckinEntity data;

  CheckinStatusState(this.data);
}

class UpdateBatchesState extends DashboardState {}

class LocationState extends DashboardState {}
