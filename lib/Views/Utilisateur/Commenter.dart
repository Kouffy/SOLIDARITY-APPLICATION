import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solidarite/Models/Commentaire.dart';
import 'package:solidarite/Models/api.services.dart';

import '../../Toasts.dart';

class Commenter extends StatefulWidget {
  final List posts;
  final int index;
  final String wpdpuser;
  final String wnomuser;
  Commenter({this.index, this.posts, this.wpdpuser, this.wnomuser});
  @override
  _CommenterState createState() => _CommenterState();
}

class _CommenterState extends State<Commenter> {
  List<Commentaire> comments;
  TextEditingController commentaireController = new TextEditingController();
  int id = 0;
  String ville, pdpuser = "", nomuser = "";
  getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getInt('id');
      ville = prefs.getString('ville');
      pdpuser = prefs.getString('pdp');
      nomuser = prefs.getString('nom');
      nomuser = " ";
      nomuser += prefs.getString('prenom');
      print(id);
    });
  }

  getCommentaires() {
    APIServices.fetchCommentaireDemande(widget.posts[widget.index].id)
        .then((response) {
      Iterable list = json.decode(response.body);
      List<Commentaire> commentaireList = List<Commentaire>();
      commentaireList =
          list.map((model) => Commentaire.fromObject(model)).toList();
      setState(() {
        comments = commentaireList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getCommentaires();
    getPreferences();
    return Scaffold(
      appBar: new AppBar(
        title: Text('Details du Post'),
      ),
      body: ListView(
        children: <Widget>[
          Center(
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
                                            widget.wpdpuser)))),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(widget.wnomuser)
                      ],
                    ),
                    Card(
                        elevation: 2.0,
                        color: Colors.blue[100],
                        child: ListTile(
                          title: Text(widget.posts[widget.index].libelle),
                          subtitle:
                              Text(widget.posts[widget.index].description),
                        )),
                    new Row(
                      children: <Widget>[
                        new Flexible(
                          child:   Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[100]))),
                        child: TextField(
                          controller: commentaireController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Votre commentaire",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                        ),
                      ),
                        ),
                        new RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            onPressed: () {
                            commenter(widget.posts[widget.index].idUtilisateur,
                                widget.posts[widget.index].id);
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
                                child: Text('Commenter',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ),
                            )),
                      ],
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height/2,
                        child: comments != null
                            ? _buildCommentairesList()
                            : Center(
                                child: Text("data"),
                              ))
                  ],
                )),
          ),
        ],
      ),
    );
  }

  void commenter(int idUser, int idDemande) async {
    Commentaire commentaire = new Commentaire(commentaireController.text,
        DateTime.now().toString(), idUser, idDemande, pdpuser, nomuser);
    var saveResponse = await APIServices.postCommantaire(commentaire);
    if (saveResponse == true) {
      Toasts.showSucssesToast('Commentaire publié');
      commentaireController.text = "";
    } else {
      Toasts.showFailedToast('Commentaire non publié');
    }
  }

  Widget _buildCommentairesList() {
    return ListView.builder(
      itemCount: comments.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            child: Card(
                color: Colors.blue[50],
                elevation: 2.0,
                child: Column(
                  children: <Widget>[
                    Card(
                        elevation: 2.0,
                        color: Colors.blue[100],
                        child: ListTile(
                          title: Text(comments[index].nomuser),
                          subtitle: Text(comments[index].contenu),
                          trailing:  Text(comments[index].dateCommentaire.substring(0,16).toString()),
                          leading: Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new NetworkImage(APIServices
                                              .urlBase +
                                          APIServices.urlUtilisateur +
                                          APIServices.urlGetImageUtilisateur +
                                          comments[index].pdpuser)))),
                        )),
                       
                  ],
                )),
            onTap: () {});
      },
    );
  }
}
