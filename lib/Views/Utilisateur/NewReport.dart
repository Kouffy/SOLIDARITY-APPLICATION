import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solidarite/Models/Administrateur.dart';
import 'package:solidarite/Models/Rapport.dart';
import 'package:solidarite/Models/api.services.dart';
import 'package:solidarite/Toasts.dart';

class NewReport extends StatefulWidget {
  static const String routeName = '/NewReport';
  @override
  _NewReportState createState() => _NewReportState();
}

class _NewReportState extends State<NewReport> {
  int idAd;
    getID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        idAd = prefs.getInt("id");
      });
    }
    @override
  void initState() {
    super.initState();
                  WidgetsBinding.instance.addPostFrameCallback((_){
            getID();
          });
  }
  var libelleController = new TextEditingController();
  var contenuController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _builAppBar(),
      body: _buildForm(),
    );
  }

  Widget _builAppBar() {
    return AppBar(title: Text('Envoyer un Rapport'));
  }

  Widget _buildForm() {
    return  Padding(
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
                          controller: libelleController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Objet du rapport",
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
                          controller: contenuController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Contenu",
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
                onPressed: () => envoyerRapport(),
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
                    child: Text('Envoyer',
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

  void envoyerRapport() async {
    Rapport rapport = new Rapport(
        libelleController.text,
        DateTime.now().toString(),contenuController.text,this.idAd);
    var saveResponse = await APIServices.postRapport(rapport);
    if(saveResponse) {
         Toasts.showSucssesToast('Rapport envoyé avec succès');
         Navigator.pop(context);
         }
         else{
         Toasts.showFailedToast("Serveur Indisponible");
        }
  }



}
