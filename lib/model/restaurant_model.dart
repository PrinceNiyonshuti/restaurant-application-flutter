import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future fetchRestaurants() async {
  var url = await http.get(
    Uri.parse("https://resto-api-django.herokuapp.com/restaurants/"),
  );
  // return json.decode(url.body);
  var jsonData = json.decode(url.body);
  List<Restaurant> restaurants = [];

  for (var data in jsonData) {
    Restaurant restaurant = Restaurant(data["RestorantName"], data["status"],
        data["image"], data["rating"], data["id"]);
    restaurants.add(restaurant);
  }
  print(restaurants.length);

  return restaurants;
}

class Restaurant {
  final String name, status, image;
  final int id, rating;

  Restaurant(this.name, this.status, this.image, this.rating, this.id);
}
