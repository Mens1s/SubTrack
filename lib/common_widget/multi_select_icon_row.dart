import 'package:flutter/material.dart';
import 'package:trackizer/generated//l10n.dart';
import '../common/color_extension.dart';

class MultiSelectIconRow extends StatelessWidget {
  final String title;
  final List<String> options = ['home', 'security', 'auto_&_transport', 'Trash', 'budgets'];
  final String selectedValue;
  final Function(String) onValueChanged;

  MultiSelectIconRow({
    super.key,
    required this.title,
    required this.selectedValue,
    required this.onValueChanged,
  });

  void _showSelectPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: options.map((option) {
              return RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: selectedValue,
                onChanged: (value) {
                  onValueChanged("assets/img/${value!}.png"); // Seçim yapıldığında yeni değeri gönderir
                  Navigator.pop(context); // Popup'ı kapatır
                },
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Popup'ı kapatır.
            },
            child: Text(S.of(context).cancel),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showSelectPopup(context), // Tıklama ile popup açılır
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
            Expanded(
              child: Text(
                selectedValue,
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
              Icons.arrow_drop_down,
              color: TColor.gray30,
            ),
          ],
        ),
      ),
    );
  }
}
