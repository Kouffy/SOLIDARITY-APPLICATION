import 'package:flutter/material.dart';
import 'package:solidarite/Models/Commentaire.dart';
class Commentaires extends StatefulWidget {
  @override
  _CommentairesState createState() => _CommentairesState();
}

class _CommentairesState extends State<Commentaires> {
    List<Commentaire> commentaireList;
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
  
  Widget _buildCommentairesList() {
    return ListView.builder(
      itemCount: commentaireList.length,
      itemBuilder: (context, index) {
        return Card(
            color: Colors.white,
            elevation: 2.0,
            child: Column(
              children: <Widget>[
                Container(
                  child: new Row(
                    children: <Widget>[
                      new Flexible(
                        child: Text(commentaireList[index].contenu)
                      ),
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }
}
