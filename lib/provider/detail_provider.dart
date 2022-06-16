import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api_service/api_service.dart';
import 'package:restaurant_app/data/model/detail_resto.dart';
import 'package:restaurant_app/utils/result_state.dart';

class DetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String resto;

  DetailProvider({required this.apiService, required this.resto}) {
    _fetchDetailRestaurant();
  }

  late DetailResult _detailResult;
  late ResultState _state;
  String _message = '';

  DetailResult get detailResult => _detailResult;

  ResultState get state => _state;

  String get message => _message;

  Future<dynamic> _fetchDetailRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.detailRestaurant(resto);
      if (restaurant.restaurants.id.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return Center(
          child: Text(_message =
              'Error --> Failed Load Data, please check your internet connection'));
    }
  }
}
