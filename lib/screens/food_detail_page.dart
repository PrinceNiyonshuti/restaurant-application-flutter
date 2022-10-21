import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant/model/dish_model.dart';
import 'widget/custom_icon_button.dart';

class FoodDetailPage extends StatefulWidget {
  final dynamic product;

  const FoodDetailPage({Key? key, required this.product}) : super(key: key);
  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  Dish get product => widget.product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildImage(),
          buildFoodInfo(),
          buildAppBar(),
          buildOrderButton(),
        ],
      ),
    );
  }

  Widget buildFoodInfo() {
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
                  product.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Rfw ${product.price}",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 12),
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
          Text("Ingredients",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Text(product.ingredient),
        ],
      ),
    );
  }

  Widget buildIngredient() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Cooking Time",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Text("${product.cooking_time} Minutes",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
          SizedBox(height: 12),
          // Container(
          //   height: 100,
          //   child: ListView(
          //     scrollDirection: Axis.horizontal,
          //     children: List.generate(
          //       10,
          //       (index) => Container(
          //         child: Card(
          //           child: ClipRRect(
          //             borderRadius: BorderRadius.circular(8),
          //             child: Image.network(
          //               "https://source.unsplash.com/200x20$index/?vegetable",
          //             ),
          //           ),
          //         ),
          //         width: 100,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget buildImage() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: Image.network(
        "https://source.unsplash.com/200x200/?${product.name}",
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
