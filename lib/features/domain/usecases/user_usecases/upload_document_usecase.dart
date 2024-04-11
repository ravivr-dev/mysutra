import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/data/model/user_models/upload_doc_model.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class UploadDocumentUsecase extends UseCase<UploadDocModel, File> {
  final UserRepository repo;

  UploadDocumentUsecase(this.repo);

  @override
  Future<Either<Failure, UploadDocModel>> call(File params) async {
    return await repo.uploadDocument(params);
  }
}
