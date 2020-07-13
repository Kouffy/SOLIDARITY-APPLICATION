import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:solidarite/Models/Administrateur.dart';
import 'package:solidarite/Models/api.services.dart';
import 'package:solidarite/Views/Admin/Panel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../Toasts.dart';

class LoginAdmin extends StatefulWidget {
  static const String routeName = '/adminlogin';
  @override
  _LoginAdminState createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
  var loginController = new TextEditingController();
  var passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Authetification administrateur'),),
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
                   Center(
                        child: Container(
                      padding: EdgeInsets.only(top: 150.0),
                      child: Image.asset(
                        'assets/images/admin_solidarite_icon.png',
                        height: 150,
                        width: 250,
                      ),
                    )),
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
                          obscureText: true,
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



  void navigateToAdminPanel() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdminPanel()),
    );
  }

  void loginIn() async {
    Response adminlogedin = await APIServices.getAdministateurLogin(
        loginController.text, passwordController.text);
    if (adminlogedin.statusCode == 200) {
      var resulat = json.decode(adminlogedin.body);
      Administrateur admin = Administrateur.fromObject(resulat);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool('is_logedin', true);
      pref.setInt('id', admin.id);
      pref.setString('nom', admin.nom);
      pref.setString('prenom', admin.prenom);
      print(admin.prenom);
      pref.setString('login', admin.login);
      pref.setString('password', admin.password);
      Navigator.pop(context);
      navigateToAdminPanel();
    } else {
      print(adminlogedin.statusCode);
      Toasts.showFailedToast("Connection echoué");
    }
  }

  

  
}
