import 'package:flutter/material.dart';
import 'package:gestion_app/model/client.dart';
import 'package:gestion_app/provider/clients_provider.dart';
import 'package:provider/provider.dart';

class EditClient extends StatefulWidget {
  final Client client;
  const EditClient({Key? key, required this.client}) : super(key: key);

  @override
  State<EditClient> createState() => _EditClientState();
}

class _EditClientState extends State<EditClient> {
  final _formKey = GlobalKey<FormState>();
  final _controllerNom = TextEditingController();
  final _controllerPrenom = TextEditingController();
  final _controllerCode = TextEditingController();
  final _controllerTel = TextEditingController();
  final _controllerMail = TextEditingController();
  //variable
  bool isChecked = false;
  int id = 0;

  @override
  void initState() {
    _controllerNom.text = widget.client.nom;
    _controllerPrenom.text = widget.client.prenom;
    _controllerCode.text = widget.client.code;
    _controllerTel.text = widget.client.tel;
    _controllerMail.text = widget.client.mail;
    isChecked = widget.client.verified;
    id = widget.client.id;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editer un Client'),
        backgroundColor: Theme.of(context).primaryColor,
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
                    controller: _controllerPrenom,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Prenom',
                    ),
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
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => editClient(),
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

  editClient() {
    final isValid = _formKey.currentState?.validate();
    final provider = Provider.of<ClientsProvider>(context, listen: false);
    if (!isValid!) {
      return;
    } else {
      Client cl = Client(
          id: id,
          nom: _controllerNom.text,
          prenom: _controllerPrenom.text,
          code: _controllerCode.text,
          tel: _controllerTel.text,
          mail: _controllerMail.text,
          verified: isChecked);

      provider.editClient(cl);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Très Bien, le client est bien mis à jour !'),
        duration: Duration(seconds: 2),
      ));
      Navigator.of(context).pop();
    }
  }
}
