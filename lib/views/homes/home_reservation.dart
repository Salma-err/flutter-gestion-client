import 'package:flutter/material.dart';
import 'package:gestion_app/main.dart';
import 'package:gestion_app/views/CRUD_forms/my_search_delegate_reservations.dart';
import 'package:gestion_app/views/reservationWidgets/list_reservation_widget.dart';

class HomeReservation extends StatefulWidget {
  const HomeReservation({Key? key}) : super(key: key);

  @override
  State<HomeReservation> createState() => _HomeReservationState();
}

class _HomeReservationState extends State<HomeReservation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.white,
          titleSpacing: 0,
          title: Text(MyApp.titleReservation,
              style: const TextStyle(
                  letterSpacing: 2, wordSpacing: 1, fontSize: 20)),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                    context: context, delegate: MySearchDelegateReservations());
              },
              icon: const Icon(Icons.search),
            ),
          ]),
      body: ListReservationWidget(),
      /* floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),*/
    );
  }
}
