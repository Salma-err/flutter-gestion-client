import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gestion_app/controllers/reservations_controller.dart';
import 'package:gestion_app/models/reservation.dart';
import 'package:gestion_app/views/CRUD_forms/edit_chambre_reservations.dart';
import 'package:gestion_app/views/CRUD_forms/edit_date_reservation.dart';
import 'package:gestion_app/views/reservationWidgets/details_reservation.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ReservationWidget extends StatelessWidget {
  final Reservation reservation;
  ReservationWidget({Key? key, required this.reservation}) : super(key: key);
  final controller = Get.put(ReservationsController());

  //sizes:
  Axis dirc = Axis.horizontal;
  double spacing = 0;
  double id = 0, res = 0, rom = 0, run = 0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    if (width <= 500) {
      dirc = Axis.vertical;
      spacing = 3.w;
      id = 10.sp;
      res = 15.sp;
      rom = 13.sp;
    } else {
      spacing = 5.w;
      id = 3.sp;
      res = 6.sp;
      rom = 4.sp;
    }

    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Slidable(
          child: buildReservation(context, reservation),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) {
                  Get.dialog(EditDateReservation(), arguments: reservation);
                },
                label: 'Prolonger',
                icon: Icons.date_range,
                backgroundColor: Colors.lightGreen,
                foregroundColor: Colors.white,
              ),
              SlidableAction(
                onPressed: (_) {
                  Get.dialog(EditChambreReservation(
                    reservation: reservation,
                  ));
                },
                label: 'Changer Chambre',
                icon: Icons.room,
                backgroundColor: Color.fromARGB(255, 132, 190, 217),
                foregroundColor: Colors.white,
              ),
            ],
          ),
          endActionPane: ActionPane(motion: const ScrollMotion(), children: [
            SlidableAction(
              onPressed: (_) => {
                Get.defaultDialog(
                  barrierDismissible: false,
                  title: 'Etes-vous sur ?',
                  content: const Center(
                      child: Text(
                    'Voulez-vous surement supprimer cette réservation ?',
                    style: TextStyle(fontSize: 15, letterSpacing: 1),
                    textAlign: TextAlign.center,
                  )),
                  textConfirm: 'Oui',
                  textCancel: 'Non',
                  onConfirm: () => {
                    controller.deleteReservation(reservation.id),
                    Navigator.pop(context)
                  },
                  onCancel: () => {Navigator.pop(context)},
                )
              },
              label: 'Supprimer',
              icon: Icons.delete,
              backgroundColor: Color.fromARGB(255, 249, 127, 127),
              foregroundColor: Colors.white,
            ),
          ]),
        ));
  }

  Widget buildReservation(BuildContext context, Reservation reservation) {
    return GestureDetector(
      onTap: () {
        Get.dialog(DetailsReservation(), arguments: reservation);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        child: SizedBox(
          width: 100.w,
          child: Container(
            alignment: Alignment.center,
            child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: run,
                spacing: spacing,
                direction: dirc,
                children: [
                  Text(
                    '${reservation.id}',
                    style: TextStyle(
                      fontSize: id,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 2,
                      color: const Color.fromRGBO(220, 215, 176, 1),
                    ),
                  ),
                  Text(
                    '${reservation.prenom} ${reservation.nom}',
                    style: TextStyle(
                      fontSize: res,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    'Chambre ${reservation.chambre}',
                    style: TextStyle(
                      fontSize: rom,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 2,
                      color: const Color.fromRGBO(224, 202, 60, 1),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
  /*
  editClient(BuildContext context, Client _client) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => EditClient(client: _client)));
  }

  deleteClient(BuildContext context, int id) async {
    final provider = Provider.of<ClientsProvider>(context, listen: false);
    provider.removeClient(id);
    Utils.showSnackBar(context, 'Excellent, Suppression bien effectuée !');
  }*/
}
