import '../models/news_categories_model.dart';
import '../repository/news_repository.dart';
import '../models/news_channels_headlines_model.dart';
class NewsViewModel {

  final _api = NewsRepository();
  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi() async {
    final response = await _api.fetchNewsChannelHeadlinesApi();
    return response;

  }

  Future<newsCategoriesModel> fetchCategoriesNewsApi(String category) async {
    final response = await _api.fetchCategoriesNewsApi(category);
    return response;

  }
}