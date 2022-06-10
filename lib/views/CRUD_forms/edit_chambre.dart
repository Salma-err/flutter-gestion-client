import 'package:flutter/material.dart';
import 'package:gestion_app/models/chambre.dart';
import 'package:gestion_app/controllers/chambres_provider.dart';
import 'package:gestion_app/utils.dart';
import 'package:provider/provider.dart';

class EditChambre extends StatefulWidget {
  final Chambre chambre;
  const EditChambre({Key? key, required this.chambre}) : super(key: key);

  @override
  State<EditChambre> createState() => _EditChambreState();
}

class _EditChambreState extends State<EditChambre> {
  final _formKey = GlobalKey<FormState>();
  final _controllerNumero = TextEditingController();
  //variable
  int id = 0;

  @override
  void initState() {
    _controllerNumero.text = widget.chambre.numero.toString();
    id = widget.chambre.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Container(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Modifier la chambre :',
                  style: TextStyle(
                    fontSize: 17,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextFormField(
                    controller: _controllerNumero,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Numero',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Le champs Numéro est obligatoire';
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(height: 42),
                SizedBox(
                  width: 250,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () => editChambre(context),
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

  editChambre(BuildContext context) {
    final isValid = _formKey.currentState?.validate();
    final provider = Provider.of<ChambresProvider>(context, listen: false);
    if (!isValid!) {
      return;
    } else {
      Chambre ch = Chambre(id: id, numero: int.parse(_controllerNumero.text));
      provider.editChambre(context, ch);
    }
  }
}
