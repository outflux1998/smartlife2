import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:smartlife/Pages/details.dart';
import 'package:smartlife/auth.dart';

import 'addmeal.dart';
import 'personal_info.dart';

class ReceiptsPage extends StatefulWidget {
  const ReceiptsPage({Key? key, this.selectedMeal}) : super(key: key);

  final selectedMeal;

  @override
  State<ReceiptsPage> createState() => _ReceiptsPageState();
}

class _ReceiptsPageState extends State<ReceiptsPage> {
  String displayText = 'Refeições';
  final fb = FirebaseDatabase.instance;
  final User? user = Auth().currentUser;

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

  Widget _userId() {
    return Text(user?.displayName ?? 'User email');
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Logout'),
    );
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _activeListeners();
  // }

  // void _activeListeners() {
  //   _dailySpecialStream = ref.child("meals/mealsList/").onValue.listen((event) {
  //     final data = event.snapshot.value;
  //     final meal = Meal.fromRTDB(data);
  //     setState(() {
  //       displayText = meal.MealDisplayText();
  //     });
  //   });
  // }
  TextEditingController titleInput = TextEditingController();

  TextEditingController dcaloriesInput = TextEditingController();
  var l;
  var g;
  var k;

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;

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
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
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
      body: Column(
        children: [
          FirebaseAnimatedList(
            query: fb.ref().child('meals/mealsList/${widget.selectedMeal}'),
            defaultChild: const Center(child: CircularProgressIndicator()),
            shrinkWrap: true,
            itemBuilder: (context, snapshot, animation, index) {
              Object? receipts = snapshot.value;

              return GestureDetector(
                onTap: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ReceiptDetailsPage(
                            selectedMeal: widget.selectedMeal,
                            selectedIndex: index,
                          )))
                },
                child: ListTile(
                    title: Text((receipts as dynamic)['name'] ??
                        (receipts as dynamic)['nome'])),
              );

              // GestureDetector(
              //   // onTap: () {
              //   //   setState(() {
              //   //     k = snapshot.key;
              //   //   });
              //   //   showDialog(
              //   //     context: context,
              //   //     builder: (ctx) => AlertDialog(
              //   //       title: Container(
              //   //         decoration: BoxDecoration(border: Border.all()),
              //   //         child: TextField(
              //   //           controller: second,
              //   //           textAlign: TextAlign.center,
              //   //           decoration: InputDecoration(
              //   //             hintText: 'title',
              //   //           ),
              //   //         ),
              //   //       ),
              //   //       content: Container(
              //   //         decoration: BoxDecoration(border: Border.all()),
              //   //         child: TextField(
              //   //           controller: third,
              //   //           textAlign: TextAlign.center,
              //   //           decoration: InputDecoration(
              //   //             hintText: 'sub title',
              //   //           ),
              //   //         ),
              //   //       ),
              //   //       actions: <Widget>[
              //   //         MaterialButton(
              //   //           onPressed: () {
              //   //             Navigator.of(ctx).pop();
              //   //           },
              //   //           color: Color.fromARGB(255, 0, 22, 145),
              //   //           child: Text(
              //   //             "Cancel",
              //   //             style: TextStyle(
              //   //               color: Colors.white,
              //   //             ),
              //   //           ),
              //   //         ),
              //   //         MaterialButton(
              //   //           onPressed: () async {
              //   //             await upd();
              //   //             Navigator.of(ctx).pop();
              //   //           },
              //   //           color: Color.fromARGB(255, 0, 22, 145),
              //   //           child: Text(
              //   //             "Update",
              //   //             style: TextStyle(
              //   //               color: Colors.white,
              //   //             ),
              //   //           ),
              //   //         ),
              //   //       ],
              //   //     ),
              //   //   );
              //   // },
              //   child: Container(
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: ListTile(
              //         shape: RoundedRectangleBorder(
              //           side: const BorderSide(
              //             color: Colors.white,
              //           ),
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         tileColor: Colors.grey[300],
              //         trailing: IconButton(
              //           icon: const Icon(
              //             Icons.delete,
              //             color: Color.fromARGB(255, 255, 0, 0),
              //           ),
              //           onPressed: () {
              //             ref.child(snapshot.key!).remove();
              //           },
              //         ),
              //         title: Text(
              //           l[2],
              //           // 'dd',
              //           style: const TextStyle(
              //             fontSize: 24,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //         subtitle: Text(
              //           l[1] + ' calorias',
              //           // 'dd',
              //           style: const TextStyle(
              //             fontSize: 18,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }

  upd() async {
    DatabaseReference ref1 =
        FirebaseDatabase.instance.ref("meals/mealsList//$k");

// Only update the name, leave the age and address!
    await ref1.update({
      "title": titleInput.text,
      "calories": dcaloriesInput.text,
    });
    titleInput.clear();
    dcaloriesInput.clear();
  }
}
