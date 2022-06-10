import 'package:flutter/material.dart';
import 'package:gestion_app/views/dashBoard.dart';
import 'package:gestion_app/views/home.dart';
import 'package:gestion_app/views/homes/home_chambre.dart';
import 'package:gestion_app/views/homes/home_client.dart';
import 'package:gestion_app/views/homes/home_reservation.dart';
import 'package:gestion_app/controllers/chambres_provider.dart';
import 'package:gestion_app/controllers/clients_provider.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static String titleClient = 'Gestion des clients';
  static String titleChambre = 'Gestion des chambres';
  static String titleReservation = 'Gestion des réservations';

  @override
  Widget build(BuildContext context) => MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: ClientsProvider()),
            ChangeNotifierProvider.value(value: ChambresProvider()),
            // ChangeNotifierProvider.value(value: ClientsProvider()),
          ],
          child: Sizer(
            builder: (BuildContext context, Orientation orientation,
                DeviceType deviceType) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.amber,
                  primaryColor: const Color.fromRGBO(2, 69, 64, 1),
                  scaffoldBackgroundColor: Colors.grey[100],
                ),
                home: Home(),
                routes: {
                  '/home': (context) => Home(),
                  '/dash': (context) => DashBoard(),
                  '/client': (context) => const HomeClient(),
                  '/chambre': (context) => const HomeChambre(),
                  '/reservation': (context) => const HomeReservation(),
                },
              );
            },
          ));
}
