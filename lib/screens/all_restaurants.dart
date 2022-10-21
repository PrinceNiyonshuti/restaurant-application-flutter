// main.dart
import 'package:flutter/material.dart';
import 'package:restaurant/model/restaurant_model.dart';
import 'package:restaurant/screens/widget/restaurant_card.dart'; // for using json.decode()

class AllRestaurants extends StatefulWidget {
  @override
  _AllRestaurantsState createState() => _AllRestaurantsState();
}

class _AllRestaurantsState extends State<AllRestaurants> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Restaurants'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          children: [
            buildSectionRestaurants(),
            buildCategoryRestaurantsList(),
          ],
        ),
      ),
    );
  }

  Widget buildSectionRestaurants() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Explore Restaurants",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget buildCategoryRestaurantsList() {
    return Container(
      height: 400,
      child: FutureBuilder(
        future: fetchRestaurants(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                // maxCrossAxisExtent: 400,
                childAspectRatio: 3 / 1,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                crossAxisCount: 2,
              ),
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                return RestaurantCard(restaurant: snapshot.data[i]);
              },
            );
          }
        },
      ),
    );
  }
}
