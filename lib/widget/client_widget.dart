import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gestion_app/pages/edit_client.dart';
import 'package:gestion_app/provider/clients_provider.dart';
import 'package:gestion_app/utils.dart';
import 'package:gestion_app/widget/details_client.dart';
import 'package:provider/provider.dart';

import '../model/client.dart';

class ClientWidget extends StatelessWidget {
  final client;
  const ClientWidget({Key? key, required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Client _client = client;
    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Slidable(
          child: buildClient(context, _client),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) => editClient(context, _client),
                label: 'Edit',
                icon: Icons.edit,
                backgroundColor: Colors.lightGreen,
                foregroundColor: Colors.white,
              )
            ],
          ),
          endActionPane: ActionPane(motion: const ScrollMotion(), children: [
            SlidableAction(
              onPressed: (_) => deleteClient(context, _client.id),
              label: 'delete',
              icon: Icons.delete,
              backgroundColor: Colors.redAccent,
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
          width: double.infinity,
          child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              runSpacing: 10,
              direction: Axis.horizontal,
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
    );
  }

  editClient(BuildContext context, Client _client) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => EditClient(client: _client)));
  }

  deleteClient(BuildContext context, int id) async {
    final provider = Provider.of<ClientsProvider>(context, listen: false);
    provider.removeClient(id);
    Utils.showSnackBar(context, 'Excellent, Suppression bien effectuée !');
  }
}
