import 'package:flutter/material.dart';
import 'package:gestion_app/controllers/chambres_provider.dart';
import 'package:gestion_app/models/api/reservations_services.dart';
import 'package:gestion_app/models/client.dart';
import 'package:gestion_app/models/reservation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReservationsController extends GetxController {
  var reservations = <Reservation>[].obs;
  var isLoading = true.obs;
  var isError = false.obs;
  var idReservation = 0.obs;
  var chambre = 0.obs;
  var lastchambre = 0.obs;
  var rooms = <int>[].obs;
  var lastdb = ''.obs;
  var lastdf = ''.obs;
  TextEditingController dateDebutController = TextEditingController();
  TextEditingController dateFinController = TextEditingController();
  TextEditingController ChambreController = TextEditingController();

  var service = ReservationServices();

  @override
  void onInit() {
    getReservations();
    super.onInit();
  }

  getReservations() async {
    try {
      isLoading(true);
      var res = await service.getReservationsData();
      reservations.value = res;
    } catch (e) {
      isError(true);
    } finally {
      isLoading(false);
    }
  }

  addReservation(Map<String, dynamic> map) async {
    print("chambre $chambre");
    var debut = dateDebutController.text;
    var fin = dateFinController.text;
    var room = chambre.value;
    Map data = {
      'id': 1,
      'client': map['client'],
      'nom': map['nom'],
      'prenom': map['prenom'],
      'chambre': room,
      'date_debut': debut,
      'date_fin': fin
    };
    print("data $data");
    await service.addReservation(data);
    Get.snackbar("Succès", "La réservation est bien effectuée!",
        duration: const Duration(seconds: 2), snackPosition: SnackPosition.TOP);

    Get.close(1);
    getReservations();
    update();
  }

  editDateReservation(int id) async {
    //getting values of date controllers:
    var debut = dateDebutController.text;
    var fin = dateFinController.text;
    var dd = DateTime.parse(debut);
    var fd = DateTime.parse(fin);

    //getting last values of start date ant end date:
    var ld = lastdb.value;
    var lf = lastdf.value;
    var ldb = DateTime.parse(ld);
    var ldf = DateTime.parse(lf);

    //mapping data:
    Map<String, dynamic> data = {
      'id': id,
      'date_debut': debut,
      'date_fin': fin
    };

    //actions:
    loop:
    {
      for (var res in reservations) {
        if (res.chambre == chambre.value && res.id != idReservation.value) {
          if (compareTwoDates(res.date_debut, res.date_fin, dd, fd) ==
              "before") {
            if (!res.date_fin.isBefore(dd)) {
              snack(res);
              break loop;
            }
          } else {
            if (!res.date_debut.isAfter(fd)) {
              snack(res);
              break loop;
            }
          }
        }
      }

      await service.editDateReservation(data);
      dateDebutController.clear();
      dateFinController.clear();
      Get.snackbar("Succès", "La réservation est bien prolongée !",
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.TOP);
    }
    Get.close(1);
    getReservations();
    update();
  }

  editChambreReservation(int id, int chambre) async {
    Map<String, dynamic> data = {
      "id_resa": id,
      "id_room": chambre,
    };
    await service.editChambreReservation(data);
    ChambreController.clear();
    Get.snackbar("Succès", "La chambre réservée est bien changée !",
        duration: const Duration(seconds: 2), snackPosition: SnackPosition.TOP);

    Get.close(1);
    getReservations();
    update();
  }

  deleteReservation(int id) async {
    await service.deleteReservation(id);
    Get.snackbar("Succès", "La réservation est bien supprimée !",
        duration: const Duration(seconds: 2), snackPosition: SnackPosition.TOP);
    getReservations();
    update();
  }

  getChambres(BuildContext context, DateTime db, DateTime df) {
    var freeRooms = <int>[];
    var reservedRoom = <int>[];
    var removedItems = <int>[];

    //getting rooms data from provider
    var provider = Provider.of<ChambresProvider>(context);
    provider.getChambres(context);
    var rooms = provider.chambreList;

    if (reservations.value.isEmpty) {
      getReservations();
    }
    print('rooms : $rooms');
    print("reservations: $reservations");
    print("date-debut : $db");
    print("date-fin : $df");
    print('rooms : $rooms');
    for (var res in reservations) {
      var result = compareTwoDates(res.date_debut, res.date_fin, db, df);
      if (result != "into" &&
          freeRooms.contains(res.chambre) == false &&
          lastchambre.value != res.chambre) {
        freeRooms.add(res.chambre);
        print("not into chambre : ${res.chambre}");
      } else {
        if (!reservedRoom.contains(res.chambre) && result == "into") {
          print("hii reserved!!!");
          reservedRoom.add(res.chambre);
        }
      }
    }
    print("freeRooms: $freeRooms");
    print("reservedRooms: $reservedRoom");
    print('rooms : $rooms');

    for (var room in freeRooms) {
      if (reservedRoom.contains(room)) {
        removedItems.add(room);
      }
    }
    freeRooms.removeWhere((room) => removedItems.contains(room));

    for (var room in rooms) {
      if (!reservedRoom.contains(room.numero) &&
          !freeRooms.contains(room.numero)) {
        freeRooms.add(room.numero);
      }
    }
    print("freeRooms: $freeRooms");
    print("reservedRooms: $reservedRoom");
    print('rooms : $rooms');
    return freeRooms;
  }

  String compareTwoDates(
      DateTime db1, DateTime df1, DateTime db2, DateTime df2) {
    if (df1.isBefore(db2)) {
      print("before");
      return "before";
    } else {
      if (db1.isAfter(df2)) {
        print("after");
        return "after";
      } else {
        print('into');
        return "into";
      }
    }
  }

  void snack(Reservation reserv) {
    var db = DateFormat('yyyy-MM-dd').format(reserv.date_debut);
    var df = DateFormat('yyyy-MM-dd').format(reserv.date_fin);
    Get.snackbar("Chevauchement",
        "La chambre n°${reserv.chambre}  est déja réservée pour ${reserv.nom} ${reserv.prenom} depuis le $db jusqu'à le $df",
        duration: const Duration(seconds: 5),
        snackPosition: SnackPosition.BOTTOM);
  }
}

/* print("in : same room ");
          print(
              "reservation date début: ${reserv.date_debut}  date fin: ${reserv.date_fin}");
          print("réservation courante : date début: $dd  date fin: $fd");
          print(
              "result !reserv.date_fin.isBefore(dd) is : ${!reserv.date_fin.isBefore(dd)}");
          print(
              "result !reserv.date_debut.isAfter(fd)is : ${!reserv.date_debut.isAfter(fd)}");*/

/*if (!(reserv.date_fin.isBefore(dd) && ldb.isAfter(dd)) ||
              !(reserv.date_debut.isAfter(fd) && ldf.isBefore(fd))) {
            var db = DateFormat('yyyy-MM-dd').format(reserv.date_debut);
            var df = DateFormat('yyyy-MM-dd').format(reserv.date_fin);
            Get.snackbar("Chauvechement",
                "La chambre n°${reserv.chambre}  est déja réservée pour ${reserv.nom} ${reserv.prenom} depuis le $db jusqu'à le $df",
                duration: const Duration(seconds: 5),
                snackPosition: SnackPosition.BOTTOM);
            break loop;
          }*/
