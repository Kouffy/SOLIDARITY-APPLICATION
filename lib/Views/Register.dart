import 'package:flutter/material.dart';
import 'package:solidarite/Models/Utilisateur.dart';
import 'package:solidarite/Models/api.services.dart';

class Register extends StatefulWidget {
    static const String routeName = '/register';
  final String type;
  Register(this.type);
  //Register({Key key}):super(key:key);
  @override
  _RegisterState createState() => _RegisterState(type);
}

class _RegisterState extends State<Register> {
  String type;
  _RegisterState(this.type);
  var nomController = new TextEditingController();
  var prenomController = new TextEditingController();
  var ageController = new TextEditingController();
  var sexeController = new TextEditingController();
  var adresseController = new TextEditingController();
  var regionController = new TextEditingController();
  var villeController = new TextEditingController();
  var pdpController = new TextEditingController();
  var emailController = new TextEditingController();
  var telController = new TextEditingController();
  var loginController = new TextEditingController();
  var passwordController = new TextEditingController();
  var textStyle = TextStyle();

  String typeDropDownStr = "Volontaire";
  final connectionissueSanckBar = SnackBar(content: Text("404,la connection a echoué"),);
  @override
  Widget build(BuildContext context) {
    print(type);
    textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: _builAppBar(),
      body: _buildForm(),
    );
  }

  Widget _builAppBar() {
    return AppBar(title: Text('S\'enregistrer'));
  }

  Widget _buildForm() {
    return Padding(
        padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: nomController,
              style: textStyle,
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
              controller: sexeController,
              style: textStyle,
              decoration: InputDecoration(
                labelText: "Sexe ...",
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
                      onPressed: () =>  enregistrerUtilisateur(),
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
  void enregistrerUtilisateur() async {
    Utilisateur utilisateur = new Utilisateur(nomController.text, prenomController.text, int.parse(ageController.text),sexeController.text,adresseController.text,regionController.text,villeController.text,pdpController.text,emailController.text,telController.text,loginController.text,passwordController.text,type);
    var saveResponse = await APIServices.postUtilisateur(utilisateur);
    saveResponse == true ? Navigator.pop(context,true) : Scaffold.of(context).showSnackBar(connectionissueSanckBar);
  }
}
