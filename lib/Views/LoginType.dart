import 'package:flutter/material.dart';

import 'Admin/LoginAdmin.dart';
import 'Register.dart';
import 'Utilisateur/Login.dart';

class LoginType extends StatefulWidget {
  static const String routeName = '/logintype';
  @override
  _LoginTypeState createState() => _LoginTypeState();
}

class _LoginTypeState extends State<LoginType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('UNITED'),),
      floatingActionButton: _buildFloatingButton(),
      body: ListView(
        children: <Widget>[
          Column(
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
                        'assets/images/solidarite_icon.png',
                        height: 150,
                        width: 250,
                      ),
                    )),
                  ],
                ),
              )
            ],
          ),
        Padding(
          padding: EdgeInsets.all(30.0),
                  child: Column(
            children: <Widget>[
               RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () => navigateToRegister('d'),
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
                        child: Text('Je m\inscrit en tant que demandeur',
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
                    onPressed: () => navigateToRegister('v'),
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
                        child: Text('Je m\inscrit en tant que volontaire',
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
                    onPressed: () => navigateToLogin(),
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
                        child: Text('J\'ai deja un Compte',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                      ),
                    )),
            ],
          ),
        ),
               
        ],
      ),
    );
  }

  void navigateToLogin() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  void navigateToLoginAdmin() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginAdmin()),
    );
  }

  void navigateToRegister(String type) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Register(type)),
    );
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton(
        child: Icon(Icons.settings),
        onPressed: () {
          navigateToLoginAdmin();
        });
  }
}
