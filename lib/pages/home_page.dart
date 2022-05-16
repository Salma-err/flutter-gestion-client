import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gestion_app/main.dart';
import 'package:gestion_app/model/client.dart';
import 'package:gestion_app/pages/add_client.dart';
import 'package:gestion_app/provider/clients_provider.dart';
import 'package:gestion_app/widget/list_client_widget.dart';
import 'package:gestion_app/widget/my_search_delegate.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Client> activeClients;
  late List<Client> inactiveClients;
  late List<Client> clients;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ClientsProvider>(context, listen: false);
    provider.getClients(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = Provider.of<ClientsProvider>(context, listen: false);
    setState(() {
      provider.getClients(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ClientsProvider>(context);
    activeClients = Client.getActiveClients(provider.clientList);
    inactiveClients = Client.getInactiveClients(provider.clientList);
    clients = provider.clientList;

    final tabs = [
      ListClientWidget(clients: activeClients),
      ListClientWidget(clients: inactiveClients),
    ];
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text(MyApp.title,
              style: const TextStyle(
                  letterSpacing: 3, wordSpacing: 2, fontSize: 25)),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: MySearchDelegate(clients: clients));
              },
              icon: const Icon(Icons.search),
              //iconSize: 35,
            ),
          ]),
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(220, 215, 176, 1),
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Color.fromRGBO(2, 69, 64, 1),
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
              label: 'Actif', icon: FaIcon(FontAwesomeIcons.toggleOn)),
          BottomNavigationBarItem(
              label: 'Inactif', icon: FaIcon(FontAwesomeIcons.toggleOff)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const AddClient())),
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        //mini: true,
      ),
    );
  }
}
