import 'package:flutter/material.dart';
import 'package:solidarite/Models/Utilisateur.dart';
import 'package:solidarite/Models/api.services.dart';

class EditProfile extends StatefulWidget {
  static const String routeName = '/editprofile';
  final Utilisateur utilisateur;
  EditProfile(this.utilisateur);
  @override
  _EditProfileState createState() => _EditProfileState(utilisateur);
}

class _EditProfileState extends State<EditProfile> {
  Utilisateur utilisateur;
  _EditProfileState(this.utilisateur);
  var nomController = new TextEditingController();
  var prenomController = new TextEditingController();
  var ageController = new TextEditingController();
  var adresseController = new TextEditingController();
  var regionController = new TextEditingController();
  var villeController = new TextEditingController();
  var pdpController = new TextEditingController();
  var emailController = new TextEditingController();
  var telController = new TextEditingController();
  var loginController = new TextEditingController();
  var passwordController = new TextEditingController();
  var typeController = new TextEditingController();
  var textStyle = TextStyle();
  final connectionissueSanckBar = SnackBar(
    content: Text("404,la connection a echoué"),
  );
  @override
  Widget build(BuildContext context) {
    nomController.text = utilisateur.nom;
    prenomController.text = utilisateur.prenom;
    ageController.text = utilisateur.age.toString();
    adresseController.text = utilisateur.adreesee;
    regionController.text = utilisateur.region;
    villeController.text = utilisateur.ville;
    pdpController.text = utilisateur.pdp;
    emailController.text = utilisateur.email;
    telController.text = utilisateur.tel;
    loginController.text = utilisateur.login;
    passwordController.text = utilisateur.password;
    typeController.text = utilisateur.type;
    textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: _builAppBar(),
      body: _buildForm(),
    );
  }

  Widget _builAppBar() {
    return AppBar(title: Text('Modifier mon Profile'));
  }

  Widget _buildForm() {
    return Padding(
        padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: nomController,
              style: textStyle,
              onChanged: (value) => utilisateur.nom = nomController.text,
              decoration: InputDecoration(
                labelText: "Nom ...",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: prenomController,
              style: textStyle,
              onChanged: (value) => utilisateur.prenom = prenomController.text,
              decoration: InputDecoration(
                labelText: "Prenom ...",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: ageController,
              style: textStyle,
              onChanged: (value) =>
                  utilisateur.age = int.parse(ageController.text),
              decoration: InputDecoration(
                labelText: "Age ...",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: adresseController,
              style: textStyle,
              onChanged: (value) =>
                  utilisateur.adresse = adresseController.text,
              decoration: InputDecoration(
                labelText: "Adresse ...",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: regionController,
              style: textStyle,
              onChanged: (value) => utilisateur.region = regionController.text,
              decoration: InputDecoration(
                labelText: "Region ...",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: villeController,
              style: textStyle,
              onChanged: (value) => utilisateur.ville = villeController.text,
              decoration: InputDecoration(
                labelText: "Ville ...",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: pdpController,
              style: textStyle,
              onChanged: (value) => utilisateur.pdp = pdpController.text,
              decoration: InputDecoration(
                labelText: "Pdp ...",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: emailController,
              style: textStyle,
              onChanged: (value) => utilisateur.email = emailController.text,
              decoration: InputDecoration(
                labelText: "Email ...",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: telController,
              style: textStyle,
              onChanged: (value) => utilisateur.tel = telController.text,
              decoration: InputDecoration(
                labelText: "Tel ...",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: loginController,
              style: textStyle,
              onChanged: (value) => utilisateur.login = loginController.text,
              decoration: InputDecoration(
                labelText: "Login ...",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: passwordController,
              style: textStyle,
              onChanged: (value) =>
                  utilisateur.password = passwordController.text,
              decoration: InputDecoration(
                labelText: "Password ...",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                onPressed: () => modifierUtilisateur(),
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
                    child: Text('S\'enregistrer',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                  ),
                ))
          ],
        ));
  }

  void modifierUtilisateur() async {
    var saveResponse = await APIServices.putUtilisateur(utilisateur);
    saveResponse == true
        ? Navigator.pop(context, true)
        : Scaffold.of(context).showSnackBar(connectionissueSanckBar);
  }
}
