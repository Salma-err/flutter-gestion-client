import 'package:flutter/material.dart';
import 'package:gestion_app/views/CRUD_forms/search_list_chambre_widget.dart';
import 'package:gestion_app/models/chambre.dart';

class MySearchDelegateChambre extends SearchDelegate {
  List<Chambre> chambres = [];
  MySearchDelegateChambre({required this.chambres});

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
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) {
    List<Chambre> list = [];

    if (query.isNotEmpty) {
      list = Chambre.searchByNumero(chambres, int.parse(query));
      if (list.isNotEmpty) {
        return SearchListChambreWidget(chambres: list, query: int.parse(query));
      } else {
        return const Center(
          child: Text('Pas de résultat !'),
        );
      }
    } else {
      return const Center(
        child: Text(
          'Entrez un numéro !',
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) => Container();
}
