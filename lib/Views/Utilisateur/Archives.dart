import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solidarite/Models/Demande.dart';
import 'package:solidarite/Models/api.services.dart';

import '../../Toasts.dart';

class Archives extends StatefulWidget {
  static const String routeName = '/archives';
  @override
  _ArchivesState createState() => _ArchivesState();
}

class _ArchivesState extends State<Archives> {
  int id = 0;
  List<Demande> demandesArchive;
    getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getInt('id');
      print(id);
    });
  }
  getDemandesArchive() {
    APIServices.fetchDemandeArchive(id).then((response) {
      Iterable list = json.decode(response.body);
      List<Demande> demandeList = List<Demande>();
      demandeList = list.map((model) => Demande.fromObject(model)).toList();
      setState(() {
        demandesArchive = demandeList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getPreferences();
    getDemandesArchive();
    return Scaffold(
      appBar: AppBar(title: Text('Mes demandes archivées'),),
          body: demandesArchive == null
                ? Center(
                    child: Text('Aucun elemnet a afficher'),
                  )
                : _buildDemandesArchiveList(),
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
              subtitle: Text(demandesArchive[index].description),
              leading: Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new NetworkImage(
                                        APIServices.urlBase +
                                            APIServices.urlUtilisateur +
                                            APIServices.urlGetImageUtilisateur +
                                            demandesArchive[index].pdpuser)))),
              trailing:   new RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            onPressed: () => supprimerDemande(demandesArchive[index].id),
                            child: Container(
                              height: 40,
                              width: 100.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(colors: [
                                    Color.fromRGBO(143, 148, 251, 1),
                                    Color.fromRGBO(143, 148, 251, .6),
                                  ])),
                              padding: EdgeInsets.all(10.0),
                              child: Center(
                                child: Text('Supprimer',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ),
                            )),
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

