import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:smartlife/Pages/receipts.dart';
import 'package:smartlife/auth.dart';

import '../schemas/user_schema.dart';
import '../services/user_service.dart';
import 'personal_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String displayText = 'Referições';
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
        Icon(
          Icons.energy_savings_leaf,
          color: Colors.green,
        ),
      ],
    );
  }

  TextEditingController titleInput = TextEditingController();

  TextEditingController dcaloriesInput = TextEditingController();
  var l;
  var g;
  var k;

  String translateMeal(String currentMeal) {
    switch (currentMeal) {
      case 'lunch':
        return 'Almoço';

      case 'breakfast':
        return 'Café da manhã';

      default:
        return "";
    }
  }

  Widget MealImg(String currentMeal) {
    switch (currentMeal) {
      case 'lunch':
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
              width: 74,
              height: 63,
              fit: BoxFit.cover,
              'https://images2.nogueirense.com.br/wp-content/uploads/2022/10/design-sem-nome-3-1666189173.png'),
        );

      case 'breakfast':
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
              width: 74,
              height: 63,
              fit: BoxFit.cover,
              'https://images.pexels.com/photos/103124/pexels-photo-103124.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
        );

      default:
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
              width: 74,
              height: 63,
              fit: BoxFit.cover,
              'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final newUser = UserRealmService();
    newUser.openRealm();

    late RealmResults<UserRealm> myData;

    myData = newUser.getItems();

    return Scaffold(
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
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(
                      "https://img.freepik.com/fotos-gratis/foto-interna-de-uma-jovem-alegre-mulher-de-cabelos-escuros-mantendo-a-mao-levantada-sobre-o-peito-e-rindo-alegremente-com-os-olhos-fechados-isolada-sobre-uma-parede-azul_295783-11258.jpg?w=900&t=st=1664675420~exp=1664676020~hmac=ebc7b87a6407a4567e87db1bec85309777fa53503b28e8d8eca16b7889f1a570"),
                ),
              )),
          // TextButton(onPressed: _signOutButton, child: _signOutButton())
        ],
      ),
      body: FirebaseAnimatedList(
        query: fb.ref().child('meals/'),
        defaultChild: const Center(child: CircularProgressIndicator()),
        shrinkWrap: true,
        itemBuilder: (context, snapshot, animation, index) {
          Object? meals = snapshot.value;
          return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                      child: Text(
                        "Home",
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w900,
                            fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 15.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width * 0.18,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'Olá ${myData[0].name}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 35,
                                    color: Color.fromRGBO(0, 33, 64, 1)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                        child: Text(
                          "Refeições",
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 20),
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 15.0),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: (meals as dynamic).length,
                            itemBuilder: (BuildContext context, int index) {
                              String currentMeal =
                                  (meals as dynamic).keys.toList()[index];
                              return GestureDetector(
                                onTap: () => {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ReceiptsPage(
                                            selectedMeal: currentMeal,
                                          )))
                                },
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Card(
                                        shadowColor:
                                            Color.fromRGBO(0, 33, 64, 1),
                                        color: Color.fromRGBO(214, 228, 232, 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: ListTile(
                                            leading: MealImg(currentMeal),
                                            title: Text(
                                                style: const TextStyle(
                                                    fontSize: 20.0,
                                                    color: Color.fromRGBO(
                                                        0, 33, 64, 1),
                                                    fontWeight: FontWeight.w600,
                                                    overflow:
                                                        TextOverflow.clip),
                                                translateMeal(currentMeal)
                                                    .toString()),
                                          ),
                                        ),
                                      )
                                    ]),
                              );
                            })),
                  ]));
        },
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
