import 'package:flutter/material.dart';
import 'package:gestion_app/pages/home_page.dart';
import 'package:gestion_app/provider/clients_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static String title = 'Gestion des clients';

  @override
  Widget build(BuildContext context) => MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: ClientsProvider()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: title,
            theme: ThemeData(
              primarySwatch: Colors.amber,
              primaryColor: const Color.fromRGBO(2, 69, 64, 1),
              scaffoldBackgroundColor: Colors.grey[100],
            ),
            home: HomePage(),
          ));
}
