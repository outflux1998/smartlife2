import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:smartlife/auth.dart';
import 'package:smartlife/pages/addmeal.dart';
import 'package:smartlife/pages/personal_info.dart';

class ReceiptDetailsPage extends StatefulWidget {
  const ReceiptDetailsPage(
      {required this.selectedIndex, super.key, required this.selectedMeal});

  final selectedIndex;
  final selectedMeal;

  @override
  State<ReceiptDetailsPage> createState() => _ReceiptDetailsPageState();
}

class _ReceiptDetailsPageState extends State<ReceiptDetailsPage> {
  final fb = FirebaseDatabase.instance;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text(
          'SMARTLIFE',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Logout'),
    );
  }

  @override
  Widget build(BuildContext context) {
    var datails = fb.ref().child(
        'meals/mealsList/${widget.selectedMeal}/${widget.selectedIndex}');

    return Scaffold(
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
            child: GNav(
              gap: 8,
              backgroundColor: Colors.white,
              color: Colors.black,
              activeColor: Colors.green,
              tabBackgroundColor: Colors.grey.shade300,
              padding: const EdgeInsets.all(16),
              tabs: [
                const GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                // GButton(
                //   icon: Icons.favorite_border,
                //   text: 'Dieta',
                // ),
                GButton(
                  icon: Icons.person,
                  text: 'Conta',
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => personal_info(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => addmeal(),
              ),
            );
          },
          child: const Icon(
            Icons.add,
          ),
        ),
        appBar: AppBar(
          title: _title(),
          backgroundColor: Colors.white,
          actions: [
            TextButton(onPressed: _signOutButton, child: _signOutButton())
          ],
        ),
        body: FirebaseAnimatedList(
            query: fb.ref().child(
                'meals/mealsList/${widget.selectedMeal}/${widget.selectedIndex}'),
            defaultChild: const Center(child: CircularProgressIndicator()),
            shrinkWrap: true,
            itemBuilder: (context, snapshot, animation, index) {
              Object? receipt = snapshot.value;
              return Text(receipt.toString());
            }));
  }
}
