import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solidarite/Models/Demande.dart';
import 'package:solidarite/Models/Rapport.dart';
import 'package:solidarite/Models/Utilisateur.dart';
import 'package:solidarite/Models/api.services.dart';
import '../../Toasts.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  List<Utilisateur> utilisateurs;
  List<Rapport> rapports;
  List<Demande> demandes;

  getUtilisateurs() {
    APIServices.fetchUtilisateur().then((response) {
      Iterable list = json.decode(response.body);
      List<Utilisateur> utilisateurList = List<Utilisateur>();
      utilisateurList =
          list.map((model) => Utilisateur.fromObject(model)).toList();
      setState(() {
        utilisateurs = utilisateurList;
      });
    });
  }


  getRapports() {
    APIServices.fetchAllRapports().then((response) {
      Iterable list = json.decode(response.body);
      List<Rapport> rapportList = List<Rapport>();
      rapportList = list.map((model) => Rapport.fromObject(model)).toList();
      setState(() {
        rapports = rapportList;
      });
    });
  }

  getDemandes() {
    APIServices.fetchAllDemande().then((response) {
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
    getUtilisateurs();
    getDemandes();
    getRapports();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          floatingActionButton: _buildFloatingButton(),
          appBar: AppBar(
            bottom: TabBar(tabs: [
              Tab(text: "Utilisateurs"),
              Tab(text: "Demandes"),
              Tab(text: "Rapports")
            ]),
          ),
          body: TabBarView(children: [
            utilisateurs == null || utilisateurs.length == 0
                ? Center(
                    child: Text('Aucun elemnet a afficher'),
                  )
                : _buildUtilisateurList(),
            demandes == null || demandes.length == 0
                ? Center(
                    child: Text('Aucun elemnet a afficher'),
                  )
                : _buildDemandeList(),
            rapports == null || rapports.length == 0
                ? Center(
                    child: Text('Aucun elemnet a afficher'),
                  )
                : _buildRapportList(),
          ])),
    );
  }

  Widget _buildUtilisateurList() {
    return ListView.builder(
      itemCount: utilisateurs.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: ListTile(
              title: Text(utilisateurs[index].nom),
              trailing: new RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      textColor: Colors.white,
                      onPressed: () => supprimerUtilisateur(utilisateurs[index].id),
                      child: Text('Supprimer'),
                    ),
              onTap: null,
            ),
          ),
        );
      },
    );
  }

  

  Widget _buildDemandeList() {
    return ListView.builder(
      itemCount: demandes.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: ListTile(
              title: Text(demandes[index].libelle),
              trailing: new RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                textColor: Colors.white,
                onPressed: () => supprimerDemande(demandes[index].id),
                child: Text('Supprimer'),
              ),
              onTap: null,
            ),
          ),
        );
      },
    );
  }
 Widget _buildRapportList() {
    return ListView.builder(
      itemCount: rapports.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: ListTile(
              title: Text(rapports[index].libelle),
              trailing: new RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                textColor: Colors.white,
                onPressed: () => supprimerDemande(rapports[index].id),
                child: Text('Supprimer'),
              ),
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
    void supprimerUtilisateur(int id) async {
    var saveResponse = await APIServices.deletetUtilisateur(id);
    saveResponse == true ? Toasts.showSucssesToast("zahia") : null;
  }
    void supprimerRapport(int id) async {
    var saveResponse = await APIServices.deleteRapport(id);
    saveResponse == true ? Toasts.showSucssesToast("zahia") : null;
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton(child: Icon(Icons.add), onPressed: () {});
  }
}
