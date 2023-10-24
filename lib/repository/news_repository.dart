import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/news_categories_model.dart';
import '../models/news_channels_headlines_model.dart';

class NewsRepository{

  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi () async {

    // String url = 'https://newsapi.org/v2/everything?q=general&apiKey=cb90dc64f8294d8aa24bfc43a890e430';
    String url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=cb90dc64f8294d8aa24bfc43a890e430';
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (kDebugMode) {
        print(body);
      }
      return NewsChannelHeadlinesModel.fromJson(body);
    }
    throw Exception('Something went wrong');
  }

  Future<newsCategoriesModel> fetchCategoriesNewsApi (String category) async {

    String url = 'https://newsapi.org/v2/everything?q=${category}&apiKey=cb90dc64f8294d8aa24bfc43a890e430';
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (kDebugMode) {
        print(body);
      }
      return newsCategoriesModel.fromJson(body);
    }
    throw Exception('Something went wrong');
  }

}