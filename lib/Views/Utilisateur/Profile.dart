import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solidarite/Models/Utilisateur.dart';
import 'package:solidarite/Models/api.services.dart';

import 'EditProfile.dart';

class Profile extends StatefulWidget {
  static const String routeName = '/profile';
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int id = 0;
  Utilisateur utilisateur;
  getid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getInt("id");
    });
  }

  getUtilisateur() async {
    getid();
    Response userres = await APIServices.getUtilisateur(id);
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
  Widget build(BuildContext context) {
    getUtilisateur();
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(children: <Widget>[
        Column(
          children: <Widget>[
            Stack(
              overflow: Overflow.visible,
              alignment: Alignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/images/background2.png'),
                ),
                Positioned(
                    bottom: -1.0,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                          APIServices.urlBase + APIServices.urlUtilisateur + APIServices.urlGetImageUtilisateur + 'image_97444.jpg'),
                    )),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
                child: FlatButton.icon(
              onPressed: () => navigateToEditProfile(utilisateur),
              icon: Icon(Icons.edit),
              label: Text("Modifier le profile"),
            )),
            ListTile(
              title: Text("Nom :"),
              subtitle: Text(utilisateur.nom),
            ),
            ListTile(
              title: Text("Prenom :"),
              subtitle: Text(utilisateur.prenom),
            ),
            ListTile(
              title: Text("Age :"),
              subtitle: Text(utilisateur.age.toString()),
            ),
            ListTile(
              title: Text("Genre :"),
              subtitle:
                  Text(utilisateur.sexe == null ? "null" : utilisateur.nom),
            ),
            ListTile(
              title: Text("Adresse :"),
              subtitle: Text(utilisateur.adreesee),
            ),
            ListTile(
              title: Text("Region :"),
              subtitle: Text(utilisateur.region),
            ),
            ListTile(
              title: Text("Ville :"),
              subtitle: Text(utilisateur.ville),
            ),
            ListTile(
              title: Text("Email :"),
              subtitle: Text(utilisateur.email),
            ),
            ListTile(
              title: Text("Numero de telephone :"),
              subtitle: Text(utilisateur.tel),
            ),
            ListTile(
              title: Text("Login :"),
              subtitle:
                  Text(utilisateur.login),
            ),
            ListTile(
              title: Text("Mot de passe :"),
              subtitle:
                  Text(utilisateur.password),
            )
          ],
        ),
      ]),
    );
  }

  void navigateToEditProfile(Utilisateur utilisateur) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfile(utilisateur)),
    );
  }
}
