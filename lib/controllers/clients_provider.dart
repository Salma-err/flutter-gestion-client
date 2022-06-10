import 'package:flutter/material.dart';
import 'package:gestion_app/models/api/clients_services.dart';
import 'package:gestion_app/models/client.dart';
import 'package:gestion_app/utils.dart';

class ClientsProvider extends ChangeNotifier {
  List<Client> clientList = [];
  ClientServices service = ClientServices();

  getClients(context) async {
    clientList = await service.getClientsData();
    notifyListeners();
  }

  set clients(List<Client> clients) {
    clientList = clients;
    notifyListeners();
  }

  void addClient(BuildContext context, Client client) async {
    if (await service.addClient(client)) {
      Navigator.of(context).pop();
      notifyListeners();
      return Utils.showSnackBar(
          context, 'Magnifique! Le nouveau client est bien ajouté.');
    } else {
      Navigator.of(context).pop();
      return Utils.showExceptionSnackBar(context,
          "Ooops! Une erreur est survenu lors du traitement de requete. Essayez de s'assurer des valeurs saisies.");
    }
  }

  void editClient(BuildContext context, Client client) async {
    if (await service.editClient(client)) {
      Navigator.of(context).pop();
      notifyListeners();
      return Utils.showSnackBar(
          context, 'Très Bien! le client est bien mis à jour.');
    } else {
      Navigator.of(context).pop();
      return Utils.showExceptionSnackBar(context,
          "Ooops! Une erreur est survenu lors du traitement de requete. Essayez de s'assurer des valeurs saisies.");
    }
  }

  void removeClient(BuildContext context, int id) async {
    if (await service.deleteClient(id)) {
      Navigator.of(context).pop();
      notifyListeners();
      return Utils.showSnackBar(context, 'Super! le client est bien supprimé.');
    } else {
      Navigator.of(context).pop();
      return Utils.showExceptionSnackBar(context,
          "Ooops! Une erreur est survenu lors du traitement de requet.!");
    }
  }
}
