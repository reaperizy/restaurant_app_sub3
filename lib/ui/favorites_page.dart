import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Favorites'),
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.state == ResultState.hasData) {
            return ListView.builder(
              itemCount: provider.restaurant.length,
              itemBuilder: (context, index) {
                return CardRestaurant(restaurant: provider.restaurant[index]);
              },
            );
          } else {
            return Center(
              child: Text(provider.message),
            );
          }
        },
      ),
    );
  }
}
