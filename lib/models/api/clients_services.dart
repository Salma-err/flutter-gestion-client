import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gestion_app/models/client.dart';

class ClientServices {
  String url = 'http://amnzo.pythonanywhere.com/api';
  Future<List<Client>> getClientsData() async {
    List<Client> clients = [];
    try {
      http.Response res = await http.get(Uri.parse('$url/getclients'));
      if (res.statusCode == 200) {
        final body = json.decode(res.body) as List;
        clients = body.map((e) => Client.fromJson(e)).toList();
      } else {
        throw "Failed to load client list";
      }
    } catch (e) {
      rethrow;
    }
    return clients;
  }

  addClient(Client cl) async {
    Map client = {
      'nom': cl.nom,
      'prenom': cl.prenom,
      'id': cl.id,
      'code': cl.code,
      'tel': cl.tel,
      'mail': cl.mail,
      'verified': cl.verified
    };

    final res = await http.post(Uri.parse('$url/getclients'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(client));

    if (res.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  editClient(Client cl) async {
    Map client = {
      'nom': cl.nom,
      'prenom': cl.prenom,
      'id': cl.id,
      'code': cl.code,
      'tel': cl.tel,
      'mail': cl.mail,
      'verified': cl.verified
    };

    final res = await http.post(Uri.parse('$url/editclient'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(client));

    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  deleteClient(int id) async {
    final res = await http.get(Uri.parse('$url/delet_client/$id'));

    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
