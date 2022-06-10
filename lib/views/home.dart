import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  //sizes:
  double radius = 0;
  double decouv = 0;
  double hotel = 0;
  double bienvenue = 0;
  double button = 0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    print("width : $width");
    if (width <= 500) {
      radius = 50.h;
      decouv = 14.sp;
      hotel = 52.sp;
      bienvenue = 12.sp;
      button = 12.sp;
    } else {
      radius = 45.h;
      decouv = 5.sp;
      hotel = 20.sp;
      bienvenue = 4.sp;
      button = 5.sp;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: 100.w,
          padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 4.h),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              'Découvrez',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: decouv,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 3.h,
            ),
            Text(
              'votre hotel',
              style: TextStyle(
                fontFamily: 'Great',
                fontSize: hotel,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              'Service à la haute, Client satisfait',
              style: TextStyle(
                fontFamily: 'Dancing',
                fontSize: bienvenue,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 3.h,
            ),
            Image(
              image: const AssetImage('pictures/hotel.png'),
              width: radius,
              height: radius,
            ),
            SizedBox(
              height: 2.h,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                    shadowColor: Colors.grey[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    )),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/dash');
                },
                child: Text(
                  'Commencer',
                  style: TextStyle(
                    fontFamily: 'Monts',
                    fontSize: button,
                  ),
                )),
          ]),
        ),
      ),
    );
  }
}
