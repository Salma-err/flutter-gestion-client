import 'package:flutter/material.dart';
import 'package:gestion_app/views/CRUD_forms/add_chambre.dart';
import 'package:gestion_app/views/CRUD_forms/my_search_delegate_chambres.dart';
import 'package:gestion_app/main.dart';
import 'package:gestion_app/models/chambre.dart';
import 'package:gestion_app/controllers/chambres_provider.dart';
import 'package:gestion_app/views/chambreWidgets/list_chambre_widget.dart';
import 'package:provider/provider.dart';

class HomeChambre extends StatefulWidget {
  const HomeChambre({Key? key}) : super(key: key);

  @override
  State<HomeChambre> createState() => _HomeChambreState();
}

class _HomeChambreState extends State<HomeChambre> {
  late List<Chambre> chambres;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ChambresProvider>(context, listen: false);
    provider.getChambres(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = Provider.of<ChambresProvider>(context, listen: false);
    setState(() {
      provider.getChambres(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChambresProvider>(context);
    chambres = provider.chambreList;

    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text(MyApp.titleChambre,
              style: const TextStyle(
                  letterSpacing: 2, wordSpacing: 1, fontSize: 20)),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: MySearchDelegateChambre(chambres: chambres));
              },
              icon: const Icon(Icons.search),
            ),
          ]),
      body: ListChambreWidget(chambres: chambres),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
            builder: (context) => const AddChambre(), context: context),
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
    );
  }
}
