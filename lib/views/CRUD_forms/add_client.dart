import 'package:flutter/material.dart';
import 'package:gestion_app/models/client.dart';
import 'package:gestion_app/controllers/clients_provider.dart';
import 'package:provider/provider.dart';

class AddClient extends StatefulWidget {
  const AddClient({Key? key}) : super(key: key);

  @override
  State<AddClient> createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  final _formKey = GlobalKey<FormState>();
  final _controllerNom = TextEditingController();
  final _controllerPrenom = TextEditingController();
  final _controllerCode = TextEditingController();
  final _controllerTel = TextEditingController();
  final _controllerMail = TextEditingController();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un Client'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                    controller: _controllerNom,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Nom',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Le champs Nom est obligatoire';
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(height: 8),
                TextFormField(
                    style: const TextStyle(
                      color: Color.fromRGBO(2, 69, 64, 1),
                    ),
                    decoration: const InputDecoration(
                      focusColor: Color.fromRGBO(2, 69, 64, 1),
                      border: UnderlineInputBorder(),
                      labelText: 'Prenom',
                    ),
                    controller: _controllerPrenom,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Le champs Prénom est obligatoire';
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(height: 8),
                TextFormField(
                    controller: _controllerCode,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Code',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Le champs Code est obligatoire';
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(height: 8),
                TextFormField(
                    controller: _controllerTel,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Téléphone',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Le champs Téléphone est obligatoire';
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(height: 8),
                TextFormField(
                    controller: _controllerMail,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Mail',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Le champs Mail est obligatoire';
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      'Vérifié :',
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Checkbox(
                      activeColor: Theme.of(context).primaryColor,
                      checkColor: Colors.white,
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => createNewClient(),
                    child: const Text(
                      'Enregistrer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  createNewClient() async {
    final isValid = _formKey.currentState?.validate();
    final provider = Provider.of<ClientsProvider>(context, listen: false);

    if (!isValid!) {
      return;
    } else {
      Client client = Client(
          id: 1,
          nom: _controllerNom.text,
          prenom: _controllerPrenom.text,
          code: _controllerCode.text,
          tel: _controllerTel.text,
          mail: _controllerMail.text,
          verified: isChecked);
      provider.addClient(context, client);
    }
  }
}
