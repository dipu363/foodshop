import 'package:flutter/material.dart';

import '../util/app_colors.dart';

class CommonEditTextField extends StatelessWidget {
  const CommonEditTextField({
    super.key,
    required this.controller,
    required this.validator,
    required this.hintext,
  });

  final TextEditingController controller;
  final Function(String?) validator;
  final String? hintext;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) => validator(value),
      decoration: InputDecoration(
          hintText: hintext,
          contentPadding:
               const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          border: const  OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 2)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 2))),
    );
  }
}
