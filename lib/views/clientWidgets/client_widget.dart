import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gestion_app/models/client.dart';
import 'package:gestion_app/views/CRUD_forms/add_reservation.dart';
import 'package:gestion_app/views/CRUD_forms/edit_client.dart';
import 'package:gestion_app/controllers/clients_provider.dart';
import 'package:gestion_app/views/clientWidgets/details_client.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ClientWidget extends StatelessWidget {
  final client;
  ClientWidget({Key? key, required this.client}) : super(key: key);

  //sizes:
  Axis dirc = Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    final Client _client = client;

    var width = MediaQuery.of(context).size.width;
    if (width <= 500) {
      dirc = Axis.vertical;
    }

    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Slidable(
          child: buildClient(context, _client),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) => editClient(context, _client),
                label: 'Modifier',
                icon: Icons.edit,
                backgroundColor: Colors.lightGreen,
                foregroundColor: Colors.white,
              ),
              SlidableAction(
                onPressed: (_) => deleteClient(context, _client.id),
                label: 'Supprimer',
                icon: Icons.delete,
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
            ],
          ),
          endActionPane: ActionPane(motion: const ScrollMotion(), children: [
            SlidableAction(
              onPressed: (_) {
                Get.dialog(AddReservation(), arguments: client);
              },
              label: 'Réserver',
              icon: Icons.book_outlined,
              backgroundColor: Colors.amberAccent,
              foregroundColor: Colors.white,
            ),
          ]),
        ));
  }

  Widget buildClient(BuildContext context, Client _client) {
    return GestureDetector(
      onTap: () => showDialog(
          builder: (context) => DetailsClient(client: _client),
          context: context),
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
                //runSpacing: 10.w,
                spacing: 2.w,
                direction: dirc,
                children: [
                  Text(
                    '${_client.id}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 2,
                      color: Color.fromRGBO(220, 215, 176, 1),
                    ),
                  ),
                  Text(
                    '${_client.prenom} ${_client.nom}',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    _client.code,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 2,
                      color: Color.fromRGBO(224, 202, 60, 1),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  editClient(BuildContext context, Client _client) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => EditClient(client: _client)));
  }

  deleteClient(BuildContext context, int id) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Boite de confirmation"),
              content: const Text("Etes-vous sur d'effectuer la suppression? "),
              actions: [
                TextButton(
                  child: const Text("Oui"),
                  onPressed: () {
                    final provider =
                        Provider.of<ClientsProvider>(context, listen: false);
                    provider.removeClient(context, id);
                  },
                ),
                TextButton(
                  child: const Text("Non"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }
}
