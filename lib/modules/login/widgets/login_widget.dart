

import 'package:flutter/material.dart';

Widget shortButton(context, String title ){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      height: 50,
      width: 70,
      child: Container(
        decoration:  BoxDecoration(
          color: Color(0xFF13212C),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: Text(title,
          style: const TextStyle(
              fontSize: 20,
              fontFamily:'Dongle',
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),),),
      ),
    ),
  );
}


Widget longButton(context, String title, Color colour ){
  return Container(
    decoration:  BoxDecoration(
      color: colour,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Center(child: Text(title,
      style: const TextStyle(
          fontSize: 30,
          fontFamily:'Dongle',
          color: Colors.white,
          fontWeight: FontWeight.bold
      ),),),
  );
}




Widget customisedButton(context, String title, Color colour,String image ){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: SizedBox(
      height: 40,
      child: Container(
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Aligns the children to the start (left corner)
          children: [
            Padding(
              padding: const EdgeInsets.all(6),
              child: Image.asset(image),
            ),
          // Adds some spacing between the image and text
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Dongle Regular',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),

  );
}