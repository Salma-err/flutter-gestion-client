import 'package:flutter/material.dart';
import 'package:gestion_app/models/api/chambres_services.dart';
import 'package:gestion_app/models/chambre.dart';
import 'package:gestion_app/utils.dart';

class ChambresProvider extends ChangeNotifier {
  List<Chambre> chambreList = [];
  ChambreServices service = ChambreServices();

  getChambres(context) async {
    chambreList = await service.getChambresData();
    notifyListeners();
  }

  set chambres(List<Chambre> chambres) {
    chambreList = chambres;
    notifyListeners();
  }

  addChambre(context, Chambre chambre) async {
    if (await service.addChambre(chambre)) {
      Navigator.of(context).pop();
      notifyListeners();
      return Utils.showSnackBar(
          context, 'Magnifique! la nouvelle chambre est bien ajoutée.');
    } else {
      Navigator.of(context).pop();
      return Utils.showExceptionSnackBar(context,
          "Ooops! Une erreur est survenu lors du traitement de requete. Essayez de s'assurer des valeurs saisies.");
    }
  }

  void editChambre(context, Chambre chambre) async {
    if (await service.editChambre(chambre)) {
      Navigator.of(context).pop();
      notifyListeners();
      return Utils.showSnackBar(
          context, 'Très bien! la chambre est bien mise à jour.');
    } else {
      Navigator.of(context).pop();
      return Utils.showExceptionSnackBar(context,
          "Ooops! Une erreur est survenu lors du traitement de requete. Essayez de s'assurer des valeurs saisies.");
    }
  }

  void removeChambre(context, int id) async {
    if (await service.deleteChambre(id)) {
      Navigator.of(context).pop();
      notifyListeners();
      return Utils.showSnackBar(
          context, 'Excellent! la chambre est bien supprimée.');
    } else {
      Navigator.of(context).pop();
      return Utils.showExceptionSnackBar(context,
          "Ooops! Une erreur est survenu lors du traitement de requete.");
    }
  }
}
