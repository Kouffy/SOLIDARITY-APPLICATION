import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      //ville = prefs.getString('ville');
      ville = 'g';
    });
  }

  getid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      //id = prefs.getInt('id');
      id = 1;
    });
  }

  getDemandes() {
    getVille();
    getid();
    APIServices.fetchDemande(ville, id).then((response) {
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
              title: Text(demandes[index].libelle.toString()),
              trailing: new RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                textColor: Colors.white,
                onPressed: () => intervenir(
                    demandes[index].id,
                    demandes[index].libelle,
                    demandes[index].datedemande,
                    demandes[index].description,
                    demandes[index].priorite),
                child: Text('Intervenir'),
              ),
              onTap: null,
            ),
          ),
        );
      },
    );
  }

  void intervenir(int id, String libelle, String datedemande,
      String description, String priorite) async {
    Demande demande = new Demande.WithId(
        id, libelle, datedemande, description, "e", priorite, 1);
    var saveResponse = await APIServices.putDemandeEncours(demande);
    saveResponse == true ? showSucssesToast() : null;
  }

  void showSucssesToast() {
    Fluttertoast.showToast(
        msg: "Intervention affectée",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white);
  }
}
