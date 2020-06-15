import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solidarite/Models/Utilisateur.dart';
import 'package:solidarite/Models/api.services.dart';
import '../../Toasts.dart';

class Archives extends StatefulWidget {
  @override
  _ArchivesState createState() => _ArchivesState();
}

class _ArchivesState extends State<Archives> {
    int id = 0;
  String ville = "";
  List<Utilisateur> volontaires;
    getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getInt('id');
      print(id);
    });
  }
  getVolontaires() {
    getVille();
    APIServices.fetchVolontaires(ville).then((response) {
      Iterable list = json.decode(response.body);
      List<Utilisateur> volontaireList = List<Utilisateur>();
      volontaireList =
          list.map((model) => Utilisateur.fromObject(model)).toList();
      setState(() {
        volontaires = volontaireList;
      });
    });
  }

  getVille() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      ville = "g";
    });
  }
  @override
    void initState() {
    super.initState();
    getPreferences();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: volontaires == null
                ? Center(
                    child: Text('Aucun elemnet a afficher'),
                  )
                : _buildVolontairesList(),
          );
  }
    Widget _buildVolontairesList() {
    return ListView.builder(
      itemCount: volontaires.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: ListTile(
              title: Text(volontaires[index].nom),
              onTap: null,
            ),
          ),
        );
      },
    );
  }
      void supprimerDemande(int id) async {
    var saveResponse = await APIServices.deletetDemande(id);
    saveResponse == true ? Toasts.showSucssesToast("zahia") : null;
  }
}

