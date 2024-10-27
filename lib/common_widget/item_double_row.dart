import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class ItemDoubleRow extends StatelessWidget {
  final String title;
  final double value; // Double değer
  final Function(double) onValueChanged; // Değiştirme fonksiyonu

  const ItemDoubleRow({
    super.key,
    required this.title,
    required this.value,
    required this.onValueChanged,
  });

  void _showEditPopup(BuildContext context) {
    TextEditingController controller = TextEditingController(text: value.toString()); // Double'ı string'e çevir

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("$title"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number, // Sayı girişi için
          decoration: InputDecoration(
            labelText: "S.of(context).enter_new_value",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Popup'ı kapatır.
            },
            child: Text("S.of(context).cancel"),
          ),
          TextButton(
            onPressed: () {
              double? newValue = double.tryParse(controller.text); // Girilen değeri double'a çevir
              if (newValue != null) {
                onValueChanged(newValue); // Yeni değeri gönderir
              }
              Navigator.pop(context);
            },
            child: Text("S.of(context).save"),
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
                value.toString(), // Double'ı string olarak göster
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
