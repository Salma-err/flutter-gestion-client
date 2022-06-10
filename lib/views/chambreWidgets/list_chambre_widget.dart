import 'package:flutter/material.dart';
import 'package:gestion_app/models/chambre.dart';
import 'package:gestion_app/views/chambreWidgets/chambre_wiget.dart';

class ListChambreWidget extends StatelessWidget {
  final List<Chambre> chambres;
  const ListChambreWidget({Key? key, required this.chambres}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20.0),
      physics: const ScrollPhysics(),
      separatorBuilder: (context, index) => Container(height: 8.0),
      itemBuilder: (context, index) => ChambreWidget(chambre: chambres[index]),
      itemCount: chambres.length,
    );
  }
}
