import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gestion_app/model/client.dart';

class ClientServices {
  String url = 'http://amnzo.pythonanywhere.com/api/getclients';
  Future<List<Client>> getClientsData() async {
    List<Client> clients = [];
    try {
      http.Response res = await http.get(Uri.parse(url));
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

    final res = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(client));

    if (res.statusCode == 201) {
      Client cl = Client.fromJson(jsonDecode(res.body));
      print('Ajout bien effectué du  client $cl');
    } else {
      throw Exception('Failed to add client');
    }
  }

  editClient(Client cl) async {
    print('Inside service :');
    Map client = {
      'nom': cl.nom,
      'prenom': cl.prenom,
      'id': cl.id,
      'code': cl.code,
      'tel': cl.tel,
      'mail': cl.mail,
      'verified': cl.verified
    };

    final res = await http.post(
        Uri.parse('http://amnzo.pythonanywhere.com/api/editclient'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(client));

    if (res.statusCode == 200) {
      Client cl = Client.fromJson(jsonDecode(res.body));
      print('Mise A Jour bien effectuée du client : $cl');
    } else {
      throw Exception('Failed to update client');
    }
  }

  deleteClient(int id) async {
    final res = await http
        .get(Uri.parse('http://amnzo.pythonanywhere.com/api/delet_client/$id'));

    if (res.statusCode == 200) {
      print('Client est bien supprimé!');
    } else {
      throw Exception('Failed to delete client');
    }
  }
}
