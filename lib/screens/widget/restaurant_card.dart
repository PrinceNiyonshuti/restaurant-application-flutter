// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:restaurant/model/restaurant_model.dart';

import '../restaurant_detail_page.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({Key? key, required this.restaurant}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var $rating = restaurant.rating;
    var $resto_Image = restaurant.image;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                RestaurantDetailPage(restaurant: restaurant)));
      },
      child: Card(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  restaurant.image,
                  width: 60,
                  height: double.infinity,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      // overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text("${restaurant.rating} Stars")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
