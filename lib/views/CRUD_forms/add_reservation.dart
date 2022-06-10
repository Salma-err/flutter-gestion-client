import 'package:flutter/material.dart';
import 'package:gestion_app/controllers/reservations_controller.dart';
import 'package:gestion_app/models/client.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddReservation extends StatefulWidget {
  AddReservation({Key? key}) : super(key: key);
  final controller = Get.put(ReservationsController());

  @override
  State<AddReservation> createState() => _AddReservationState();
}

class _AddReservationState extends State<AddReservation> {
  final Client client = Get.arguments;
  List<int> chambres = [];
  late int item = chambres.isEmpty ? 0 : chambres[0];

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime oneDay = DateTime.now().add(const Duration(days: 1));

    DateTime dateD = DateTime(now.year, now.month, now.day);
    DateTime dateF = DateTime(oneDay.year, oneDay.month, oneDay.day);

    if (chambres.isEmpty) {
      widget.controller.lastchambre.value = 0;
      chambres = widget.controller.getChambres(context, dateD, dateF);
    }

    widget.controller.dateDebutController.text = DateTime.now().toString();
    widget.controller.dateFinController.text =
        DateTime.now().add(const Duration(days: 1)).toString();

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (chambres.isNotEmpty) ...[
            Text(
              'Réserver pour ${client.nom} ${client.prenom}',
              style: const TextStyle(
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
              "çi dessous les chambres disponibles depuis aujourd'hui",
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
                widget.controller.chambre.value = item;
                print("item $item");
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
                controller: widget.controller.dateDebutController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Date de début :',
                ),
                onTap: () async {
                  DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2222));

                  if (date != null) {
                    widget.controller.dateDebutController.text =
                        date.toString();
                  } else {
                    print("Date is not selected");
                    Get.snackbar(
                        "Echec", "Date de début n'est pas sélectionnée",
                        duration: const Duration(seconds: 2),
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red);
                  }
                }),
            const SizedBox(height: 16),
            TextFormField(
                controller: widget.controller.dateFinController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Date de fin :',
                ),
                onTap: () async {
                  DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.parse(
                              widget.controller.dateDebutController.text)
                          .add(const Duration(days: 1)),
                      firstDate: DateTime.parse(
                              widget.controller.dateDebutController.text)
                          .add(const Duration(days: 1)),
                      lastDate: DateTime(2222));

                  if (date != null) {
                    widget.controller.dateFinController.text = date.toString();
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
                  if (widget.controller.dateDebutController.text ==
                          DateTime.now().toString() &&
                      widget.controller.dateFinController.text ==
                          DateTime.now()
                              .add(const Duration(days: 1))
                              .toString()) {
                    /* widget.controller.dateDebutController.text =
                        DateFormat('yyyy-MM-dd').format(DateTime.now());
                    widget.controller.dateFinController.text =
                        DateFormat('yyyy-MM-dd').format(
                            DateTime.now().add(const Duration(days: 1)));*/
                    widget.controller.dateDebutController.text =
                        DateTime.now().toString();
                    widget.controller.dateFinController.text =
                        DateTime.now().add(const Duration(days: 1)).toString();
                  }
                  Map<String, dynamic> dataClient = {
                    "client": client.id,
                    "nom": client.nom,
                    "prenom": client.prenom,
                  };
                  print('datetime : ${DateTime.now().toString()}');
                  widget.controller.addReservation(dataClient);
                },
                child: const Text(
                  'Réserver',
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
            const Text(
              "Aucune chambre n'est disponible !",
              style: TextStyle(
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
