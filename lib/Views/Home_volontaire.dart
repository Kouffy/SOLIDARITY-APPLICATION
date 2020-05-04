import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:solidarite/Models/Demande.dart';
import 'package:solidarite/Models/api.services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homevolontaire extends StatefulWidget {
  Homevolontaire({Key key}) : super(key: key);
  @override
  _HomevolontaireState createState() => _HomevolontaireState();
}

class _HomevolontaireState extends State<Homevolontaire> {
  String ville = "", region = "";
  int id = 0;

  List<Demande> demandes;

  getVille() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      ville = prefs.getString('ville');
    });
  }

  getid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getInt('id');
    });
  }

  getDemandes() {
    getVille();
    getid();
    APIServices.fetchDemande(ville,id).then((response) {
      Iterable list = json.decode(response.body);
      List<Demande> demandeList = List<Demande>();
      demandeList = list.map((model) => Demande.fromObject(model)).toList();
      setState(() {
        demandes = demandeList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getDemandes();

    return Scaffold(
      drawer: new Drawer(),
        appBar: AppBar(title: Text('Liste des Demande')),
        body: demandes == null
            ? Center(
                child: Text('Aucun elemnet a afficher'),
              )
            : _buildUtilisateurList());
  }

  Widget _buildUtilisateurList() {
    return ListView.builder(
      itemCount: demandes.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: ListTile(
              title: Text(demandes[index].libelle),
              onTap: null,
            ),
          ),
        );
      },
    );
  }
}
