import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/exceptions.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/network/network_info.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/data/datasource/remote_datasource/article_datasource.dart';
import 'package:my_sutra/features/domain/repositories/article_repository.dart';
import 'package:my_sutra/features/domain/usecases/article_usecases/create_article_usecase.dart';

class ArticleRepositoryImpl extends ArticleRepository {
  final LocalDataSource localDataSource;
  final ArticleDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  ArticleRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDatasource,
      required this.networkInfo});

  @override
  Future<Either<Failure, String>> createArticle(
      CreateArticleParams params) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDatasource.createArticle(
            {"heading": params.heading, "content": params.content});

        return Right(result.message ?? 'New Article Created Success');
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
