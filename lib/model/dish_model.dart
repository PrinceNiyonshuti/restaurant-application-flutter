import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future fetchDishes() async {
  var url = await http.get(
    Uri.parse("https://resto-api-django.herokuapp.com/searchDish/?search="),
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

class Dish {
  final String name, ingredient, cooking_time;
  final int price;

  Dish(this.name, this.ingredient, this.price, this.cooking_time);
}
