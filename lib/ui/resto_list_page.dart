import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/resto_provider.dart';
import 'package:restaurant_app/ui/search_screen.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';

class RestoListPage extends StatelessWidget {
  const RestoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildAndroid,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        toolbarHeight: 75,
        title: const Text('Mau makan dimana hari ini?',
            style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, SearchScreen.routeName);
            },
          ),
        ],
      ),
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<RestoProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (state.state == ResultState.hasData) {
            return Scaffold(
              body: ListView.builder(
                shrinkWrap: true,
                itemCount: state.result.restaurants.length,
                itemBuilder: (context, index) {
                  var restaurant = state.result.restaurants[index];
                  return CardRestaurant(restaurant: restaurant);
                },
              ),
            );
          } else if (state.state == ResultState.noData) {
            return Center(
              child: Text(state.message),
            );
          } else if (state.state == ResultState.error) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text(''),
            );
          }
        }
      },
    );
  }
}
