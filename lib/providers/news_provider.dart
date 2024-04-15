import 'package:bab_skill_assignment_task/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/news_model.dart';

part 'news_provider.freezed.dart';

@freezed
class NewsState with _$NewsState {
  const factory NewsState({
    @Default(true) bool isLoading,
    @Default(true) bool isList,
    @Default(true) bool fromName,
    required NewsModel newsModel,
  }) = _NewsState;

  const NewsState._();
}

class NewsNotifier extends StateNotifier<NewsState> {
  NewsNotifier() : super(NewsState(newsModel: NewsModel(results: []))) {
    loadNews();
  }

  loadNews() async {
    state = state.copyWith(isLoading: true);

    try {
      final dio = Dio(); // Provide a dio instance
      dio.options.headers['Demo-Header'] =
          'demo header'; // config your dio headers globally
      final client = ApiService(dio);
      final news = await client.getNews();

      state = state.copyWith(newsModel: news, isLoading: false);
    } catch (e) {
      state =
          state.copyWith(newsModel: NewsModel(results: []), isLoading: false);
    }
  }

  loadSearchedNews(String title, NewsModel newsModel) async {
    state = state.copyWith(isLoading: true);

    if (state.fromName) {
      newsModel.results!.retainWhere((element) =>
          element.title!.toLowerCase().startsWith(title.toLowerCase()));
    } else {
      newsModel.results!.retainWhere((element) =>
          element.byline!.toLowerCase().contains(title.toLowerCase()));
    }
    state = state.copyWith(newsModel: newsModel, isLoading: false);
  }

  updateNewsStructure(bool isList) {
    state = state.copyWith(isList: isList);
  }

  updateNewsFilter(bool fromName) {
    state = state.copyWith(fromName: fromName);
  }
}

final newsProvider =
    StateNotifierProvider<NewsNotifier, NewsState>((ref) => NewsNotifier());
