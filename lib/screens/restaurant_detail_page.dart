import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant/model/dish_model.dart';
import 'package:restaurant/model/restaurant_model.dart';
import 'package:restaurant/screens/widget/dish_card.dart';
import 'widget/custom_icon_button.dart';

class RestaurantDetailPage extends StatefulWidget {
  final dynamic restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);
  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  Restaurant get restaurant => widget.restaurant;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildImage(),
          buildRestoInfo(),
          buildAppBar(),
          // buildOrderButton(),
        ],
      ),
    );
  }

  Widget buildRestoInfo() {
    var $rating = restaurant.rating;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height / 2 - 16,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  restaurant.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                ...List.generate(
                    $rating, (index) => Icon(Icons.star, color: Colors.yellow)),
                Text(
                  " Stars",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              "Owner",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              restaurant.status,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            buildDescription(),
            buildIngredient(),
          ],
        ),
      ),
    );
  }

  Widget buildDescription() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   "Location",
          //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          // ),
          // SizedBox(height: 12),
          // Text(restaurant.id.toString()),
          SizedBox(height: 12),
          Text(
            "Our Dishes",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget buildIngredient() {
    return Container(
      height: 200,
      // margin: EdgeInsets.only(top: 24),
      child: FutureBuilder(
        future: fetchDishes(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 3 / 1,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                crossAxisCount: 2,
              ),
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                return DishCard(dish: snapshot.data[i]);
              },
            );
          }
        },
      ),
    );
  }

  Widget buildImage() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: Image.network(
        restaurant.image,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildOrderButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        elevation: 3,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(width: 16),
              Expanded(
                child: RaisedButton(
                  onPressed: () {
                    Fluttertoast.showToast(msg: "Your Order Placed Well !");
                  },
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Place an Order",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomIconButton(
              icon: Icon(Icons.arrow_back),
              backgroundColor: Colors.white,
              onPressed: () => Navigator.of(context).pop(),
            ),
            CustomIconButton(
              backgroundColor: Colors.white.withOpacity(0.5),
              icon: Icon(Icons.favorite, color: Colors.red),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
