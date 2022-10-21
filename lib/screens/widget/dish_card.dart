import 'package:flutter/material.dart';
import 'package:restaurant/model/dish_model.dart';
import '../food_detail_page.dart';

class DishCard extends StatelessWidget {
  final Dish dish;

  const DishCard({Key? key, required this.dish}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FoodDetailPage(product: dish)));
      },
      child: Card(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  "https://source.unsplash.com/200x200/?${dish.name}",
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
                      dish.name,
                      maxLines: 1,
                      softWrap: false,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text("${dish.price}  Rfw")
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
