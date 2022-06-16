import 'package:flutter/material.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/detail_screen.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  static const String _baseUrlImage =
      'https://restaurant-api.dicoding.dev/images/small/';

  const CardRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigation.intentWithData(DetailRestoScreen.routeName, restaurant);
      },
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 110,
              width: 110,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                child: Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(
                    _baseUrlImage + restaurant.pictureId,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Flexible(
              child: Container(
                margin: const EdgeInsets.only(top: 6, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: kTitle,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_pin,
                              color: locationColor,
                              size: 14,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              restaurant.city,
                              style: const TextStyle(color: kColorFour),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Row(children: [
                          const Icon(
                            Icons.star_rate,
                            size: 14,
                            color: starColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(restaurant.rating.toString(),
                              style: const TextStyle(color: kColorFour)),
                        ]),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      restaurant.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: ktitle,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
