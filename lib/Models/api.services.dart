import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:solidarite/Models/Administrateur.dart';
import 'package:solidarite/Models/Commentaire.dart';
import 'package:solidarite/Models/Demande.dart';
import 'package:solidarite/Models/Rapport.dart';
import 'package:solidarite/Models/Utilisateur.dart';

class APIServices {
  static String urlBase = 'http://192.168.1.4:9090/api/';
  static String urlUtilisateur = 'utilisateur/';
  static String urlAdministrateur = 'administrateur/';
  static String urlDemande = 'demande/';
  static String urlRapport = 'rapport/';
  static String urlRegion = 'region/';
  static String urlVille = 'ville/';
  static String urlCommentaire = 'Commentaire/';
  static String urlDemandeActive = 'GetDemandeActive/';
  static String urlDemandeArchive = 'GetDemandeArchive/';
  static String urlVolontaireDemande = 'GetVolontaireDemandes/';
   static String urlVolontaireDemandeRegion = 'GetVolontaireDemandesRegion/';
  static String urlVolontaire = 'GetVolontaire/';
  static String urlPutDemandeEnCours = 'PutDemandeEnCours/';
  static String urlPostImageUtilisateur = 'PostUtilisateurPhoto/';
  static String urlGetImageUtilisateur = 'GetUtilisateurImage/';
  static String urlGetPosts = 'GetPosts/';
   static String urlGetPostsRegion = 'GetPostsRegion/';
  static String urlGetPdp = 'GetUtilisateurPDP/';
  static String urlGetCommentaire = 'GetCommentaireDemande/';
  static String urlGetMesPosts = 'GetMesPosts/';

  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  static Future fetchRegion() async {
    return await http.get(urlBase + urlRegion);
  }
    static Future fetchVille() async {
    return await http.get(urlBase + urlVille);
  }
  static Future fetchUtilisateur() async {
    return await http.get(urlBase + urlUtilisateur);
  }

  static Future fetchSpecificUtilisateur(int id) async {
    var res = await http.get(urlBase + urlUtilisateur + id.toString());
    return res;
  }

  static Future fetchVolontairePosts(String ville, int id) async {
    return await http.get(urlBase + urlDemande + ville + "/" + id.toString());
  }

  static Future fetchVolontaireDemanades(String ville) async {
    return await http.get(urlBase + urlDemande +urlVolontaireDemande + ville);
  }
  static Future fetchVolontaireDemanadesRegion(String ville) async {
    return await http.get(urlBase + urlDemande +urlVolontaireDemandeRegion + ville);
  }
  static Future fetchMesPosts(int id) async {
    return await http
        .get(urlBase + urlDemande + urlGetMesPosts + id.toString());
  }

  static Future fetchCommentaireDemande(int idDemande) async {
    return await http.get(
        urlBase + urlCommentaire + urlGetCommentaire + idDemande.toString());
  }

  static Future fetchPosts(String ville) async {
    return await http.get(urlBase + urlDemande + urlGetPosts + ville);
  }
  static Future fetchPostsRegion(String ville) async {
    return await http.get(urlBase + urlDemande + urlGetPostsRegion + ville);
  }
  static Future fetchAllDemande() async {
    return await http.get(urlBase + urlDemande);
  }

  static Future fetchAllRapports() async {
    return await http.get(urlBase + urlRapport);
  }

  static Future fetchDemandeActive(int id) async {
    return await http
        .get(urlBase + urlDemande + urlDemandeActive + id.toString());
  }

  static Future fetchDemandeArchive(int id) async {
    return await http
        .get(urlBase + urlDemande + urlDemandeArchive + id.toString());
  }

  static Future fetchVolontaires(String ville) async {
    return await http.get(urlBase + urlUtilisateur + urlVolontaire + ville);
  }

  static Future<bool> postUtilisateurPhoto(File imageFile) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(urlBase + urlUtilisateur + urlPostImageUtilisateur));
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));
    var res = await request.send();
    print(res.statusCode);
    return Future.value(res.statusCode == 200 ? true : false);
  }

  static Future<bool> postUtilisateur(Utilisateur utilisateur) async {
    var monUtilisateur = utilisateur.toMap();
    var utilisateurBody = convert.json.encode(monUtilisateur);
    var res = await http.post(urlBase + urlUtilisateur,
        headers: header, body: utilisateurBody);
    print(res.statusCode);
    return Future.value(res.statusCode == 201 ? true : false);
  }

  static Future<bool> postAdministateur(Administrateur administrateur) async {
    var monAdministrateur = administrateur.toMap();
    var administrateurBody = convert.json.encode(monAdministrateur);
    var res = await http.post(urlBase + urlAdministrateur,
        headers: header, body: administrateurBody);
    print(res.statusCode);
    return Future.value(res.statusCode == 201 ? true : false);
  }

  static Future<bool> postDemande(Demande demande) async {
    var monDemande = demande.toMap();
    var demandeBody = convert.json.encode(monDemande);
    var res = await http.post(urlBase + urlDemande,
        headers: header, body: demandeBody);
    print(res.statusCode);
    return Future.value(res.statusCode == 201 ? true : false);
  }

  static Future<bool> postRapport(Rapport rapport) async {
    var monRapport = rapport.toMap();
    var rapportBody = convert.json.encode(monRapport);
    var res = await http.post(urlBase + urlRapport,
        headers: header, body: rapportBody);
    print(res.statusCode);
    return Future.value(res.statusCode == 201 ? true : false);
  }

  static Future<bool> postCommantaire(Commentaire commentaire) async {
    var monCommentaire = commentaire.toMap();
    var commentaireBody = convert.json.encode(monCommentaire);
    var res = await http.post(urlBase + urlCommentaire,
        headers: header, body: commentaireBody);
    print(res.statusCode);
    return Future.value(res.statusCode == 201 ? true : false);
  }

  static Future<bool> putDemandeEncours(Demande demande) async {
    var monDemande = demande.toMap();
    var demandeBody = convert.json.encode(monDemande);
    var res = await http.put(
        urlBase + urlDemande + urlPutDemandeEnCours + demande.id.toString(),
        headers: header,
        body: demandeBody);
    print(res.statusCode);
    return Future.value(res.statusCode == 204 ? true : false);
  }

  static Future<bool> putUtilisateur(Utilisateur utilisateur) async {
    var monUtilisateur = utilisateur.toMap();
    var utilisateurBody = convert.json.encode(monUtilisateur);
    var res = await http.put(
        urlBase + urlUtilisateur + utilisateur.id.toString(),
        headers: header,
        body: utilisateurBody);
    print(res.statusCode);
    return Future.value(res.statusCode == 204 ? true : false);
  }

  static Future<bool> deletetUtilisateur(int id) async {
    var res = await http.delete(urlBase + urlUtilisateur + id.toString(),
        headers: header);
    print(res.statusCode);
    return Future.value(res.statusCode == 200 ? true : false);
  }

  static Future<bool> deletetDemande(int id) async {
    var res = await http.delete(urlBase + urlDemande + id.toString(),
        headers: header);
    print(res.statusCode);
    return Future.value(res.statusCode == 200 ? true : false);
  }

  static Future<bool> deleteRapport(int id) async {
    var res = await http.delete(urlBase + urlRapport + id.toString(),
        headers: header);
    print(res.statusCode);
    return Future.value(res.statusCode == 200 ? true : false);
  }

  static Future getUtilisateur(int id) async {
    var res = await http.get(urlBase + urlUtilisateur + id.toString());
    return res;
  }

  static Future getUtilisateurLogin(String login, String password) async {
    var res = await http.get(urlBase + urlUtilisateur + login + "/" + password);
    return res;
  }

  static Future getAdministateurLogin(String login, String password) async {
    var res =
        await http.get(urlBase + urlAdministrateur + login + '/' + password);
    return res;
  }
}
