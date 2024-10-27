import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trackizer/entities/Subscription.dart';
import 'package:trackizer/generated//l10n.dart';
import '../common/color_extension.dart';

class SubscriptionHomeRow extends StatelessWidget {
  final Subscription sub;
  final VoidCallback onPressed;

  const SubscriptionHomeRow(
      {super.key, required this.sub, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onPressed,
        child: Container(
          height: 64,
          padding: const EdgeInsets.all(10),

          decoration: BoxDecoration(
              border: Border.all(color: TColor.border.withOpacity(0.15)),

              borderRadius: BorderRadius.circular(16)),
          alignment: Alignment.center,
          child: Row(
            children: [

              Image.asset(
                sub.logo,
                width: 40,
                height: 40,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  sub.name,
                  style: TextStyle(
                    color: TColor.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "${S.of(context).currency}${sub.price}",
                style: TextStyle(
                  color: TColor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
