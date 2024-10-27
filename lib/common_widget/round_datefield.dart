import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Tarih formatlamak için

import '../common/color_extension.dart';

class RoundDateField extends StatefulWidget {
  final String title;
  final TextEditingController? controller;
  final TextAlign titleAlign;

  const RoundDateField({
    super.key,
    required this.title,
    this.controller,
    this.titleAlign = TextAlign.left,
  });

  @override
  _RoundDateFieldState createState() => _RoundDateFieldState();
}

class _RoundDateFieldState extends State<RoundDateField> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.controller?.text = DateFormat('yyyy-MM-dd').format(selectedDate!); // Tarih formatı
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                widget.title,
                textAlign: widget.titleAlign,
                style: TextStyle(color: TColor.gray40, fontSize: 13),
              ),
            ),

          ],
        ),
        Container(
          height: 48,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: TColor.gray60.withOpacity(0.1),
            border: Border.all(color: TColor.gray50),
            borderRadius: BorderRadius.circular(15),
          ),

          child: TextField(
            onTap: () {
              _selectDate(context);
            },
            controller: widget.controller,
            readOnly: true,
            decoration: const InputDecoration(
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
            ),
            style: TextStyle(color: TColor.gray40),
          ),
        ),
      ],
    );
  }
}
