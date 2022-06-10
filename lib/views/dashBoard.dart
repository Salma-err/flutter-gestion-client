import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DashBoard extends StatelessWidget {
  DashBoard({Key? key}) : super(key: key);
  double rad = 0;
  double widthService = 0;
  double fontSize = 0;
  double betweenHeight = 0;
  double bienvenue = 0;
  double choisir = 0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    print("width : $width");
    if (width <= 500) {
      rad = 18.w;
      widthService = 60.w;
      fontSize = 10.sp;
      betweenHeight = 3.h;
      bienvenue = 30.sp;
      choisir = 8.sp;
    } else {
      rad = 5.w;
      widthService = 20.w;
      fontSize = 4.sp;
      betweenHeight = 20.h;
      bienvenue = 15.sp;
      choisir = 4.sp;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
            width: 100.w,
            padding: EdgeInsets.fromLTRB(10.w, 9.w, 10.w, 3.w),
            child: Wrap(
              alignment: WrapAlignment.center,
              direction: Axis.horizontal,
              spacing: 4.w,
              runSpacing: betweenHeight,
              children: [
                SizedBox(
                  width: 100.w,
                  child: Column(children: [
                    Text(
                      'Soyez la bienvenue',
                      style: TextStyle(
                        fontFamily: 'Dancing',
                        fontSize: bienvenue,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor,
                      ),
                      textAlign: TextAlign.center,
                      textWidthBasis: TextWidthBasis.longestLine,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      'Choisissez le service dont vous avez besoin !',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w300,
                        fontSize: choisir,
                        color: Colors.grey[500],
                      ),
                      textAlign: TextAlign.center,
                      textWidthBasis: TextWidthBasis.longestLine,
                    ),
                  ]),
                ),
                serviceHotel(
                    context, 'Gestion des clients', 'client.png', '/client'),
                serviceHotel(
                    context, 'Gestion des chambres', 'chambre.png', '/chambre'),
                serviceHotel(context, 'Gestion des réservations', 'reserve.png',
                    '/reservation'),
              ],
            )),
      ),
    );
  }

  Widget serviceHotel(
      BuildContext context, String text, String pic, String route) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('pictures/$pic'),
          radius: rad,
        ),
        SizedBox(height: 1.h),
        SizedBox(
          width: widthService,
          child: ElevatedButton(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Monts',
                fontSize: fontSize,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
            ),
            onPressed: () => Navigator.pushNamed(context, route),
          ),
        ),
      ],
    );
  }
}


/*
return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
            width: 100.w,
            padding: EdgeInsets.fromLTRB(10.w, 5.h, 10.w, 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Soyez la bienvenue',
                  style: TextStyle(
                    fontFamily: 'Dancing',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Choisissez le service dont vous avez besoin !',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w300,
                    fontSize: 8.sp,
                    color: Colors.grey[500],
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                serviceHotel(
                    context, 'Gestion des clients', 'client.png', '/client'),
                SizedBox(
                  height: 5.h,
                ),
                serviceHotel(
                    context, 'Gestion des chambres', 'chambre.png', '/chambre'),
                SizedBox(
                  height: 5.h,
                ),
                serviceHotel(context, 'Gestion des réservations', 'reserve.png',
                    '/reservation'),
                SizedBox(
                  height: 5.h,
                ),
              ],
            )),
      ),
    );
    */