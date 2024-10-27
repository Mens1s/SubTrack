import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart'; // Renk seçici için
import 'package:trackizer/generated//l10n.dart';
import '../common/color_extension.dart';

class ItemColorRow extends StatelessWidget {
  final String title;
  final Color value; // Color değeri
  final Function(Color) onValueChanged; // Değiştirme fonksiyonu

  const ItemColorRow({
    super.key,
    required this.title,
    required this.value,
    required this.onValueChanged,
  });

  void _showEditPopup(BuildContext context) {
    // Renk seçimi için başlangıç rengi
    Color selectedColor = value;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Renk seçici widget'ı
              BlockPicker(
                pickerColor: selectedColor,
                onColorChanged: (color) {
                  selectedColor = color; // Seçilen rengi güncelle
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Popup'ı kapatır.
            },
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () {
              onValueChanged(selectedColor); // Yeni rengi gönderir
              Navigator.pop(context);
            },
            child: Text(S.of(context).save),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showEditPopup(context), // Tıklama ile popup açılır
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
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: value, // Mevcut rengi göster
                child: Text(
                  S.of(context).selected_color, // Renk ismini veya gösterimi buraya ekleyebilirsiniz
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: TColor.gray30,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
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
