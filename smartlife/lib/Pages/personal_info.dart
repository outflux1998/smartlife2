import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class personal_info extends StatefulWidget {
  @override
  _personal_infoState createState() => _personal_infoState();
}

class _personal_infoState extends State<personal_info> {
  TextEditingController titleInput = TextEditingController();
  TextEditingController descriptionInput = TextEditingController();
  TextEditingController caloriesInput = TextEditingController();
  TextEditingController timeInput = TextEditingController();

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
                  onPressed: () => Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => HomePage())),
                  child: Text('Sim'))
            ],
          ));

  final fb = FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    var rng = Random();
    var id = rng.nextInt(10000);
    final ref = fb.ref().child('meals/$id');

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
            title: Text("Informações Pessoais"),
            backgroundColor: Colors.green,
          ),
          body: Container(),
        ));
  }
}
