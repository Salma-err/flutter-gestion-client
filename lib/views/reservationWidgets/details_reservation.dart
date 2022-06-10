import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DetailsReservation extends StatelessWidget {
  var reservation;

  DetailsReservation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    reservation = Get.arguments;
    var dateDebut = DateFormat('EEEE d MMM, y').format(reservation.date_debut);
    var dateFin = DateFormat('EEEE d MMM, y').format(reservation.date_fin);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${reservation.nom} ${reservation.prenom}',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              letterSpacing: 3,
              wordSpacing: 4,
              color: Color.fromRGBO(224, 202, 60, 1),
              //fontStyle: FontStyle.italic,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            height: 0.5,
            color: const Color.fromRGBO(220, 215, 176, 1),
          ),
          edit('Id de réservation :', reservation.id.toString()),
          const SizedBox(height: 16),
          edit('Id du client :', '${reservation.client}'),
          const SizedBox(height: 16),
          edit('Id de la chambre :', '${reservation.chambre}'),
          const SizedBox(height: 16),
          edit('Date de début :', dateDebut),
          const SizedBox(height: 16),
          edit('Date de fin :', dateFin),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  edit(String label, String value) {
    return Wrap(
      runSpacing: 10,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            letterSpacing: 2,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            letterSpacing: 1,
            color: Color.fromRGBO(2, 69, 64, 1),
          ),
        )
      ],
    );
  }
}
