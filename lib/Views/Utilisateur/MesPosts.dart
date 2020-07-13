import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solidarite/Drawer/VolontaireDrawer.dart';
import 'package:solidarite/Models/Demande.dart';
import 'package:solidarite/Models/api.services.dart';
import 'package:solidarite/Views/Utilisateur/NewPost.dart';

import 'Commenter.dart';

class MesPosts extends StatefulWidget {
  @override
  _MesPostsState createState() => _MesPostsState();
}

class _MesPostsState extends State<MesPosts> {
  String ville = "", region = "";
  int id = 0;
  List<Demande> mesPosts;
  String pdpuser = "", nomuser = "";
  getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getInt('id');
      ville = prefs.getString('ville');
      pdpuser = prefs.getString('pdp');
      nomuser = prefs.getString('nom');
      nomuser += " ";
      nomuser += prefs.getString('prenom');
      print(id);
    });
  }

  getMesPosts() {
    getPreferences();
    APIServices.fetchMesPosts(id).then((response) {
      Iterable list = json.decode(response.body);
      List<Demande> demandeList = List<Demande>();
      demandeList = list.map((model) => Demande.fromObject(model)).toList();
      setState(() {
        mesPosts = demandeList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
  getMesPosts();
    return Scaffold(
         floatingActionButton: _buildFloatingButton(),
          appBar: AppBar(title: Text('Mes Posts'),),
          body: (mesPosts == null || mesPosts.length == 0)
                ? Center(
                    child: Text('Aucun elemnet a afficher'),
                  )
                : _buildMesPostsList(),
    );
  }
   Widget _buildMesPostsList() {
    return ListView.builder(
      itemCount: mesPosts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Card(
              color: Colors.blue[50],
              elevation: 2.0,
              child: Column(
                children: <Widget>[
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
 Widget _buildFloatingButton() {
    return FloatingActionButton(child: Icon(Icons.add), onPressed: () {
      Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new NewPost()));
    });
  }
}
