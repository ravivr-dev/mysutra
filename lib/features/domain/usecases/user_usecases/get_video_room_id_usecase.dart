import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

import '../../entities/user_entities/video_room_response_entity.dart';

class GetVideoRoomIdUseCase
    extends UseCase<VideoRoomResponseEntity, GetVideoRoomIdUseCaseParams> {
  final UserRepository repo;

  GetVideoRoomIdUseCase(this.repo);

  @override
  Future<Either<Failure, VideoRoomResponseEntity>> call(
      GetVideoRoomIdUseCaseParams params) async {
    return repo.getVideoRoomId(params);
  }
}

class GetVideoRoomIdUseCaseParams {
  final String appointmentId;

  GetVideoRoomIdUseCaseParams({
    required this.appointmentId,
  });
}
