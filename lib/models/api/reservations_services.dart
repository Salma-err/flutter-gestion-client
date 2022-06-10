import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gestion_app/models/reservation.dart';

class ReservationServices {
  String url = 'http://amnzo.pythonanywhere.com/api';
  Future<List<Reservation>> getReservationsData() async {
    List<Reservation> reservations = [];

    http.Response res = await http.get(Uri.parse('$url/getrese'));
    final body = json.decode(res.body) as List;
    print("statusCode ${res.statusCode}");
    if (res.statusCode == 200) {
      reservations = body.map((e) => Reservation.fromJson(e)).toList();
    } else {
      throw "Failed to load Reservation list";
    }
    return reservations;
  }

  addReservation(Map map) async {
    print("hiii add  map: $map");
    final res = await http.post(Uri.parse('$url/getrese'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(map));

    print('map : $map , statusCode: ${res.statusCode}');
    if (res.statusCode == 200) {
      Reservation rs = Reservation.fromJson(jsonDecode(res.body));
      print('Ajout bien effectué de la reservation $rs');
    } else {
      throw Exception('Failed to add Reservation');
    }
  }

  editDateReservation(Map<String, dynamic> map) async {
    final res =
        await http.post(Uri.parse('http://amnzo.pythonanywhere.com/api/resize'),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode(map));
    print('MAP: ${jsonEncode(map)}, Status of edit: ${res.statusCode}');
    if (res.statusCode != 200) {
      throw Exception('Failed to update Reservation');
    }
  }

  editChambreReservation(Map<String, dynamic> map) async {
    final res = await http.post(
        Uri.parse('http://amnzo.pythonanywhere.com/api/updateroom'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(map));
    print('MAP: ${jsonEncode(map)}, Status of edit: ${res.statusCode}');
    if (res.statusCode == 200) {
      print('Mise A Jour bien effectuee de la reservation ');
    } else {
      throw Exception('Failed to update Reservation');
    }
  }

  deleteReservation(int id) async {
    final res = await http.get(Uri.parse('$url/delet_reservation/$id'));
    print("res : ${res.statusCode}");
    if (res.statusCode == 200) {
      print('Reservation est bien supprimée!');
    } else {
      throw Exception('Failed to delete Reservation');
    }
  }
}
