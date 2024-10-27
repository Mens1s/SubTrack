import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trackizer/common/color_extension.dart';
import 'package:trackizer/common_widget/item_color_row.dart';
import 'package:trackizer/common_widget/item_double_row.dart';
import 'package:trackizer/common_widget/item_row.dart';
import 'package:trackizer/common_widget/multi_select_icon_row.dart';
import 'package:trackizer/common_widget/secondary_button.dart';
import 'package:trackizer/entities/Categories.dart';
import 'package:trackizer/generated//l10n.dart';
import 'package:trackizer/services/CategoriesService.dart';

class CategoryAddView extends StatefulWidget {
  const CategoryAddView({super.key});

  @override
  State<CategoryAddView> createState() => _CategoryAddViewState();
}

class _CategoryAddViewState extends State<CategoryAddView> {
  String nameValue = "";
  String iconValue = "";
  String iconVisibleValue = "";
  double budgetValue = 0;
  Color colorValue = Colors.white;

  List<Categories> categoryList = [];

  Future<void> _getInitialValues() async {
    setState(() {
      nameValue = "New Category";
      iconValue = "assets/img/auto_&_transport.png";
      iconVisibleValue = 'auto_&_transport';
      budgetValue = 10;
      colorValue = Colors.red;
    });
  }

  void updateColorValue(Color newValue) {
    setState(() {
      colorValue = newValue; // Seçimi güncelle
    });
  }

  void updateBudgetValue(double newValue) {
    setState(() {
      budgetValue = newValue; // Seçimi güncelle
    });
  }

  void updateIconValue(String newValue) {
    setState(() {
      iconValue = newValue; // Seçimi güncelle
      iconVisibleValue = iconValue.split('/')[2].split('.')[0];
    });
  }

  void updateNameValue(String newValue) {
    setState(() {
      nameValue = newValue; // Seçimi güncelle
    });
  }

  @override
  void initState() {
    super.initState(); // Call the initialization method
    _getInitialValues();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xff282833).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Container(
                      height: media.width * 0.9,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: TColor.gray70,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Image.asset("assets/img/dorp_down.png",
                                    width: 20,
                                    height: 20,
                                    color: TColor.gray30),
                              ),
                              Text(
                                S.of(context).add_new_category,
                                style: TextStyle(
                                    color: TColor.gray30, fontSize: 16),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Image.asset("assets/img/Trash.png",
                                    width: 25,
                                    height: 25,
                                    color: TColor.gray30),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Image.asset(
                            iconValue,
                            width: media.width * 0.25,
                            height: media.width * 0.25,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            nameValue,
                            style: TextStyle(
                              color: TColor.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "${S.of(context).currency} ${budgetValue}",
                            style: TextStyle(
                              color: TColor.gray30,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: TColor.gray60.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Column(
                              children: [
                                ItemRow(
                                    title: S.of(context).name,
                                    value: nameValue,
                                    onValueChanged: updateNameValue),
                                MultiSelectIconRow(
                                    title: "Icon",
                                    selectedValue: iconVisibleValue,
                                    onValueChanged: updateIconValue),
                                ItemDoubleRow(
                                    title: S.of(context).budget,
                                    value: budgetValue,
                                    onValueChanged: updateBudgetValue),
                                ItemColorRow(
                                    title: S.of(context).color,
                                    value: colorValue,
                                    onValueChanged: updateColorValue),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SecondaryButton(
                            title: S.of(context).save,
                            onPressed: () {
                              if (nameValue.isNotEmpty &&
                                  iconValue.isNotEmpty) {
                                var categoryService = CategoriesService();
                                var ctg = new Categories(
                                  id: 1,
                                  name: nameValue,
                                  icon: iconValue,
                                  budget: budgetValue,
                                  inUseBudget: 0,
                                  color: colorValue,
                                  lastUpdatedTime: DateTime.now(),
                                );
                                categoryService.addCategories(ctg);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          S.of(context).success)),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          S.of(context).field_not_null)),
                                );
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 4, right: 4),
                height: media.width * 0.9 + 15,
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: TColor.gray,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    Expanded(
                      child: DottedBorder(
                        dashPattern: const [5, 10],
                        padding: EdgeInsets.zero,
                        strokeWidth: 1,
                        radius: const Radius.circular(16),
                        color: TColor.gray,
                        child: const SizedBox(
                          height: 0,
                        ),
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: TColor.gray,
                          borderRadius: BorderRadius.circular(30)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
