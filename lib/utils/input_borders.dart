import 'package:flutter/material.dart';
import '../main.dart';

InputDecoration myAppInputDecoration = InputDecoration(
  labelText: "Clinic/Organization",
  contentPadding: const EdgeInsets.all(20),
  enabledBorder: enableInputBorder,
  border: enableInputBorder,
);

InputBorder enableInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15),
  borderSide: BorderSide(
    style: BorderStyle.solid,
    color: appColors.shadowColor,
  ),
);
