import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class ItemRow extends StatelessWidget {
  final String title;
  final String value;
  final Function(String) onValueChanged;

  const ItemRow({
    super.key,
    required this.title,
    required this.value,
    required this.onValueChanged,
  });

  void _showEditPopup(BuildContext context) {
    TextEditingController controller = TextEditingController(text: value);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit $title"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            labelText: "Enter new value",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Popup'ı kapatır.
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              onValueChanged(controller.text); // Yeni değeri gönderir.
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showEditPopup(context),  // Tıklama ile popup açılır
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
                value,
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
              Icons.edit,
              color: TColor.gray30,
            ),
          ],
        ),
      ),
    );
  }
}