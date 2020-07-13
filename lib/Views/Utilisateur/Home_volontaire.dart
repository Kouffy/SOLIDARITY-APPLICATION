import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:solidarite/Drawer/VolontaireDrawer.dart';
import 'package:solidarite/Helpers/Radio.dart';
import 'package:solidarite/Helpers/SessionManager.dart';
import 'package:solidarite/Models/Demande.dart';
import 'package:solidarite/Models/api.services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solidarite/Views/Utilisateur/Commenter.dart';
import 'package:solidarite/Views/Utilisateur/ContacterDemander.dart';
import 'package:solidarite/Views/Utilisateur/NewPost.dart';
import '../../Toasts.dart';

class Homevolontaire extends StatefulWidget {
  Homevolontaire({Key key}) : super(key: key);
  static const String routeName = '/homevolontaire';
  @override
  _HomevolontaireState createState() => _HomevolontaireState();
}

class _HomevolontaireState extends State<Homevolontaire> {
  int selectedValue=0;
  bool regFilter = false;
  String ville = "", region = "";
  int id = 0;
  List<Demande> mesPosts;
  String pdpuser="",nomuser="";
  getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SessionManager.isUserLoggedIn().then((isLogged) {
      if (isLogged) {
        setState(() {
          ville = prefs.getString('ville');
          region = prefs.getString('region');
          pdpuser = prefs.getString('pdp');
          nomuser = prefs.getString('nom');
          nomuser += " ";
          nomuser += prefs.getString('prenom');
        });
      }
    });
  }

  var idController = new TextEditingController();
  var libelleController = new TextEditingController();
  var datedemandeController = new TextEditingController();
  var descriptionController = new TextEditingController();
  var etatController = new TextEditingController();
  var idUtilisateurController = new TextEditingController();
  var textStyle = TextStyle();
  List<Demande> demandes;
  getPosts() {
    APIServices.fetchPosts(ville).then((response) {
      Iterable list = json.decode(response.body);
      List<Demande> demandeList = List<Demande>();
      demandeList = list.map((model) => Demande.fromObject(model)).toList();
      setState(() {
        mesPosts = demandeList;
      });
    });
  }

  getDemandes() {
    APIServices.fetchVolontaireDemanades(ville).then((response) {
      Iterable list = json.decode(response.body);
      List<Demande> demandeList = List<Demande>();
      demandeList = list.map((model) => Demande.fromObject(model)).toList();
      setState(() {
        demandes = demandeList;
      });
    });
  }
  getDemandesRegion() {
    APIServices.fetchVolontaireDemanadesRegion(region).then((response) {
      Iterable list = json.decode(response.body);
      List<Demande> demandeList = List<Demande>();
      demandeList = list.map((model) => Demande.fromObject(model)).toList();
      setState(() {
        demandes = demandeList;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
       getPreferences();
    !regFilter ? getDemandes() : getDemandesRegion();
  getPosts();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: VolontaireDrawer(),
         floatingActionButton: _buildFloatingButton(),
          appBar: AppBar(
            title: Text('Mon Tableau de bord'),
            bottom: TabBar(tabs: [
              Tab(text: "Demandes"),
              Tab(text:  "Vos Posts"),
            ]),
          ),
          body: TabBarView(children: [
            (demandes == null || demandes.length == 0)
                ? Center(
                    child: Text('Aucun elemnet a afficher'),
                  )
                : _buildDemandesList(),
               (mesPosts == null || mesPosts.length == 0)
                ? Center(
                    child: Text('Aucun elemnet a afficher'),
                  )
                : _buildPostsList(),
          ])),
    );
  }

  Widget _buildDemandesList() {
    return new Column(
  mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      new Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: DualRadioButtonCard(
          title: 'Voulez-vous filtrer les demandes par :',
          option1: 'votre ville',
          option2: 'votre region',
          selectedValue: selectedValue,
          onChanged: (int selectionValue) {
            setState(() {
              selectedValue = selectionValue;
              (selectionValue == 0)
                  ? regFilter = false
                  : regFilter= true;
            });
          },
        )
      ),
      new Expanded(child: ListView.builder(
      itemCount: demandes.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Card(
              color: Colors.blue[50],
              elevation: 2.0,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10.0,),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10.0,
                      ),
                      Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image:  new NetworkImage(APIServices.urlBase +
                                          APIServices.urlUtilisateur +
                                          APIServices.urlGetImageUtilisateur +
                                          demandes[index].pdpuser)
                                     ))),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(demandes[index].nomuser) 
                    ],
                  ),
                  Card(
                      elevation: 2.0,
                      color: Colors.blue[100],
                      child: ListTile(
                        title: Text(demandes[index].libelle),
                        subtitle: Text(demandes[index].description),
                      )),
                     demandes[index].etat == "d"
                  ? new RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                textColor: Colors.white,
                                padding: const EdgeInsets.all(0.0),
                                onPressed: () { changeEtat(
                          demandes[index].id,
                          demandes[index].libelle,
                          demandes[index].datedemande,
                          demandes[index].description,
                          "e",demandes[index].idUtilisateur,demandes[index].pdpuser,demandes[index].nomuser);
                          navigateToContacterDemandeur(demandes[index].idUtilisateur);
                          },
                                child: Container(
                                  height: 40,
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(colors: [
                                        Color.fromRGBO(143, 148, 251, 1),
                                        Color.fromRGBO(143, 148, 251, .6),
                                      ])),
                                  padding: EdgeInsets.all(10.0),
                                  child: Center(
                                    child: Text('Intervenir',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                )): new RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            onPressed: () => changeEtat(
                          demandes[index].id,
                          demandes[index].libelle,
                          demandes[index].datedemande,
                          demandes[index].description,
                          "d",demandes[index].idUtilisateur,demandes[index].pdpuser,demandes[index].nomuser),
                            child: Container(
                              height: 40,
                              width: 100.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(colors: [
                                    Color.fromRGBO(143, 148, 251, 1),
                                    Color.fromRGBO(143, 148, 251, .6),
                                  ])),
                              padding: EdgeInsets.all(10.0),
                              child: Center(
                                child: Text('Annuler',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ),
                            )),

                ],
              )),
          onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new Commenter(
                            posts: demandes,
                            index: index,
                            wpdpuser: demandes[index].pdpuser,
                            wnomuser: demandes[index].nomuser,
                          )));
          }
        );
      },
    )
          )
    ],
   );
  

  }
  Widget _buildPostsList() {
    return ListView.builder(
      itemCount: mesPosts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Card(
              color: Colors.blue[50],
              elevation: 2.0,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10.0,),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10.0,
                      ),
                      Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image:  new NetworkImage(APIServices.urlBase +
                                          APIServices.urlUtilisateur +
                                          APIServices.urlGetImageUtilisateur +
                                          mesPosts[index].pdpuser)))),
                                     
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(mesPosts[index].nomuser)
                    ],
                  ),
                  Card(
                      elevation: 2.0,
                      color: Colors.blue[100],
                      child: ListTile(
                        title: Text(mesPosts[index].libelle),
                        subtitle: Text(mesPosts[index].description),
                      )),
                     
                ],
              )),
          onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new Commenter(
                            posts: mesPosts,
                            index: index,
                            wpdpuser: mesPosts[index].pdpuser,
                            wnomuser: mesPosts[index].nomuser,
                          )));
          }
        );
      },
    );
  }

  void changeEtat(int id, String libelle, String datedemande,
      String description, String etat,int iduser,String pdpuser,String nomuser) async {
    Demande demande =
        new Demande.WithId(id, libelle, datedemande, description, etat,iduser,pdpuser,nomuser);
    var saveResponse = await APIServices.putDemandeEncours(demande);
    saveResponse == true && demande.etat == 'e'
    ? Toasts.showSucssesToast("Intervention affectée") :
    saveResponse == true && demande.etat == 'd' ?
    Toasts.showSucssesToast("Intervention annulée")
    : Toasts.showSucssesToast("Une erreur est produite");
  }
    void navigateToContacterDemandeur(int idDem) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ContacterDemandeur(idusercontact: idDem,)),
    );
  }

    Widget _buildFloatingButton() {
    return FloatingActionButton(child: Icon(Icons.add), onPressed: () {
      Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new NewPost()));
    });
  }
}
