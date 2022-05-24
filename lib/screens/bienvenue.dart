import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_haffeli/models/users.dart';
import 'package:project_haffeli/reusable/delayed.dart';

class bienvenue extends StatefulWidget {
  const bienvenue({Key? key}) : super(key: key);

  @override
  State<bienvenue> createState() => _bienvenueState();
}

class _bienvenueState extends State<bienvenue> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  //@override
  // void initState() {
  //   super.initState();
  //   FirebaseFirestore.instance
  //       .collection("users")
  //      .doc(user!.uid)
  //     .get()
  //      .then((value) {
  //    this.loggedInUser = UserModel.fromMap(value.data());
  //    setState(() {});
  //  });
//  }

  @override
  Widget build(BuildContext context) {
    print(user);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
            // title: Text('Bienvenue'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications_none),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),
              ),
            ],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/background.png"),
                    fit: BoxFit.cover),
              ),
            ),
            bottom: TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 5,
              tabs: [
                Tab(icon: Icon(Icons.home), text: 'Home'),
                Tab(icon: Icon(Icons.star), text: 'Feed'),
                Tab(icon: Icon(Icons.face), text: 'Profil'),
                Tab(icon: Icon(Icons.settings), text: 'Settings'),
              ],
            ),
            elevation: 20,
            titleSpacing: 20),

        ///////////////////
        body: TabBarView(
          children: [
            buildPage('Home Page'),
            buildPage('Feed Page'),
            buildPage('Profile Page'),
            buildPage('Settings Page'),
          ],
        ),
      ),
    );
  }

  Widget buildPage(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 28),
        ),
      );
}
