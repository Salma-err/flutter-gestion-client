import 'package:flutter/material.dart';
import 'package:gestion_app/model/client.dart';
import 'package:gestion_app/widget/search_list_client_widget.dart';

class MySearchDelegate extends SearchDelegate {
  List<Client> clients = [];
  MySearchDelegate({required this.clients});

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  List<Widget>? buildActions(BuildContext context) => [
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

  @override
  Widget buildResults(BuildContext context) {
    List<Client> list = [];

    if (query.isNotEmpty) {
      list = Client.searchByName(clients, query);
      if (list.isNotEmpty) {
        return SearchListClientWidget(clients: list, query: query);
      } else {
        return const Center(
          child: Text('Pas de résultat !'),
        );
      }
    } else {
      return const Center(
        child: Text('Entrez un nom ou un prénom '),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) => Container();
}
