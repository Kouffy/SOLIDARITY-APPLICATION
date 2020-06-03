import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solidarite/Models/Demande.dart';
import 'package:solidarite/Models/Utilisateur.dart';
import 'package:solidarite/Models/api.services.dart';

import '../Toasts.dart';

class HomeDemandeur extends StatefulWidget {
  static const String routeName = '/homedemandeur';
  @override
  _HomeDemandeurState createState() => _HomeDemandeurState();
}

class _HomeDemandeurState extends State<HomeDemandeur> {
  int id = 0;
  String ville = "";
  List<Demande> demandesActive;
  List<Demande> demandesArchive;
  List<Utilisateur> volontaires;
  getid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = 1;
    });
  }

  getDemandesActive() {
    getid();
    APIServices.fetchDemandeActive(id).then((response) {
      Iterable list = json.decode(response.body);
      List<Demande> demandeList = List<Demande>();
      demandeList = list.map((model) => Demande.fromObject(model)).toList();
      setState(() {
        demandesActive = demandeList;
      });
    });
  }

  getDemandesArchive() {
    getid();
    APIServices.fetchDemandeArchive(id).then((response) {
      Iterable list = json.decode(response.body);
      List<Demande> demandeList = List<Demande>();
      demandeList = list.map((model) => Demande.fromObject(model)).toList();
      setState(() {
        demandesArchive = demandeList;
      });
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
  Widget build(BuildContext context) {
    getDemandesActive();
    getDemandesArchive();
    getVolontaires();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          floatingActionButton: _buildFloatingButton(),
          appBar: AppBar(
            bottom: TabBar(tabs: [
              Tab(text: "Mes demandes"),
              Tab(text: "Archive"),
              Tab(text: "Voulantaires")
            ]),
          ),
          body: TabBarView(children: [
            demandesActive == null
                ? Center(
                    child: Text('Aucun elemnet a afficher'),
                  )
                : _buildDemandesActiveList(),
            demandesArchive == null
                ? Center(
                    child: Text('Aucun elemnet a afficher'),
                  )
                : _buildDemandesArchiveList(),
            volontaires == null
                ? Center(
                    child: Text('Aucun elemnet a afficher'),
                  )
                : _buildVolontairesList(),
          ])),
    );
  }

  Widget _buildDemandesActiveList() {
    return ListView.builder(
      itemCount: demandesActive.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: ListTile(
              title: Text(demandesActive[index].libelle),
              trailing: demandesActive[index].etat == "d" ? new RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                textColor: Colors.white,
                onPressed: () => changeEtat(
                    demandesActive[index].id,
                    demandesActive[index].libelle,
                    demandesActive[index].datedemande,
                    demandesActive[index].description,"d"),
                child: Text('Intialiser'),
              ) : new RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                textColor: Colors.white,
                onPressed: () => changeEtat(
                    demandesActive[index].id,
                    demandesActive[index].libelle,
                    demandesActive[index].datedemande,
                    demandesActive[index].description,"t"),
                child: Text('Finir'),
              ),
              onTap: null,
            ),
          ),
        );
      },
    );
  }

  Widget _buildDemandesArchiveList() {
    return ListView.builder(
      itemCount: demandesArchive.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: ListTile(
              title: Text(demandesArchive[index].libelle),
              trailing:  new RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                textColor: Colors.white,
                onPressed: () => supprimerDemande(demandesActive[index].id),
                child: Text('Finir'),
              ),
              onTap: null,
            ),
          ),
        );
      },
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
  void changeEtat(int id, String libelle, String datedemande,
      String description,String etat) async {
    Demande demande = new Demande.WithId(
        id, libelle, datedemande, description,etat, 1);
    var saveResponse = await APIServices.putDemandeEncours(demande);
    saveResponse == true ? Toasts.showSucssesToast("zahia") : null;
  }
    void supprimerDemande(int id) async {
    var saveResponse = await APIServices.deletetDemande(id);
    saveResponse == true ? Toasts.showSucssesToast("zahia") : null;
  }
  Widget _buildFloatingButton() {
    return FloatingActionButton(child: Icon(Icons.add), onPressed: () {});
  }
}
