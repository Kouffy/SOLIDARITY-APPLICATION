import 'package:flutter/material.dart';
import 'package:solidarite/Models/Administrateur.dart';
import 'package:solidarite/Models/api.services.dart';
import 'package:solidarite/Toasts.dart';

class NewAdmin extends StatefulWidget {
  static const String routeName = '/newadmin';
  @override
  _NewAdminState createState() => _NewAdminState();
}

class _NewAdminState extends State<NewAdmin> {
  var nomController = new TextEditingController();
  var prenomController = new TextEditingController();
  var loginController = new TextEditingController();
  var passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _builAppBar(),
      body: _buildForm(),
    );
  }

  Widget _builAppBar() {
    return AppBar(title: Text('Nouveau Administrateur'));
  }

  Widget _buildForm() {
    return Padding(
        padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
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
                          controller: nomController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Nom",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[100]))),
                        child: TextField(
                          controller: prenomController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Prenom",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[100]))),
                        child: TextField(
                          controller: loginController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Login",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[100]))),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ]),
                  )
                ],
              ),
            ),
            RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                onPressed: () => enregistrerAdministrateur(),
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
                    child: Text('Ajouter',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                  ),
                )),
            SizedBox(
              height: 20.0,
            )
          ],
        ));
  }

  void enregistrerAdministrateur() async {
    Administrateur administrateur = new Administrateur(nomController.text,
        prenomController.text, loginController.text, passwordController.text);
    var saveResponse = await APIServices.postAdministateur(administrateur);
    if (saveResponse) {
      Toasts.showSucssesToast("Ajouté");
      Navigator.pop(context, true);
    } else {
      Toasts.showFailedToast("Serveur Indisponible");
    }
  }
}
