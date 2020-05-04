import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:solidarite/Models/Utilisateur.dart';
import 'package:solidarite/Models/api.services.dart';
import 'package:solidarite/Views/Home_volontaire.dart';
import 'package:solidarite/Views/Register.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Utilisateur utilisateur;
  var loginController = new TextEditingController();
  var passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingButton(),
      backgroundColor: Colors.white,
      body: ListView(children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.fill)),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Container(
                        padding: EdgeInsets.only(top: 50),
                        child: Center(
                          child: Text("Connexion",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10)),
                        ]),
                    child: Column(children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[100]))),
                        child: TextField(
                          controller: loginController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Login ou Email",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[100]))),
                        child: TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Mot de passe",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      onPressed: () => loginIn(),
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
                          child: Text('Se connecter',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                        ),
                      ))
                ]),
              )
            ],
          ),
        ),
      ]),
    );
  }

  void navigateToRegister(Utilisateur utilisateur) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Register(utilisateur)),
    );
  }

  void navigateToHomeVoloteire() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Homevolontaire()),
    );
  }

  void loginIn() async {
    Response userlogedin = await APIServices.getUtilisateurLogin(
        loginController.text, passwordController.text);

    if (userlogedin.statusCode == 200) {
      var resulat = json.decode(userlogedin.body);
      Utilisateur user = Utilisateur.fromObject(resulat);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool('is_logedin', true);
      pref.setInt('id', user.id);
      pref.setString('nom', user.nom);
      pref.setString('prenom', user.prenom);
      pref.setInt('age', user.age);
      pref.setString('adresse', user.adreesee);
      pref.setString('region', user.region);
      pref.setString('ville', user.ville);
      pref.setString('pdp', user.pdp);
      pref.setString('email', user.email);
      pref.setString('tel', user.tel);
      pref.setString('login', user.login);
      pref.setString('password', user.password);
      pref.setString('type', user.type);
      Navigator.pop(context);
      navigateToHomeVoloteire();
    } else {
      showErrorToast();
    }
  }

  void showErrorToast() {
    Fluttertoast.showToast(
        msg: "Connection échoué",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton(
        child: Icon(Icons.person_add),
        onPressed: () {
          navigateToRegister(
              Utilisateur('', '', 0, '', '', '', '', '', '', '', '', ''));
        });
  }
}
