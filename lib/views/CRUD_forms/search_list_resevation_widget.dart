import 'package:flutter/material.dart';
import 'package:gestion_app/controllers/reservations_controller.dart';
import 'package:gestion_app/models/reservation.dart';
import 'package:gestion_app/views/reservationWidgets/reservation_widget.dart';
import 'package:get/get.dart';

class SearchListReservationWidget extends StatefulWidget {
  List<Reservation> reservations;
  String query = '';
  SearchListReservationWidget(
      {Key? key, required this.reservations, required this.query})
      : super(key: key);

  @override
  State<SearchListReservationWidget> createState() =>
      _SearchListReservationWidgetState();
}

class _SearchListReservationWidgetState
    extends State<SearchListReservationWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller = Get.put(ReservationsController());
    widget.reservations = controller.reservations;
    widget.reservations =
        Reservation.searchByName(widget.reservations, widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return GetX<ReservationsController>(builder: (controller) {
      if (controller.isLoading.value == true) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return ListView.separated(
          padding: const EdgeInsets.all(20.0),
          physics: const ScrollPhysics(),
          separatorBuilder: (context, index) => Container(height: 8.0),
          itemBuilder: (context, index) =>
              ReservationWidget(reservation: widget.reservations[index]),
          itemCount: widget.reservations.length,
        );
      }
    });
  }
}
