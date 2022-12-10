import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class addnote extends StatefulWidget {
  @override
  _addnoteState createState() => _addnoteState();
}

class _addnoteState extends State<addnote> {
  TextEditingController titleInput = TextEditingController();
  TextEditingController descriptionInput = TextEditingController();
  TextEditingController caloriesInput = TextEditingController();
  TextEditingController timeInput = TextEditingController();

  final fb = FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    var rng = Random();
    var id = rng.nextInt(10000);

    final ref = fb.ref().child('meals/$id');

    return Scaffold(
      appBar: AppBar(
        title: Text("Adicione uma nova receita"),
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
                controller: titleInput,
                decoration: InputDecoration(
                  hintText: 'Título',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: descriptionInput,
                decoration: InputDecoration(
                  hintText: 'Descrição',
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
                  hintText: 'Calorias',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: timeInput,
                decoration: InputDecoration(
                  hintText: 'Tempo',
                ),
              ),
            ),
            MaterialButton(
              color: Colors.green,
              onPressed: () {
                ref.set({
                  "title": titleInput.text,
                  "description": descriptionInput.text,
                  "calories": caloriesInput.text,
                  "time": timeInput.text
                }).asStream();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => HomePage()));
              },
              child: Text(
                "Salvar",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
