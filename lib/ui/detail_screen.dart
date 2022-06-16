import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api_service/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/detail_provider.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';

class DetailRestoScreen extends StatelessWidget {
  static const routeName = '/detail_screen';

  const DetailRestoScreen({Key? key, required this.restaurant})
      : super(key: key);

  final Restaurant restaurant;

  Widget _buildList(BuildContext context) {
    return ChangeNotifierProvider<DetailProvider>(
      create: (_) => DetailProvider(
          apiService: ApiService(Client()), resto: restaurant.id),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Detail Restaurant',
              style: TextStyle(color: Colors.black)),
        ),
        body: Consumer<DetailProvider>(builder: (context, data, _) {
          if (data.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.state == ResultState.hasData) {
            return Scaffold(
              body: DetailRestoPage(restaurant: data.detailResult.restaurants),
            );
          } else if (data.state == ResultState.noData) {
            return Center(child: Text(data.message));
          } else if (data.state == ResultState.error) {
            return Center(child: Text(data.message));
          } else {
            return const Center(child: Text(''));
          }
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildList,
      iosBuilder: _buildList,
    );
  }
}
