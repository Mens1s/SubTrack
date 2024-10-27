import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trackizer/common/color_extension.dart';
import 'package:trackizer/common_widget/primary_button.dart';
import 'package:trackizer/common_widget/round_datefield.dart';
import 'package:trackizer/common_widget/round_textfield.dart';
import 'package:trackizer/entities/Categories.dart';
import 'package:trackizer/entities/CreditCard.dart';
import 'package:trackizer/entities/Subscription.dart';
import 'package:trackizer/generated//l10n.dart';
import 'package:trackizer/services/CategoriesService.dart';
import 'package:trackizer/services/CreditCardService.dart';
import 'package:trackizer/services/SubscriptionService.dart';
import '../../common_widget/image_button.dart';
import 'package:trackizer/Enum/SubscriptionType.dart';

class AddSubScriptionView extends StatefulWidget {
  const AddSubScriptionView({super.key});

  @override
  State<AddSubScriptionView> createState() => _AddSubScriptionViewState();
}

class SubscriptionOptionsDialog extends StatelessWidget {
  final Function(SubscriptionStatus) onSelected;

  const SubscriptionOptionsDialog({Key? key, required this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black87, // Dark background
      title: Text(
        'Select Subscription Type',
        style: TextStyle(color: Colors.white),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('Daily', style: TextStyle(color: Colors.white)),
            onTap: () {
              onSelected(SubscriptionStatus.daily);
              Navigator.of(context).pop(); // Close dialog
            },
          ),
          ListTile(
            title: Text('Weekly', style: TextStyle(color: Colors.white)),
            onTap: () {
              onSelected(SubscriptionStatus.weekly);
              Navigator.of(context).pop(); // Close dialog
            },
          ),
          ListTile(
            title: Text('Monthly', style: TextStyle(color: Colors.white)),
            onTap: () {
              onSelected(SubscriptionStatus.monthly);
              Navigator.of(context).pop(); // Close dialog
            },
          ),
          ListTile(
            title: Text('Daily', style: TextStyle(color: Colors.white)),
            onTap: () {
              onSelected(SubscriptionStatus.daily);
              Navigator.of(context).pop(); // Close dialog
            },
          ),
          ListTile(
            title: Text('One-time', style: TextStyle(color: Colors.white)),
            onTap: () {
              onSelected(SubscriptionStatus.onetime);
              Navigator.of(context).pop(); // Close dialog
            },
          ),
        ],
      ),
    );
  }
}

class _AddSubScriptionViewState extends State<AddSubScriptionView> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtDate = TextEditingController();
  TextEditingController txtAmount = TextEditingController();

  List<CreditCard> creditCardList = [];

  Future<void> _getCreditCards() async {
    final creditCardService = CreditCardService();

    // Fetch credit cards
    List<CreditCard> cards = await creditCardService.getCreditCards();

    // Update the state with the fetched cards
    setState(() {
      creditCardList = cards; // Assign the fetched cards to the list
    });
  }

  List<Categories> categoryList = [];

  Future<void> _getCategoriesList() async {
    final categoriesService = CategoriesService();

    // Fetch credit cards
    List<Categories> cat = await categoriesService.getCategoriess();

    // Update the state with the fetched cards
    setState(() {
      categoryList = cat; // Assign the fetched cards to the list
    });
  }

  @override
  void initState() {
    super.initState();
    txtAmount.text = amountVal.toStringAsFixed(2);
    _getCreditCards();
    _getCategoriesList();
  }

  List subArr = [
    {"name": "HBO GO", "icon": "assets/img/hbo_logo.png"},
    {"name": "Spotify", "icon": "assets/img/spotify_logo.png"},
    {"name": "YouTube Premium", "icon": "assets/img/youtube_logo.png"},
    {
      "name": "Microsoft OneDrive",
      "icon": "assets/img/onedrive_logo.png",
    },
    {"name": "NetFlix", "icon": "assets/img/netflix_logo.png"}
  ];

  CreditCard? selectedCard;
  Categories? selectedCategory;

  double amountVal = 0.09;
  String imageUrl = "";
  int imageIndex = 0;

  void updateAmount(String value) {
    setState(() {
      amountVal = double.tryParse(value) ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: TColor.gray70.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Image.asset("assets/img/back.png",
                                    width: 25,
                                    height: 25,
                                    color: TColor.gray30))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              S.of(context).newS,
                              style:
                                  TextStyle(color: TColor.gray30, fontSize: 16),
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        S.of(context).add_new_subscription,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: TColor.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      width: media.width,
                      height: media.width * 0.6,
                      child: CarouselSlider.builder(
                        options: CarouselOptions(
                          autoPlay: false,
                          aspectRatio: 1,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                          viewportFraction: 0.65,
                          enlargeFactor: 0.4,
                          enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                        ),
                        itemCount: subArr.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          var sObj = subArr[itemIndex] as Map? ?? {};
                          imageUrl = sObj["icon"];
                          imageIndex = itemIndex - 1;
                          if (imageIndex == -1) {
                            imageIndex = subArr.length - 1;
                          }
                          return Container(
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  sObj["icon"],
                                  width: media.width * 0.4,
                                  height: media.width * 0.4,
                                  fit: BoxFit.fitHeight,
                                ),
                                const Spacer(),
                                Text(
                                  sObj["name"],
                                  style: TextStyle(
                                      color: TColor.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: RoundTextField(
                  title: S.of(context).name,
                  titleAlign: TextAlign.center,
                  controller: txtName,
                )),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: RoundDateField(
                title: S.of(context).sub_start_date_choose,
                titleAlign: TextAlign.center, // Başlık metnini ortalamak için
                controller: txtDate,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageButton(
                    image: "assets/img/minus.png",
                    onPressed: () {
                      setState(() {
                        amountVal =
                            (amountVal - 0.1).clamp(0.0, double.infinity);
                        txtAmount.text = amountVal.toStringAsFixed(2);
                      });
                    },
                  ),
                  Column(
                    children: [
                      Text(
                        S.of(context).monthly_price,
                        style: TextStyle(
                            color: TColor.gray40,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      SizedBox(
                        width: 220,
                        child: TextField(
                          controller: txtAmount,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d{0,2}'))
                          ],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: TColor.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w700),
                          onChanged: updateAmount,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 150,
                        height: 1,
                        color: TColor.gray70,
                      )
                    ],
                  ),
                  ImageButton(
                    image: "assets/img/plus.png",
                    onPressed: () {
                      setState(() {
                        amountVal += 0.1;
                        txtAmount.text = amountVal.toStringAsFixed(2);
                      });
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Kredi Kartı Seçimi
                  Expanded(
                    child: DropdownButton<CreditCard>(
                      value: selectedCard,
                      // Seçili kartı gösteren değişken
                      hint: Text(
                        S.of(context).card_name, // Kredi kartı seçin metni
                        style: TextStyle(color: TColor.gray40),
                      ),
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.white),
                      items: creditCardList
                          .map<DropdownMenuItem<CreditCard>>((CreditCard card) {
                        return DropdownMenuItem<CreditCard>(
                          value: card, // Use the actual CreditCard object here
                          child: Text(
                            card.cardName,
                            style: TextStyle(color: TColor.white),
                          ),
                        );
                      }).toList(),
                      onChanged: (CreditCard? newValue) {
                        setState(() {
                          selectedCard = newValue!;
                        });
                      },
                      dropdownColor: TColor.gray70,
                      // Dropdown arka plan rengi
                      isExpanded: true,
                    ),
                  ),

                  const SizedBox(width: 20), // Araya boşluk ekle

                  // Kategori Seçimi
                  Expanded(
                    child: DropdownButton<Categories>(
                      value: selectedCategory,
                      // Seçili kategori
                      hint: Text(
                        S.of(context).category, // Kategori seçin metni
                        style: TextStyle(color: TColor.gray40),
                      ),
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.white),
                      items: categoryList.map<DropdownMenuItem<Categories>>(
                          (Categories category) {
                        return DropdownMenuItem<Categories>(
                          value: category,
                          child: Text(
                            category.getName,
                            style: TextStyle(color: TColor.white),
                          ),
                        );
                      }).toList(),
                      onChanged: (Categories? newValue) {
                        setState(() {
                          selectedCategory = newValue!;
                        });
                      },
                      dropdownColor: TColor.gray70,
                      // Dropdown arka plan rengi
                      isExpanded: true,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PrimaryButton(
                title: S.of(context).add_this_platform,
                onPressed: () async {
                  print(imageIndex);

                  if (selectedCategory == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(S.of(context).cat_not_null),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  } else if (selectedCard == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(S.of(context).card_not_null),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  } else if (txtName.text.isEmpty || txtDate.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(S.of(context).field_not_null),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  // Show the subscription options dialog
                  showDialog(
                    context: context,
                    builder: (context) {
                      return SubscriptionOptionsDialog(
                        onSelected: (SubscriptionStatus status) async {
                          // Create your subscription service and add subscription here
                          final service = SubscriptionService();
                          final subscription = Subscription(
                            id: 1,
                            categoryId: selectedCategory!.getId,
                            cardId: selectedCard!.getId,
                            name: txtName.text,
                            desc: txtName.text,
                            logo: subArr[imageIndex]["icon"],
                            price: double.parse(txtAmount.text),
                            startDate: DateTime.parse(txtDate.text),
                            endDate: DateTime(DateTime.now().year, 12, 31),
                            // Change duration based on status
                            subscriptionStatus:
                                status, // Use the selected status
                          );

                          await service.addSubscription(subscription);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(S.of(context).success),
                              backgroundColor: Colors.green,
                            ),
                          );
                          // Close the dialog
                        },
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
