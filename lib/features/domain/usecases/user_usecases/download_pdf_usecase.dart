import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

import '../../../../core/usecase/usecase.dart';

class DownloadPdfUseCase extends UseCase<String, DownloadPdfParams> {
  final UserRepository _userRepository;

  DownloadPdfUseCase(this._userRepository);

  @override
  Future<Either<Failure, String>> call(DownloadPdfParams params) {
    return _userRepository.downloadPdf(params);
  }
}

class DownloadPdfParams {
  final String url;

  const DownloadPdfParams({required this.url});
}
