import 'package:flutter/material.dart';
import 'package:solidarite/Views/Login.dart';
import 'package:solidarite/Views/LoginAdmin.dart';

import 'Register.dart';

class LoginType extends StatefulWidget {
  @override
  _LoginTypeState createState() => _LoginTypeState();
}

class _LoginTypeState extends State<LoginType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            floatingActionButton: _buildFloatingButton(),
          body: ListView(
          children: <Widget>[
             Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/images/background2.png'),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            
          ],
        ),
            RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        onPressed: () => navigateToRegister('d'),
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
                            child: Text('Je m\inscrit en tant que demandeur',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                          ),
                        )),
                        SizedBox(height: 10.0,),
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
                         SizedBox(height: 10.0,),
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
