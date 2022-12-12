import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smartlife/Pages/personal_info.dart';

import 'home_page.dart';
import '../services/user_service.dart';

class updateUser extends StatefulWidget {
  @override
  _updateUserState createState() => _updateUserState();
}

class _updateUserState extends State<updateUser> {
  final newUser = UserRealmService();

  TextEditingController nameInput = TextEditingController();
  TextEditingController ageInput = TextEditingController();
  TextEditingController caloriesInput = TextEditingController();
  TextEditingController weightInput = TextEditingController();
  TextEditingController heightInput = TextEditingController();

  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Desejar sair?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Não'),
              ),
              ElevatedButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => HomePage()),
                      (Route<dynamic> route) => false),
                  child: Text('Sim'))
            ],
          ));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final shouldPopAlert = await showWarning(context);
          print('back');
          return shouldPopAlert ?? false;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(),
            elevation: 0,
            title: Text("Atualize seu perfil"),
            backgroundColor: Colors.green,
          ),
          body: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: TextField(
                    controller: nameInput,
                    decoration: InputDecoration(
                      hintText: 'Nome',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: TextField(
                    controller: ageInput,
                    decoration: InputDecoration(
                      hintText: 'Idade',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: TextField(
                    controller: caloriesInput,
                    decoration: InputDecoration(
                      hintText: 'Calorias diárias',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: TextField(
                    controller: heightInput,
                    decoration: InputDecoration(
                      hintText: 'Altura',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: TextField(
                    controller: weightInput,
                    decoration: InputDecoration(
                      hintText: 'Peso',
                    ),
                  ),
                ),
                MaterialButton(
                  color: Colors.green,
                  onPressed: () {
                    //TODO: Usar Realm to add...

                    newUser.openRealm();
                    var myData = newUser.getItems();
                    print(myData[0].id);

                    newUser.updateUser(
                        myData[0],
                        myData[0].id,
                        nameInput.text,
                        ageInput.text,
                        caloriesInput.text,
                        weightInput.text,
                        heightInput.text);

                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => personal_info()));
                  },
                  child: Text(
                    "salvar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
