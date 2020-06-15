import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solidarite/Models/Demande.dart';
import 'package:solidarite/Models/api.services.dart';

import '../../Toasts.dart';

class Archives extends StatefulWidget {
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
    void initState() {
    super.initState();
    
    setState(() {
      getPreferences();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              trailing:  new RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                textColor: Colors.white,
                onPressed: () => supprimerDemande(demandesArchive[index].id),
                child: Text('Finir'),
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
}

