import 'dart:convert';
import 'package:solidarite/Helpers/Comunucations.dart';
import 'package:solidarite/Models/api.services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solidarite/Helpers/SessionManager.dart';
import 'package:solidarite/Models/Utilisateur.dart';
import '../../Toasts.dart';

class Volontaires extends StatefulWidget {
  static const String routeName = '/volontaires';
  @override
  _VolontairesState createState() => _VolontairesState();
}

class _VolontairesState extends State<Volontaires> {
  int id = 0;
  String ville = "";
  List<Utilisateur> volontaires;

  getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SessionManager.isUserLoggedIn().then((isLogged) {
      if (isLogged) {
        setState(() {
          ville = prefs.getString('ville');
          id = prefs.getInt('id');
        });
      }
    });
  }

  getVolontaires() {
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

  @override
  Widget build(BuildContext context) {
    getPreferences();
    getVolontaires();
    return Scaffold(
      appBar: AppBar(
        title: Text('Volontaires près de chez vous'),
      ),
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
              title: Text(
                  volontaires[index].nom + " " + volontaires[index].prenom),
              subtitle: Text("email : " +
                  volontaires[index].email +
                  '\n' +
                  " mobile :" +
                  volontaires[index].tel),
              leading: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(APIServices.urlBase +
                              APIServices.urlUtilisateur +
                              APIServices.urlGetImageUtilisateur +
                              volontaires[index].pdp)))),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20.0)), //this right here
                        child: Container(
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Contacter Par ?"),
                                RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    textColor: Colors.white,
                                    padding: const EdgeInsets.all(0.0),
                                    onPressed: () => Comunications.sendSms(
                                        volontaires[index].tel),
                                    child: Container(
                                      height: 40,
                                      width: 302.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: LinearGradient(colors: [
                                            Color.fromRGBO(143, 148, 251, 1),
                                            Color.fromRGBO(143, 148, 251, .6),
                                          ])),
                                      padding: EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Text('SMS',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                    )),
                                RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    textColor: Colors.white,
                                    padding: const EdgeInsets.all(0.0),
                                    onPressed: () => Comunications.call(
                                        volontaires[index].tel),
                                    child: Container(
                                      height: 40,
                                      width: 302.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: LinearGradient(colors: [
                                            Color.fromRGBO(143, 148, 251, 1),
                                            Color.fromRGBO(143, 148, 251, .6),
                                          ])),
                                      padding: EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Text('Appel telephonique',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                    )),
                                RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    textColor: Colors.white,
                                    padding: const EdgeInsets.all(0.0),
                                    onPressed: () => Comunications.sendEmail(
                                        volontaires[index].email),
                                    child: Container(
                                      height: 40,
                                      width: 302.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: LinearGradient(colors: [
                                            Color.fromRGBO(143, 148, 251, 1),
                                            Color.fromRGBO(143, 148, 251, .6),
                                          ])),
                                      padding: EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Text('Envoyer un email',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
        );
      },
    );
  }
}
