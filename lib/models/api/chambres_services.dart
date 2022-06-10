import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gestion_app/models/chambre.dart';

class ChambreServices {
  String url = 'http://amnzo.pythonanywhere.com/api';

  Future<List<Chambre>> getChambresData() async {
    List<Chambre> chambres = [];
    try {
      http.Response res = await http.get(Uri.parse('$url/getchambres'));
      if (res.statusCode == 200) {
        final body = json.decode(res.body) as List;
        chambres = body.map((e) => Chambre.fromJson(e)).toList();
      } else {
        throw "Failed to load hotel Room list";
      }
    } catch (e) {
      rethrow;
    }
    return chambres;
  }

  addChambre(Chambre ch) async {
    Map chambre = {
      'numero': ch.numero,
    };

    final res = await http.post(Uri.parse('$url/getchambres'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(chambre));
    if (res.statusCode == 201) {
      print("true");
      return true;
    } else {
      print("false");
      return false;
    }
  }

  editChambre(Chambre ch) async {
    Map chambre = {
      'id': ch.id,
      'numero': ch.numero,
    };

    final res = await http.post(Uri.parse('$url/update_room_info'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(chambre));
    print(res.statusCode);
    if (res.statusCode == 200) {
      print("true");
      return true;
    } else {
      print("false");
      return false;
    }
  }

  deleteChambre(int id) async {
    final res = await http.get(Uri.parse('$url/delet_room/$id'));
    print(res.statusCode);
    if (res.statusCode == 200) {
      print("true");
      return true;
    } else {
      print("false");
      return false;
    }
  }
}
