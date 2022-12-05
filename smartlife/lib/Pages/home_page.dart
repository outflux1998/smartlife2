import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:smartlife/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dRef = FirebaseDatabase.instance.ref();
  late DatabaseReference databaseReference;
  // setData() {
  //   dRef.child("meals").set({'id': "01", 'name': "ibad", "contract": "0000"});
  // }

  showData() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('meals').get();
    if (snapshot.exists) {
      print(snapshot.value);
    } else {
      print('No data available.');
    }
  }

  @override
  void initState() {
    super.initState();
    databaseReference = dRef;
  }

  final User? user = Auth().currentUser;
  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text(
      'SMARTLIFE',
      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
    );
  }

  Widget _mealsListItem() {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 110,
      color: Colors.lightGreen,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text('Name'), SizedBox(height: 5)]),
    );
  }

  Widget _userId() {
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sair'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
            child: GNav(
              gap: 8,
              backgroundColor: Colors.white,
              color: Colors.black,
              activeColor: Colors.black,
              tabBackgroundColor: Colors.grey.shade300,
              padding: EdgeInsets.all(16),
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.favorite_border,
                  text: 'Dieta',
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Conta',
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: _title(),
          backgroundColor: Colors.white,
          actions: [TextButton(onPressed: showData, child: Text("Show Data"))],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // FirebaseAnimatedList(
              //     shrinkWrap: true,
              //     query: databaseReference,
              //     itemBuilder: (BuildContext context, DataSnapshot snapshot,
              //         Animation animation, int index) {
              //       return Text(snapshot.value.);
              //     })
              // _userId(),
              // _signOutButton(),
              // _mealsListItem(),
            ],
          ),
        ));
  }
}
