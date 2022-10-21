// main.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:restaurant/screens/widget/dish_card.dart';
import '../model/dish_model.dart';
import 'food_detail_page.dart';

class SearchPage extends StatefulWidget {
  final dynamic search_item;
  const SearchPage({Key? key, required this.search_item}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  get search_item => widget.search_item;

  Future searchDish() async {
    var url = await http.get(
      Uri.parse(
          "https://resto-api-django.herokuapp.com/searchDish/?search=$search_item"),
      headers: {
        HttpHeaders.authorizationHeader:
            "Token 4d2cb84e9218e7a8c533e9185b926ad17884a253"
      },
    );
    // return json.decode(url.body);
    var jsonData = json.decode(url.body);
    List<Dish> dishes = [];
    for (var data in jsonData) {
      Dish dish = Dish(data["DishName"], data["ingredient"], data["price"],
          data["cooking_time"]);
      dishes.add(dish);
    }
    // print(dishes.length);

    return dishes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results for ${search_item}'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          children: [
            buildDishList(),
          ],
        ),
      ),
    );
  }

  Widget buildDishList() {
    return Container(
      height: 200,
      child: FutureBuilder(
        future: searchDish(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data.length >= 1) {
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
          } else {
            return Center(
              child: Text('Sorry , No Dish Found For $search_item '),
            );
          }
        },
      ),
    );
  }
}
