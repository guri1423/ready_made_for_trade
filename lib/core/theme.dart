


import 'package:flutter/material.dart';
import 'package:ready_made_4_trade/core/colors.dart';

class CustomThemes{



  static ThemeData getTheme(){



    return ThemeData(
        primaryColor:const Color.fromRGBO(39, 69, 89, 1),
        primarySwatch: Colors.blueGrey,
        textTheme: const TextTheme(



          titleLarge: TextStyle(
              color: CustomColors.white, fontWeight: FontWeight.bold, fontSize: 20,
              fontFamily: "Dongle Regular",
          ),

          titleMedium: TextStyle(
              color: CustomColors.white, fontWeight: FontWeight.bold, fontSize: 18,fontFamily: "Dongle Regular"
          ),

          titleSmall: TextStyle(
              color: CustomColors.white, fontWeight: FontWeight.bold, fontSize: 12,fontFamily: "Dongle Regular"
          ),









        )
    );
  }

}