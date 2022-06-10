import 'package:flutter/material.dart';
import 'package:gestion_app/controllers/reservations_controller.dart';
import 'package:gestion_app/models/reservation.dart';
import 'package:gestion_app/views/CRUD_forms/search_list_resevation_widget.dart';
import 'package:get/get.dart';

class MySearchDelegateReservations extends SearchDelegate {
  final controller = Get.put(ReservationsController());
  late List<Reservation> reservations = [];
  MySearchDelegateReservations();

  @override
  List<Widget>? buildActions(BuildContext context) {
    if (reservations.isEmpty) {
      reservations = controller.reservations;
    }
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) {
    List<Reservation> list = [];
    if (query.isNotEmpty) {
      list = Reservation.searchByName(reservations, query);
      print("list $list");
      if (list.isNotEmpty) {
        return SearchListReservationWidget(reservations: list, query: query);
      } else {
        return const Center(
          child: Text('Pas de résultat !'),
        );
      }
    } else {
      return const Center(
        child: Text(
          'Entrez le nom ou le prénom ou bien le nom complet du client',
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) => Container();
}
