import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class RoundTextField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextAlign titleAlign;
  final bool obscureText;

  const RoundTextField(
      {super.key,
      required this.title,
      this.controller,
      this.keyboardType,
      this.titleAlign = TextAlign.left,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                textAlign: titleAlign,
                style: TextStyle(color: TColor.gray50, fontSize: 12),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          height: 48,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: TColor.gray60.withOpacity(0.05),
            border: Border.all(color: TColor.gray70),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16)),
            style: TextStyle(
              color: TColor.gray40,
            ),
            keyboardType: keyboardType,
            obscureText: obscureText,
          ),
        )
      ],
    );
  }
}
