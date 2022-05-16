import 'package:flutter/material.dart';
import 'package:gestion_app/api/clients_services.dart';
import 'package:gestion_app/model/client.dart';

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

  void addClient(Client client) async {
    await service.addClient(client);
    notifyListeners();
  }

  void editClient(Client client) async {
    await service.editClient(client);
    notifyListeners();
  }

  void removeClient(int id) async {
    await service.deleteClient(id);
    notifyListeners();
  }
}
