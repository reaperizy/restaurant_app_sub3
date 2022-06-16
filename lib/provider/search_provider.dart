import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api_service/api_service.dart';
import 'package:restaurant_app/data/model/search_result.dart';
import 'package:restaurant_app/utils/result_state.dart';

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchProvider({required this.apiService}) {
    fetchQueryRestaurant(query);
  }

  SearchResult? _restoList;
  ResultState? _state;
  String _message = '';
  String _query = '';

  String get message => _message;

  String get query => _query;

  SearchResult? get result => _restoList;

  ResultState? get state => _state;

  Future<dynamic> fetchQueryRestaurant(String query) async {
    try {
      if (query.isNotEmpty) {
        _state = ResultState.loading;
        _query = query;
        notifyListeners();
        final restaurantList = await apiService.searchResult(query);
        if (restaurantList.restaurants.isEmpty) {
          _state = ResultState.noData;
          notifyListeners();
          return _message =
              'Oops, Restaurant atau Makanan yang kamu minta tidak ada :(';
        } else {
          _state = ResultState.hasData;
          notifyListeners();
          return _restoList = restaurantList;
        }
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          'Error --> Failed Load Data, please check your internet connection';
    }
  }
}
