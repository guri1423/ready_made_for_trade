import 'package:flutter/material.dart';
Widget textList(){
  return ListView.builder(
      itemCount: 5,
      itemBuilder: (context,index){
        return Text('Lorem ipsum dolor sit amet, consectur',
            style: TextStyle(
            color: Colors.grey[700],
            fontSize: 15),
        );
      }
  );
}