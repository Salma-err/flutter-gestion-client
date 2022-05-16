// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gestion_app/model/client.dart';
import 'package:gestion_app/provider/clients_provider.dart';
import 'package:gestion_app/widget/client_widget.dart';
import 'package:provider/provider.dart';

class SearchListClientWidget extends StatefulWidget {
  List<Client> clients;
  String query = '';
  SearchListClientWidget({Key? key, required this.clients, required this.query})
      : super(key: key);

  @override
  State<SearchListClientWidget> createState() => _SearchListClientWidgetState();
}

class _SearchListClientWidgetState extends State<SearchListClientWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = Provider.of<ClientsProvider>(context, listen: false);
    setState(() {
      provider.getClients(context);
    });
    widget.clients = provider.clientList;
    widget.clients = Client.searchByName(widget.clients, widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20.0),
      physics: const ScrollPhysics(),
      separatorBuilder: (context, index) => Container(height: 8.0),
      itemBuilder: (context, index) =>
          ClientWidget(client: widget.clients[index]),
      itemCount: widget.clients.length,
    );
  }
}
