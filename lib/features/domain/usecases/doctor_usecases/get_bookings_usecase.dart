import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/booking_entity.dart';
import 'package:my_sutra/features/domain/repositories/doctor_repository.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/get_withdrawals_usecase.dart';

class GetBookingsUseCase extends UseCase<List<BookingEntity>, GetPayoutParams> {
  final DoctorRepository _doctorRepository;

  GetBookingsUseCase(this._doctorRepository);

  @override
  Future<Either<Failure, List<BookingEntity>>> call(GetPayoutParams params) {
    return _doctorRepository.getBookings(params);
  }
}

