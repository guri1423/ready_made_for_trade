

import 'package:flutter/material.dart';

import '../../../core/colors.dart';

Widget customContainerSettings( context) {
  ThemeData theme = Theme.of(context);
  TextStyle style = const TextStyle(
      fontSize: 10,
      fontFamily: 'Dongle',
      color: Colors.white,
      fontWeight: FontWeight.w600);
  return Padding(
    padding: const EdgeInsets.only(bottom: 25),
    child: Container(
      decoration: BoxDecoration(
          color: CustomColors.white,
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in'),
      ),
    ),
  );
}