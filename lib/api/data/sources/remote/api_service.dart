import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:servers_online_observer/api/data/models/online_dto.dart';
import 'package:servers_online_observer/api/data/sources/remote/endpoints.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET(Endpoints.getOnline)
  Future<List<OnlineDto>> getCurrentOnline();
}
