import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/error/Failure.dart';
import '../models/online_dto.dart';
import '../sources/local/cache_manager.dart';
import '../sources/remote/api_service.dart';

class OnlineRepositoryImpl implements OnlineRepository {
  OnlineRepositoryImpl({required this.apiService, required this.cacheManager});

  final ApiService apiService;
  final CacheManager cacheManager;

  @override
  Future<Either<Failure, Online>> getOnline() async {
    try {
      final cachedData = await cacheManager.getData('online');
      if (cachedData != null) {
        return Right((cachedData as List)
            .map((e) => OnlineDto.fromJson(e).toDomain())
            .toList());
      }
      final response = await apiService.getCurOnline();
      // final online = response.map((dto) => dto.toDomain()).toList();

      await cacheManager.saveData(
        "photos",
        response.map((e) => e.toJson()).toList(),
      );

      return Right(photos);
    } on DioException catch (e) {
      return Left(ServerFailure("API error: ${e.message}"));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
