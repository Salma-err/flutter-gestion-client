import 'package:flutter/material.dart';

import '../../models/client.dart';

class DetailsClient extends StatelessWidget {
  final Client client;
  const DetailsClient({Key? key, required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${client.nom} ${client.prenom}',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              letterSpacing: 3,
              wordSpacing: 4,
              color: Color.fromRGBO(224, 202, 60, 1),
              //fontStyle: FontStyle.italic,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            height: 0.5,
            color: const Color.fromRGBO(220, 215, 176, 1),
          ),
          edit('Client_id :', client.id.toString()),
          const SizedBox(height: 16),
          edit('Client_code :', client.code),
          const SizedBox(height: 16),
          edit('Client_tel :', client.tel),
          const SizedBox(height: 16),
          edit('Client_mail :', client.mail),
          const SizedBox(height: 16),
          client.verified
              ? edit('Status:', 'actif')
              : edit('Status:', 'inactif'),
        ],
      ),
    );
  }

  edit(String label, String value) {
    return Wrap(
      runSpacing: 10,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            letterSpacing: 2,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            letterSpacing: 1,
            color: Color.fromRGBO(2, 69, 64, 1),
          ),
        )
      ],
    );
  }
}
