import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solidarite/Drawer/DemandeurDrawer.dart';
import 'package:solidarite/Helpers/Radio.dart';
import 'package:solidarite/Helpers/SessionManager.dart';
import 'package:solidarite/Models/Demande.dart';
import 'package:solidarite/Models/api.services.dart';
import 'package:solidarite/Views/Utilisateur/Commenter.dart';
import 'package:solidarite/Views/Utilisateur/NewDemande.dart';

import '../../Toasts.dart';

class HomeDemandeur extends StatefulWidget {
  static const String routeName = '/homedemandeur';
  @override
  _HomeDemandeurState createState() => _HomeDemandeurState();
}

class _HomeDemandeurState extends State<HomeDemandeur> {
  int selectedValue = 0;
  bool regFilter = false;
  int id = 0;
  String ville, pdpuser = "", nomuser = "",region = "";
  List<Demande> demandesActive;
  List<Demande> posts;

  getDemandesActive() {
    APIServices.fetchDemandeActive(id).then((response) {
      Iterable list = json.decode(response.body);
      List<Demande> demandeList = List<Demande>();
      demandeList = list.map((model) => Demande.fromObject(model)).toList();
      setState(() {
        demandesActive = demandeList;
      });
    });
  }

  getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SessionManager.isUserLoggedIn().then((isLogged) {
      if (isLogged) {
        setState(() {
          id = prefs.getInt('id');
          region = prefs.getString('region');
          ville = prefs.getString('ville');
          pdpuser = prefs.getString('pdp');
          nomuser = prefs.getString('nom');
          nomuser += " ";
          nomuser += prefs.getString('prenom');
        });
      }
    });
  }

  getPosts() {
    APIServices.fetchPosts(ville).then((response) {
      Iterable list = json.decode(response.body);
      List<Demande> demandeList = List<Demande>();
      demandeList = list.map((model) => Demande.fromObject(model)).toList();
      setState(() {
        posts = demandeList;
      });
    });
  }
  getPostsRegion() {
    APIServices.fetchPostsRegion(region).then((response) {
      Iterable list = json.decode(response.body);
      List<Demande> demandeList = List<Demande>();
      demandeList = list.map((model) => Demande.fromObject(model)).toList();
      setState(() {
        posts = demandeList;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    getPreferences();
    getDemandesActive();
    !regFilter ? getPosts() : getPostsRegion();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          drawer: DemandeurDrawer(),
          floatingActionButton: _buildFloatingButton(),
          appBar: AppBar(
            title: Text('Mon Tableau de bord'),
            bottom: TabBar(tabs: [
              Tab(text: "Mes demandes"),
              Tab(text: "Posts"),
            ]),
          ),
          body: TabBarView(children: [
            (demandesActive == null ||demandesActive.length == 0)
                ? Center(
                    child: Text('Aucun elemnet a afficher'),
                  )
                : _buildDemandesActiveList(),
            (posts == null||posts.length ==0)
                ? Center(
                    child: Text('Aucun elemnet a afficher'),
                  )
                : _buildPostsList(),
          ])),
    );
  }

  Widget _buildDemandesActiveList() {
    return ListView.builder(
      itemCount: demandesActive.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            child: Card(
                color: Colors.blue[50],
                elevation: 2.0,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
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
                                    image: new NetworkImage(
                                        APIServices.urlBase +
                                            APIServices.urlUtilisateur +
                                            APIServices.urlGetImageUtilisateur +
                                            demandesActive[index].pdpuser)))),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(demandesActive[index].nomuser)
                      ],
                    ),
                    Card(
                        elevation: 2.0,
                        color: Colors.blue[100],
                        child: ListTile(
                          title: Text(demandesActive[index].libelle),
                          subtitle: Text(demandesActive[index].description),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        demandesActive[index].etat == "e"
                            ? new RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                textColor: Colors.white,
                                padding: const EdgeInsets.all(0.0),
                                onPressed: () => changeEtat(
                                    demandesActive[index].id,
                                    demandesActive[index].libelle,
                                    demandesActive[index].datedemande,
                                    demandesActive[index].description,
                                    "d",
                                    demandesActive[index].idUtilisateur,
                                    demandesActive[index].pdpuser,
                                    demandesActive[index].nomuser),
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
                                    child: Text('Intialiser',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ))
                            : SizedBox(),
                        new RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            onPressed: () => changeEtat(
                                demandesActive[index].id,
                                demandesActive[index].libelle,
                                demandesActive[index].datedemande,
                                demandesActive[index].description,
                                "t",
                                demandesActive[index].idUtilisateur,
                                demandesActive[index].pdpuser,
                                demandesActive[index].nomuser),
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
                                child: Text('Finir',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ),
                            )),
                        SizedBox(
                          width: 10.0,
                        ),
                      ],
                    )
                  ],
                )),
            onTap: () {});
      },
    );
  }

  Widget _buildPostsList() {
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
                        : regFilter = true;
                  });
                },
              )),
          new Expanded(
              child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  child: Card(
                      color: Colors.blue[50],
                      elevation: 2.0,
                      child: Column(
                        children: <Widget>[
                                                        SizedBox(
                                height: 10.0,
                              ),
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
                                          image: new NetworkImage(
                                              APIServices.urlBase +
                                                  APIServices.urlUtilisateur +
                                                  APIServices
                                                      .urlGetImageUtilisateur +
                                                  posts[index].pdpuser)))),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(posts[index].nomuser)
                            ],
                          ),
                          Card(
                              elevation: 2.0,
                              color: Colors.blue[100],
                              child: ListTile(
                                title: Text(posts[index].libelle),
                                subtitle: Text(posts[index].description),
                              )),
                        ],
                      )),
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new Commenter(
                              posts: posts,
                              index: index,
                              wpdpuser: posts[index].pdpuser,
                              wnomuser: posts[index].nomuser,
                            )));
                  });
            },
          ))
        ]);
  }

  void changeEtat(
      int id,
      String libelle,
      String datedemande,
      String description,
      String etat,
      int iduser,
      String pdpuser,
      String nomuser) async {
    Demande demande = new Demande.WithId(
        id, libelle, datedemande, description, etat, iduser, pdpuser, nomuser);
    var saveResponse = await APIServices.putDemandeEncours(demande);
    saveResponse == true && etat == 't'
        ? Toasts.showSucssesToast("Demmande archivée")
        : saveResponse == true && etat == 'd'
            ? Toasts.showSucssesToast("Demmande Initialisée")
            : Toasts.showSucssesToast("Erreur du serveur");
  }

  void Supprimer(int iddem) async {
    var saveResponse = await APIServices.deletetDemande(iddem);
    saveResponse == true
        ? Toasts.showSucssesToast("Demande Supprimée")
        : Toasts.showSucssesToast("Erreur du serveur");
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          navigateToNewDemande();
        });
  }

  void navigateToNewDemande() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewDemande()),
    );
  }
}
