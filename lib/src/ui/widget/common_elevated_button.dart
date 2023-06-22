
import 'package:flutter/material.dart';

import '../util/app_colors.dart';

class CommonElevatedButton extends StatelessWidget {
  const CommonElevatedButton({
    super.key,
    required this.title,
    required this.onTap,
  });
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
          ),
          onPressed: onTap,
          child: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: Colors.white),
          )),
    );
  }
}
