import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api_service/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/result_state.dart';

class RestoProvider extends ChangeNotifier {
  final ApiService apiService;

  RestoProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestoResult _restoResult;
  late ResultState _state;
  String _message = '';

  RestoResult get result => _restoResult;

  ResultState get state => _state;

  String get message => _message;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.listResto();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restoResult = restaurant;
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
