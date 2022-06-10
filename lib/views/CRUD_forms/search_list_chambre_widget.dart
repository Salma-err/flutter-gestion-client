import 'package:flutter/material.dart';
import 'package:gestion_app/models/chambre.dart';
import 'package:gestion_app/controllers/chambres_provider.dart';
import 'package:gestion_app/views/chambreWidgets/chambre_wiget.dart';
import 'package:provider/provider.dart';

class SearchListChambreWidget extends StatefulWidget {
  List<Chambre> chambres;
  int query;
  SearchListChambreWidget(
      {Key? key, required this.chambres, required this.query})
      : super(key: key);

  @override
  State<SearchListChambreWidget> createState() =>
      _SearchListChambreWidgetState();
}

class _SearchListChambreWidgetState extends State<SearchListChambreWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = Provider.of<ChambresProvider>(context, listen: false);
    setState(() {
      provider.getChambres(context);
    });
    widget.chambres = provider.chambreList;
    widget.chambres = Chambre.searchByNumero(widget.chambres, widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20.0),
      physics: const ScrollPhysics(),
      separatorBuilder: (context, index) => Container(height: 8.0),
      itemBuilder: (context, index) =>
          ChambreWidget(chambre: widget.chambres[index]),
      itemCount: widget.chambres.length,
    );
  }
}
