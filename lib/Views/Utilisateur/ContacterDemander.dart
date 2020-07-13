import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:solidarite/Helpers/Comunucations.dart';
import 'package:solidarite/Models/Utilisateur.dart';
import 'package:solidarite/Models/api.services.dart';
class ContacterDemandeur extends StatefulWidget {
    final int idusercontact;
  ContacterDemandeur({this.idusercontact});
  @override
  _ContacterDemandeurState createState() => _ContacterDemandeurState();
}

class _ContacterDemandeurState extends State<ContacterDemandeur> {
    int id = 0;
  Utilisateur utilisateur;
    getUtilisateur() async {
    Response userres = await APIServices.getUtilisateur(widget.idusercontact);
    print(userres.statusCode);
    if (userres.statusCode == 200) {
      var resulat = json.decode(userres.body);
      Utilisateur user = Utilisateur.fromObject(resulat);
      setState(() {
        utilisateur = user;
      });
    }
  }
  @override
  void initState() {
    super.initState();
              WidgetsBinding.instance.addPostFrameCallback((_){
            getUtilisateur();
          });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contacter le demandeur'),),
      body:    Padding(
          padding: EdgeInsets.all(30.0),
                  child: Column(
            children: <Widget>[
               RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0.0),
                    onPressed: ()  {
                      Comunications.sendSms(utilisateur.tel);
                    },
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(143, 148, 251, 1),
                            Color.fromRGBO(143, 148, 251, .6),
                          ])),
                      padding: EdgeInsets.all(10.0),
                      child: Center(
                        child: Text('contacter ' +utilisateur.nom + ' '+ utilisateur.prenom +' par SMS',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                      ),
                    )),
                SizedBox(
                  height: 10.0,
                ),
                RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () {
                      Comunications.call(utilisateur.tel);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(143, 148, 251, 1),
                            Color.fromRGBO(143, 148, 251, .6),
                          ])),
                      padding: EdgeInsets.all(10.0),
                      child: Center(
                        child: Text('Appeler ' +utilisateur.nom +' '+ utilisateur.prenom ,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                      ),
                    )),
                SizedBox(
                  height: 10.0,
                ),
                RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () {
                      Comunications.sendEmail(utilisateur.email);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(143, 148, 251, 1),
                            Color.fromRGBO(143, 148, 251, .6),
                          ])),
                      padding: EdgeInsets.all(10.0),
                      child: Center(
                        child: Text('contacter ' + utilisateur.nom +' '+ utilisateur.prenom+' par Email',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                      ),
                    )),
            ],
          ),
        ),
    );
  }
}