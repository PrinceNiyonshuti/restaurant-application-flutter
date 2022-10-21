// main.dart

import 'food_detail_page.dart';
import 'package:flutter/material.dart';
import '../model/dish_model.dart';

class AllDishes extends StatefulWidget {
  @override
  _AllDishesState createState() => _AllDishesState();
}

class _AllDishesState extends State<AllDishes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Dishes'),
        centerTitle: true,
      ),
      body: Container(
        child: Card(
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
                    // maxCrossAxisExtent: 400,
                    childAspectRatio: 2 / 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    crossAxisCount: 2,
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FoodDetailPage(product: snapshot.data[i]),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image(
                                image: NetworkImage(
                                    'https://source.unsplash.com/200x150/?${snapshot.data[i].name}'),
                                fit: BoxFit.fill,
                              ),
                              Center(
                                child: Text(
                                  snapshot.data[i].name,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Center(
                                child: Text(
                                  "${snapshot.data[i].price?.toString()} Rfw",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFDA0000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
