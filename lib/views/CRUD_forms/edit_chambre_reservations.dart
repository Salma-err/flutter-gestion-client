import 'package:flutter/material.dart';
import 'package:gestion_app/controllers/reservations_controller.dart';
import 'package:gestion_app/models/reservation.dart';
import 'package:get/get.dart';

class EditChambreReservation extends StatefulWidget {
  final Reservation reservation;
  const EditChambreReservation({Key? key, required this.reservation})
      : super(key: key);

  @override
  State<EditChambreReservation> createState() => _EditChambreReservationState();
}

class _EditChambreReservationState extends State<EditChambreReservation> {
  final controller = Get.put(ReservationsController());
  List<int> chambres = [];
  late int item = chambres.isEmpty ? 0 : chambres[0];

  @override
  Widget build(BuildContext context) {
    if (chambres.isEmpty) {
      controller.lastchambre.value = widget.reservation.chambre;
      chambres = controller.getChambres(
          context, widget.reservation.date_debut, widget.reservation.date_fin);
    }
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (chambres.isNotEmpty) ...[
            const Text(
              'Changer la chambre de la réservation :',
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
            const Text(
              "çi dessous les chambres disponibles pour la période de réservation",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            DropdownButton(
              value: item,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: chambres.map((int chambre) {
                return DropdownMenuItem(
                  value: chambre,
                  child: Text(chambre.toString()),
                );
              }).toList(),
              onChanged: (int? newValue) {
                setState(() {
                  item = newValue!;
                });
                print("item $item");
              },
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  print("item2 $item");
                  controller.editChambreReservation(
                      widget.reservation.id, item);
                },
                child: const Text(
                  'Changer',
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
          ] else ...[
            const SizedBox(
              height: 10,
            ),
            Text(
              "Aucune chambre n'est disponible pour la période de réservation de ${widget.reservation.nom} ${widget.reservation.prenom}",
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ],
      ),
    );
  }
}
