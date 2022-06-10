import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gestion_app/views/CRUD_forms/edit_chambre.dart';
import 'package:gestion_app/models/chambre.dart';
import 'package:gestion_app/controllers/chambres_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ChambreWidget extends StatelessWidget {
  final chambre;
  ChambreWidget({Key? key, required this.chambre}) : super(key: key);

  //sizes
  double id = 0, num = 0;
  double spacing = 0;
  Axis dirc = Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    if (width <= 500) {
      id = 12.sp;
      num = 14.sp;
      spacing = 2.h;
      dirc = Axis.vertical;
    } else {
      id = 3.sp;
      num = 5.sp;
      spacing = 15.h;
    }

    final Chambre _chambre = chambre;
    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Slidable(
          child: buildChambre(context, _chambre),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) => showDialog(
                    builder: (context) => EditChambre(chambre: _chambre),
                    context: context),
                label: 'Mettre à jour',
                icon: Icons.edit,
                backgroundColor: Colors.lightGreen,
                foregroundColor: Colors.white,
              )
            ],
          ),
          endActionPane: ActionPane(motion: const ScrollMotion(), children: [
            SlidableAction(
              onPressed: (_) => deleteChambre(context, _chambre.id),
              label: 'Supprimer',
              icon: Icons.delete,
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),
          ]),
        ));
  }

  Widget buildChambre(BuildContext context, Chambre _chambre) {
    return Container(
      padding: const EdgeInsets.all(5),
      color: Colors.white,
      child: SizedBox(
        width: 100.w,
        child: Container(
          alignment: Alignment.center,
          child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: spacing,
              direction: dirc,
              children: [
                Text(
                  '${_chambre.id}',
                  style: TextStyle(
                    fontSize: id,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2,
                    color: const Color.fromRGBO(220, 215, 176, 1),
                  ),
                ),
                Text(
                  'Chambre numéro ${_chambre.numero}',
                  style: TextStyle(
                    fontSize: num,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  deleteChambre(BuildContext context, int id) async {
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
                        Provider.of<ChambresProvider>(context, listen: false);
                    provider.removeChambre(context, id);
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
