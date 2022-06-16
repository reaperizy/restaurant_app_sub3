import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:restaurant_app/data/model/detail_resto.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/search_result.dart';

class ApiService {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String list = 'list';
  static const String _detail = 'detail/';
  static const String _search = 'search?q=';
  static const String _throw = 'Failed load data';

  final Client client;

  ApiService(this.client);

  Future<RestoResult> listResto() async {
    final response = await client.get(Uri.parse(baseUrl + list));
    if (response.statusCode == 200) {
      return RestoResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(_throw);
    }
  }

  Future<DetailResult> detailRestaurant(String id) async {
    final response = await client.get(Uri.parse(baseUrl + _detail + id));
    if (response.statusCode == 200) {
      return DetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(_throw);
    }
  }

  Future<SearchResult> searchResult(String query) async {
    final response = await client.get(Uri.parse(baseUrl + _search + query));
    if (response.statusCode == 200) {
      return SearchResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(_throw);
    }
  }
}
