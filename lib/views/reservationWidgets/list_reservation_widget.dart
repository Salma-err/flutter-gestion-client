import 'package:flutter/material.dart';
import 'package:gestion_app/controllers/reservations_controller.dart';
import 'package:gestion_app/views/reservationWidgets/reservation_widget.dart';
import 'package:get/get.dart';

class ListReservationWidget extends StatelessWidget {
  final controller = Get.put(ReservationsController());

  ListReservationWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("reservations: ${controller.reservations}");
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
              ReservationWidget(reservation: controller.reservations[index]),
          itemCount: controller.reservations.length,
        );
      }
    });
  }
}
