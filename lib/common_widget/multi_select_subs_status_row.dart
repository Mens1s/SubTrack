import 'package:flutter/material.dart';
import 'package:trackizer/Enum/SubscriptionType.dart';
import 'package:trackizer/entities/Categories.dart';
import '../common/color_extension.dart';

class MultiSelectSubsStatusRow extends StatelessWidget {
  final String title;
  final List<SubscriptionStatus> options = [SubscriptionStatus.onetime,SubscriptionStatus.daily, SubscriptionStatus.weekly, SubscriptionStatus.monthly, SubscriptionStatus.canceled];
  final SubscriptionStatus selectedValue;
  final Function(SubscriptionStatus) onValueChanged;

  MultiSelectSubsStatusRow({
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
              return RadioListTile<SubscriptionStatus>(
                title: Text(option.name),
                value: option,
                groupValue: selectedValue,
                onChanged: (value) {
                  onValueChanged(value!); // Seçim yapıldığında yeni değeri gönderir
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
            child: const Text("İptal"),
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
                selectedValue.name,
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
