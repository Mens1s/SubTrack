import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trackizer/entities/Categories.dart';
import 'package:trackizer/generated//l10n.dart';
import '../common/color_extension.dart';

class BudgetsRow extends StatelessWidget {
  final Categories category;
  final VoidCallback onPressed;

  const BudgetsRow({super.key, required this.category, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    var proVal = (category.inUseBudget / category.budget);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(
                color: TColor.border.withOpacity(0.05),
              ),
              color: TColor.gray60.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16)),
          alignment: Alignment.center,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      category.icon,
                      width: 30,
                      height: 30,
                      color: TColor.gray40,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category.name,
                          style: TextStyle(
                            color: TColor.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${S.of(context).currency}${category.budget-category.inUseBudget} ${S.of(context).left_to_spent}",
                          style: TextStyle(
                            color: TColor.gray30,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${S.of(context).currency}${category.inUseBudget}",
                        style: TextStyle(
                          color: TColor.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "of ${S.of(context).currency}${category.budget}",
                        style: TextStyle(
                          color: TColor.gray30,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8,),
              LinearProgressIndicator(
                backgroundColor: TColor.gray60,
                valueColor: AlwaysStoppedAnimation( category.color),
                minHeight: 3,
                value: proVal,
              )
            ],
          ),
        ),
      ),
    );
  }
}
