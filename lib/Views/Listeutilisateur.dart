import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:solidarite/Models/Utilisateur.dart';
import 'package:solidarite/Models/api.services.dart';
class Utilisateurs extends StatefulWidget {
  Utilisateurs({Key key}):super(key:key);
  @override
  _UtilisateursState createState() => _UtilisateursState();
}

class _UtilisateursState extends State<Utilisateurs> {
  List<Utilisateur> utilisateurs;
  getUtilisateur(){
    APIServices.fetchUtilisateur().then((response){
      Iterable list = json.decode(response.body);
      List<Utilisateur> utilisateurList = List<Utilisateur>();
      utilisateurList=list.map((model)=>Utilisateur.fromObject(model)).toList();
      setState(() {
        utilisateurs = utilisateurList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getUtilisateur();
    
    return Scaffold(
      appBar: AppBar(title:Text('Liste des Utilisteurs')),
      body: utilisateurs == null ? Center(child: Text('Aucun elemnet a afficher'),) : 
      _buildUtilisateurList()
    );
  }

  Widget _buildUtilisateurList(){
    return ListView.builder(
        itemCount: utilisateurs.length,
        itemBuilder: (context,index){
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              title: ListTile(
                title:Text(utilisateurs[index].nom ),
                onTap: null,

                ),
            ),
          );
        },
      );
  }
}