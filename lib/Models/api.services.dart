import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:solidarite/Models/Demande.dart';
import 'package:solidarite/Models/Utilisateur.dart';

class APIServices {
  static String utilisateurUrl = 'http://192.168.1.5:9090/api/utilisateur/';
  static String demandeUrl = 'http://192.168.1.5:9090/api/demande/';
  static String demandeActiveUrl = 'GetDemandeActive/';
  static String demandeArchiveUrl = 'GetDemandeArchive/';
  static String volontaireUrl = 'GetVolontaire/';
  static String demandePutEnCoursUrl = 'PutDemandeEnCours/';

  static Future fetchUtilisateur() async {
    return await http.get(utilisateurUrl);
  }

  static Future fetchDemande(String ville, int id) async {
    return await http.get(demandeUrl + ville + "/" + id.toString());
  }

  static Future fetchDemandeActive(int id) async {
    return await http.get(demandeUrl + demandeActiveUrl + id.toString());
  }

  static Future fetchDemandeArchive(int id) async {
    return await http.get(demandeUrl + demandeArchiveUrl + id.toString());
  }

  static Future fetchVolontaires(String ville) async {
    return await http.get(utilisateurUrl + volontaireUrl + ville);
  }

  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  static Future<bool> postUtilisateur(Utilisateur utilisateur) async {
    var monUtilisateur = utilisateur.toMap();
    var utilisateurBody = convert.json.encode(monUtilisateur);
    var res =
        await http.post(utilisateurUrl, headers: header, body: utilisateurBody);
    print(res.statusCode);
    return Future.value(res.statusCode == 201 ? true : false);
  }

  static Future<bool> postDemande(Demande demande) async {
    var monDemande = demande.toMap();
    var demandeBody = convert.json.encode(monDemande);
    var res = await http.post(demandeUrl, headers: header, body: demandeBody);
    print(res.statusCode);
    return Future.value(res.statusCode == 201 ? true : false);
  }

  static Future<bool> putDemandeEncours(Demande demande) async {
    var monDemande = demande.toMap();
    var demandeBody = convert.json.encode(monDemande);
    var res = await http.put(demandeUrl + demandePutEnCoursUrl + demande.id.toString(), headers: header, body: demandeBody);
    print(res.statusCode);
    return Future.value(res.statusCode == 204 ? true : false);
  }

  static Future<bool> deletetUtilisateur(int id) async {
    var res =
        await http.delete(utilisateurUrl + id.toString(), headers: header);
    print(res.statusCode);
    return Future.value(res.statusCode == 200 ? true : false);
  }

  static Future getUtilisateurLogin(String login, String password) async {
    var res = await http.get(utilisateurUrl + login + "/" + password);
    return res;
  }
}
