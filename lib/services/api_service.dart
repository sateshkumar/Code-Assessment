import 'package:bab_skill_assignment_task/models/news_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://api.nytimes.com/svc/topstories/v2')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/us.json?api-key=bKCE6SdSAX9SfUwNXKoZuziAnHbbHwrt')
  Future<NewsModel> getNews();
}
