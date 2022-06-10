import 'package:flutter/material.dart';
import 'package:gestion_app/controllers/reservations_controller.dart';
import 'package:gestion_app/models/reservation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditDateReservation extends StatelessWidget {
  EditDateReservation({Key? key}) : super(key: key);
  final controller = Get.put(ReservationsController());
  late final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    reservation = Get.arguments;

    controller.dateDebutController.text =
        DateFormat('y-MM-dd').format(reservation.date_debut).toString();
    controller.dateFinController.text =
        DateFormat('y-MM-dd').format(reservation.date_fin).toString();
    controller.chambre.value = reservation.chambre;
    controller.idReservation.value = reservation.id;
    controller.lastdb.value = reservation.date_debut.toString();
    controller.lastdf.value = reservation.date_fin.toString();

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Prolonger la réservation :',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              letterSpacing: 1,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            height: 0.5,
            color: const Color.fromRGBO(220, 215, 176, 1),
          ),
          TextFormField(
              controller: controller.dateDebutController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Date de début :',
              ),
              onTap: () async {
                DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: reservation.date_debut,
                    firstDate: DateTime(2015),
                    lastDate: DateTime(2222));

                if (date != null) {
                  String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                  controller.dateDebutController.text = formattedDate;
                } else {
                  print("Date is not selected");
                  Get.snackbar("Echec", "Date de début n'est pas sélectionnée",
                      duration: const Duration(seconds: 2),
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red);
                }
              }),
          const SizedBox(height: 16),
          TextFormField(
              controller: controller.dateFinController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Date de fin :',
              ),
              onTap: () async {
                DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.parse(
                                controller.dateDebutController.text)
                            .isAfter(reservation.date_fin)
                        ? DateTime.parse(controller.dateDebutController.text)
                            .add(const Duration(days: 1))
                        : reservation.date_fin,
                    firstDate:
                        DateTime.parse(controller.dateDebutController.text),
                    lastDate: DateTime(2222));

                if (date != null) {
                  String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                  controller.dateFinController.text = formattedDate;
                } else {
                  print("Date is not selected");
                  Get.snackbar("Echec", "Date de fin n'est pas sélectionnée",
                      duration: const Duration(seconds: 2),
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red);
                }
              }),
          const SizedBox(height: 12),
          const Text(
            "Vous devez confirmez les deux dates avant d'enregistrer * ",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              letterSpacing: 1,
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (controller.dateDebutController.text ==
                        reservation.date_debut.toString() &&
                    controller.dateFinController.text ==
                        reservation.date_fin.toString()) {
                  controller.dateDebutController.text =
                      DateFormat('yyyy-MM-dd').format(reservation.date_debut);
                  controller.dateFinController.text =
                      DateFormat('yyyy-MM-dd').format(reservation.date_fin);
                }
                controller.editDateReservation(reservation.id);
              },
              child: const Text(
                'Enregistrer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w400,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
