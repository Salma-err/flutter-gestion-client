import 'package:flutter/material.dart';
import 'package:gestion_app/controllers/reservations_controller.dart';
import 'package:gestion_app/models/client.dart';
import 'package:gestion_app/views/clientWidgets/client_widget.dart';
import 'package:get/get.dart';

class ListClientWidget extends StatelessWidget {
  ListClientWidget({Key? key, required this.clients}) : super(key: key);
  final controller = Get.put(ReservationsController());
  final List<Client> clients;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20.0),
      physics: const ScrollPhysics(),
      separatorBuilder: (context, index) => Container(height: 8.0),
      itemBuilder: (context, index) => ClientWidget(client: clients[index]),
      itemCount: clients.length,
    );
  }
}
