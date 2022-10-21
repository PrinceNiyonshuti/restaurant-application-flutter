import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/model/user_model.dart';
import 'package:restaurant/screens/all_dishes.dart';
import 'package:restaurant/screens/search_page.dart';
import 'widget/drawer.dart';
import '../model/restaurant_model.dart';
import '../model/dish_model.dart';
import 'widget/restaurant_card.dart';
import 'widget/dish_card.dart';
import 'widget/custom_icon_button.dart';
import 'widget/filter_button.dart';
import 'widget/food_card.dart';
import 'all_restaurants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchData = TextEditingController();

  // user data
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerBar(),
      appBar: AppBar(
        title: const Text("Restaurant"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          children: [
            buildHeader(),
            SizedBox(height: 20),
            buildSearch(),
            buildFilter(),
            buildFoodList(),
            buildSectionTitle(),
            buildDishList(),
            buildSectionRestaurants(),
            // buildCategoryRestaurantsList(),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome back ${loggedInUser.firstName}",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget buildSearch() {
    var search = searchData.text;
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchData,
            decoration: InputDecoration(
              hintText: "Search dish",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: EdgeInsets.all(8),
              // suffixIcon: Icon(Icons.search ),
              suffixIcon: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          SearchPage(search_item: searchData.text),
                    ),
                  );
                },
                icon: Icon(Icons.search),
              ),
            ),
          ),
        ),
        CustomIconButton(
          // margin: EdgeInsets.only(left: 8),
          icon: Icon(Icons.filter_list),
          onPressed: () {},
          backgroundColor: Colors.redAccent,
        ),
      ],
    );
  }

  Widget buildFilter() {
    return Container(
      height: 32,
      margin: EdgeInsets.only(top: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          FilterButton(
            title: "Popular",
            isSelected: true,
          ),
          FilterButton(
            title: "New Dishes",
            isSelected: false,
          ),
          FilterButton(
            title: "Hot Dishes",
            isSelected: false,
          ),
          FilterButton(
            title: "Combo Dishes",
            isSelected: false,
          ),
          FilterButton(
            title: "New Restaurant",
            isSelected: false,
          ),
        ],
      ),
    );
  }

  Widget buildFoodList() {
    return Container(
      height: 220,
      margin: EdgeInsets.only(top: 24),
      child: FutureBuilder(
        future: fetchDishes(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 2 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 2,
              ),
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                return FoodCard(product: snapshot.data[i]);
              },
            );
          }
        },
      ),
    );
  }

  Widget buildSectionTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Explore Dishes",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AllDishes()),
            );
          },
          textColor: Colors.redAccent,
          child: Text("View all"),
        ),
      ],
    );
  }

  Widget buildDishList() {
    return Container(
      height: 200,
      margin: EdgeInsets.only(top: 24),
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
        FlatButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AllRestaurants()),
            );
          },
          textColor: Colors.redAccent,
          child: Text("View all"),
        ),
      ],
    );
  }

  Widget buildCategoryRestaurantsList() {
    return Container(
      height: 200,
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
