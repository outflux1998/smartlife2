import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:smartlife/Pages/details.dart';
import 'package:smartlife/auth.dart';

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
        Icon(
          Icons.energy_savings_leaf,
          color: Colors.green,
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

  TextEditingController titleInput = TextEditingController();
  TextEditingController caloriesInput = TextEditingController();
  var l;
  var g;
  var k;

  @override
  Widget build(BuildContext context) {
    Widget RecipeImg(String imageurl) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child:
            Image.network(width: 74, height: 63, fit: BoxFit.cover, imageurl),
      );
    }

    return Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.green,
        //   onPressed: () {
        //     Navigator.of(context).push(MaterialPageRoute(
        //         builder: (context) => addmeal(
        //               selectedMeal: widget.selectedMeal,
        //             )));
        //   },
        //   child: const Icon(
        //     Icons.add,
        //   ),
        // ),
        appBar: AppBar(
          title: _title(),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => personal_info(),
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(
                        "https://img.freepik.com/fotos-gratis/foto-interna-de-uma-jovem-alegre-mulher-de-cabelos-escuros-mantendo-a-mao-levantada-sobre-o-peito-e-rindo-alegremente-com-os-olhos-fechados-isolada-sobre-uma-parede-azul_295783-11258.jpg?w=900&t=st=1664675420~exp=1664676020~hmac=ebc7b87a6407a4567e87db1bec85309777fa53503b28e8d8eca16b7889f1a570"),
                  ),
                )),
            // TextButton(onPressed: _signOutButton, child: _signOutButton())
          ],
        ),
        body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                child: Text(
                  "Receitas",
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w900,
                      fontSize: 16),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                  child: Text(
                    "Pratos",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                  )),
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
                                      selectedReceipted: receipts as dynamic,
                                    )))
                          },
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                                shadowColor: Color.fromRGBO(0, 33, 64, 1),
                                color: Color.fromRGBO(214, 228, 232, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ListTile(
                                        leading: RecipeImg(
                                            (receipts as dynamic)['image']),
                                        subtitle: Text(
                                            "${(receipts as dynamic)['calories']} KCAL"),
                                        title: Text(
                                          (receipts as dynamic)['name'],
                                          style: const TextStyle(
                                              fontSize: 20.0,
                                              color:
                                                  Color.fromRGBO(0, 33, 64, 1),
                                              fontWeight: FontWeight.w600,
                                              overflow: TextOverflow.clip),
                                        )))),
                          ]));
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
            ])));
  }

  upd() async {
    DatabaseReference ref1 =
        FirebaseDatabase.instance.ref("meals/mealsList//$k");

// Only update the name, leave the age and address!
    await ref1.update({
      "name": titleInput.text,
      "calories": caloriesInput.text,
      "time": caloriesInput.text,
    });
    titleInput.clear();
    caloriesInput.clear();
  }
}
