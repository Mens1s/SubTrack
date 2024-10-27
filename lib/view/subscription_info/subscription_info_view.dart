import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trackizer/Enum/SubscriptionType.dart';
import 'package:trackizer/common/color_extension.dart';
import 'package:trackizer/common_widget/item_date_select_row.dart';
import 'package:trackizer/common_widget/item_double_row.dart';
import 'package:trackizer/common_widget/item_row.dart';
import 'package:trackizer/common_widget/multi_select_category_row.dart';
import 'package:trackizer/common_widget/multi_select_subs_status_row.dart';
import 'package:trackizer/common_widget/secondary_button.dart';
import 'package:trackizer/entities/Categories.dart';
import 'package:trackizer/entities/Subscription.dart';
import 'package:trackizer/generated//l10n.dart';
import 'package:trackizer/services/CategoriesService.dart';
import 'package:trackizer/services/SubscriptionService.dart';

class SubscriptionInfoView extends StatefulWidget {
  final Subscription sub;

  const SubscriptionInfoView({super.key, required this.sub});

  @override
  State<SubscriptionInfoView> createState() => _SubscriptionInfoViewState();
}

class _SubscriptionInfoViewState extends State<SubscriptionInfoView> {
  String currencyValue = "";
  String nameValue = "";
  String descValue = "";
  SubscriptionStatus reminderValue = SubscriptionStatus.canceled;
  double priceValue = 0;
  DateTime firstPaymentValue = DateTime.now();

  Categories category = Categories(id: 1, icon:"", color: Colors.white, name: "name", budget: 1, inUseBudget: 1, lastUpdatedTime: DateTime.now());
  List<Categories> categoryList = [];

  Future<void> _getInitialValues() async {

    setState(() {
      currencyValue = '\$';
      nameValue = widget.sub.name;
      descValue = widget.sub.desc;
      reminderValue = widget.sub.subscriptionStatus;
      priceValue = widget.sub.price;
      firstPaymentValue = widget.sub.startDate;
    });

  }

  Future<void> _getCategories() async {
    final catService = CategoriesService();
    // Fetch credit cards
    List<Categories> cat = await catService.getCategoriess();
    setState(() {
      categoryList = cat;
    });
    for (var c in cat) {
      if (c.id == widget.sub.categoryId) {
        setState(() {
          category = c;
        });
      }
    }
  }

  void updateCategorySelectedOption(Categories newValue) {
    setState(() {
      category = newValue; // Seçimi güncelle
    });
  }

  void updateSubStatusSelectedOption(SubscriptionStatus newValue) {
    setState(() {
      reminderValue = newValue; // Seçimi güncelle
    });
  }

  void updateCurrencySelectedOption(String newValue) {
    setState(() {
      currencyValue = newValue; // Seçimi güncelle
    });
  }

  @override
  void initState() {
    super.initState(); // Call the initialization method
    _getInitialValues();
    _getCategories();
  }

  void _updateName(String newValue) {
    setState(() {
      nameValue = newValue;
    });
  }

  void _updateDescription(String newValue) {
    setState(() {
      descValue = newValue;
    });
  }

  void _updateStartDate(DateTime newValue) {
    setState(() {
      firstPaymentValue = newValue;
    });
  }

  void _updatePrice(double newValue) {
    setState(() {
      priceValue = newValue;
    });
  }


  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    currencyValue = "Curr: (${S
        .of(context)
        .currency})";
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
                                S
                                    .of(context)
                                    .subscription_info,
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
                            widget.sub.logo,
                            width: media.width * 0.25,
                            height: media.width * 0.25,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            widget.sub.name,
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
                            "${S
                                .of(context)
                                .currency} ${widget.sub.price}",
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
                                    title: S.of(context).name, value: nameValue,
                                    onValueChanged: _updateName),
                                ItemRow(
                                    title: S.of(context).description,
                                    value: descValue,
                                    onValueChanged: _updateDescription),
                                ItemDoubleRow(
                                    title: S.of(context).monthly_price,
                                    value: priceValue,
                                    onValueChanged: _updatePrice),
                                ItemDateSelectRow(
                                    title: S.of(context).monthly_payment_date,
                                    selectedDate: firstPaymentValue,
                                    onDateChanged: _updateStartDate),

                                MultiSelectCategoryRow(
                                  title: S.of(context).category,
                                  options: categoryList,
                                  selectedValue: category,
                                  onValueChanged: updateCategorySelectedOption,
                                ),

                                MultiSelectSubsStatusRow(
                                  title: S.of(context).subs_schedule,
                                  selectedValue: reminderValue,
                                  onValueChanged: updateSubStatusSelectedOption,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SecondaryButton(
                            title: S
                                .of(context)
                                .save,
                            onPressed: () {
                              var updatedSubscription =
                              Subscription(id: 1,
                                  categoryId: category.id,
                                  cardId: widget.sub.cardId,
                                  name: nameValue,
                                  desc: descValue,
                                  logo: widget.sub.logo,
                                  price: priceValue,
                                  startDate: firstPaymentValue,
                                  endDate: widget.sub.endDate,
                                  subscriptionStatus: reminderValue);
                              // Null kontrolü
                              if (updatedSubscription.name != null &&
                                  updatedSubscription.categoryId != null &&
                                  updatedSubscription.cardId != null &&
                                  updatedSubscription.price != null &&
                                  updatedSubscription.startDate != null &&
                                  updatedSubscription.endDate != null &&
                                  updatedSubscription.subscriptionStatus != null) {
                                var subService = SubscriptionService();
                                subService.updateSubscription(
                                    updatedSubscription);

                                // Güncelleme başarılıysa Snackbar gös6ter
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(
                                      'Subscription updated successfully!')),
                                );
                              } else {
                                // Eksik veya null değer varsa Snackbar ile uyarı göster
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(
                                      'Please fill all fields before saving.')),
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
