import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trackizer/entities/Subscription.dart';
import 'package:trackizer/generated//l10n.dart';
import '../common/color_extension.dart';

class SubscriptionCell extends StatelessWidget {
  final Subscription sub;
  final VoidCallback onPressed;

  const SubscriptionCell(
      {super.key, required this.sub, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(color: TColor.border.withOpacity(0.15)),
            color: TColor.gray60.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16)),
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Image.asset(
              sub.logo,
              width: 45,
              height: 45,
            ),
            const Spacer(),
            Text(
              sub.name,
              style: TextStyle(
                color: TColor.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              "${S.of(context).currency}${sub.price}",
              style: TextStyle(
                color: TColor.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
