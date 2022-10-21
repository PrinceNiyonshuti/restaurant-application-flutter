import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant/screens/login_screen.dart';
import 'package:restaurant/screens/all_dishes.dart';
import 'package:restaurant/screens/all_restaurants.dart';

class DrawerBar extends StatefulWidget {
  const DrawerBar({Key? key}) : super(key: key);

  @override
  _DrawerBarState createState() => _DrawerBarState();
}

class _DrawerBarState extends State<DrawerBar> {
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
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("${loggedInUser.firstName} ${loggedInUser.secondName}"),
            accountEmail: Text("${loggedInUser.email}"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  "images/logo.png",
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage('images/navBar.jpg')),
            ),
          ),
          ListTile(
            leading: Icon(Icons.local_restaurant),
            title: Text('Restaurants'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AllRestaurants()),
              ),
            },
          ),
          ListTile(
            leading: Icon(Icons.fastfood),
            title: Text('Dishes'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AllDishes()),
              ),
            },
          ),
          ListTile(
            leading: Icon(Icons.place),
            title: Text('Districts'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            title: Text('Log Out'),
            leading: Icon(Icons.exit_to_app),
            onTap: () => {logout(context)},
          ),
        ],
      ),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
