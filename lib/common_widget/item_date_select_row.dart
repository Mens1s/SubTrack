import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Tarih formatlamak için
import '../common/color_extension.dart';

class ItemDateSelectRow extends StatelessWidget {
  final String title;
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;

  const ItemDateSelectRow({
    super.key,
    required this.title,
    required this.selectedDate,
    required this.onDateChanged,
  });

  void _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      onDateChanged(picked); // Seçilen tarihi gönderir.
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDatePicker(context),  // Tıklama ile tarih seçici açılır
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: TColor.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                DateFormat('yyyy-MM-dd').format(selectedDate), // Tarih formatı
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: TColor.gray30,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.calendar_today,
              color: TColor.gray30,
            ),
          ],
        ),
      ),
    );
  }
}
