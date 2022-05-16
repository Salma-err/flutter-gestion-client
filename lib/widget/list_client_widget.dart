import 'package:flutter/material.dart';
import 'package:gestion_app/model/client.dart';
import 'package:gestion_app/widget/client_widget.dart';

class ListClientWidget extends StatelessWidget {
  const ListClientWidget({Key? key, required this.clients}) : super(key: key);
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
