import 'package:flutter/material.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getRestaurant();
  }

  ResultState? _state;

  ResultState? get state => _state;

  String _message = '';

  String get message => _message;

  List<Restaurant> _restaurant = [];

  List<Restaurant> get restaurant => _restaurant;

  void _getRestaurant() async {
    _restaurant = await databaseHelper.getRestaurant();

    if (_restaurant.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Restaurant favorit kamu masih kosong';
    }
    notifyListeners();
  }

  void addRestaurant(Restaurant restaurant) async {
    try {
      await databaseHelper.insertRestaurant(restaurant);
      _getRestaurant();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Kosong: $e';
      notifyListeners();
    }
  }

  Future<bool> isBookmarked(String id) async {
    final bookmarkedRestaurant = await databaseHelper.getRestaurantById(id);
    return bookmarkedRestaurant.isNotEmpty;
  }

  void removeRestaurant(String id) async {
    try {
      await databaseHelper.removeRestaurant(id);
      _getRestaurant();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
