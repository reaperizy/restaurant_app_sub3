import 'package:restaurant_app/data/model/detail_resto.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

Restaurant convertData(DetailResto detailRestaurant) {
  return Restaurant(
    id: detailRestaurant.id,
    name: detailRestaurant.name,
    description: detailRestaurant.description,
    pictureId: detailRestaurant.pictureId,
    city: detailRestaurant.city,
    rating: detailRestaurant.rating.toString(),
  );
}
