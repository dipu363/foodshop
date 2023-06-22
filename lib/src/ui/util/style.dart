import 'package:flutter/material.dart';

import 'dart:ui';

import 'app_colors.dart';

TextStyle titleTextStyle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: blackColor,
    letterSpacing: 0.5);
TextStyle subtitleTextStyle =
    const TextStyle(color: Colors.grey, letterSpacing: 0.5);

TextFormField editTextfield = TextFormField(
  decoration: const InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 2)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 2))),
);
