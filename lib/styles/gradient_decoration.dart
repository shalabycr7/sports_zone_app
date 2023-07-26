import 'package:flutter/material.dart';

BoxDecoration blueGradient = const BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(255, 120, 30, 255),
      Color.fromARGB(255, 175, 84, 255)
    ],
  ),
);
