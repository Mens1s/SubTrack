import 'dart:math';

import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:trackizer/common/color_extension.dart';
import 'package:trackizer/view/calender/calender_view.dart';
import 'package:trackizer/generated//l10n.dart';

class CardsView extends StatefulWidget {
  const CardsView({super.key});

  @override
  State<CardsView> createState() => _CardsViewState();
}



class _CardsViewState extends State<CardsView> {
  List subArr = [
    {"name": "Spotify", "icon": "assets/img/spotify_logo.png", "price": "5.99"},
    {
      "name": "YouTube Premium",
      "icon": "assets/img/youtube_logo.png",
      "price": "18.99"
    },
    {
      "name": "Microsoft OneDrive",
      "icon": "assets/img/onedrive_logo.png",
      "price": "29.99"
    },
    {"name": "NetFlix", "icon": "assets/img/netflix_logo.png", "price": "15.00"}
  ];

  List carArr = [
    {
      "name":"Virtual Card",
      "holder_name": "code for any1",
      "number": "**** **** **** 2197",
      "month_year": "08/27"
    },
    {
      "name":"Virtual Card",
      "holder_name": "code for any1",
      "number": "**** **** **** 2198",
      "month_year": "09/27"
    },
    {
      "name":"Virtual Card",
      "holder_name": "code for any1",
      "number": "**** **** **** 2297",
      "month_year": "07/27"
    },
    {
      "name":"Virtual Card",
      "holder_name": "code for any1",
      "number": "**** **** **** 2397",
      "month_year": "05/27"
    },
  ];

  SwiperController controller = SwiperController();

  Widget buildSwiper() {
    return Swiper(
      itemCount: carArr.length,
      customLayoutOption: CustomLayoutOption(startIndex: -1, stateCount: 3)
        ..addRotate([-45.0 / 180, 0.0, 45.0 / 180])
        ..addTranslate([
          const Offset(-370.0, -40.0),
          Offset.zero,
          const Offset(370.0, -40.0),
        ]),
      fade: 1.0,
      onIndexChanged: (index) {
        print(index);
      },
      scale: 0.8,
      itemWidth: 232.0,
      itemHeight: 350,
      controller: controller,
      layout: SwiperLayout.STACK,
      viewportFraction: 0.8,
      itemBuilder: ((context, index) {
        var cObj = carArr[index] as Map? ?? {};
        return Container(
          decoration: BoxDecoration(
              color: TColor.gray70,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 4)
              ]),
          child: Stack(fit: StackFit.expand, children: [
            Image.asset(
              "assets/img/card_blank.png",
              width: 232.0,
              height: 350,
            ),
            Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Image.asset("assets/img/mastercard_logo.png", width: 50),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  cObj["name"] ?? "Code For Any",
                  style: TextStyle(
                      color: TColor.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 115,
                ),
                Text(
                  cObj["holder_name"] ?? "Code For Any",
                  style: TextStyle(
                      color: TColor.gray20,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  cObj["number"] ?? "**** **** **** 2197",
                  style: TextStyle(
                      color: TColor.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  cObj["month_year"] ?? "08/27",
                  style: TextStyle(
                      color: TColor.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ],
            )
          ]),
        );
      }),
      autoplayDisableOnInteraction: false,
      axisDirection: AxisDirection.right,
    );
  }

  void _showAddCardPopup(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController holderNameController = TextEditingController();
    TextEditingController numberController = TextEditingController();
    TextEditingController expiryController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).add_new_card),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: S.of(context).card_name),
            ),
            TextField(
              controller: holderNameController,
              decoration: InputDecoration(labelText: S.of(context).holder_name),
            ),
            TextField(
              controller: numberController,
              decoration: InputDecoration(labelText: S.of(context).last_4_digits),
              keyboardType: TextInputType.number,
              maxLength: 4,
            ),
            TextField(
              controller: expiryController,
              decoration:  InputDecoration(labelText: S.of(context).exp_date),
              keyboardType: TextInputType.datetime,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                carArr.add({
                  "name": nameController.text,
                  "holder_name": holderNameController.text,
                  "number": "**** **** **** ${numberController.text}",
                  "month_year": expiryController.text,
                });
              });
              print("hellllooooooooo");
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
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: double.infinity,
              height: 600,
              child: buildSwiper(),
            ),
            Column(
              children: [
                SafeArea(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).credit_cards,
                            style:
                            TextStyle(color: TColor.gray30, fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const CalenderView()));
                              },
                              icon: Image.asset("assets/img/settings.png",
                                  width: 25, height: 25, color: TColor.gray30))
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 460,
                ),

                Text(
                  S.of(context).subscriptions,
                  style: TextStyle(
                      color: TColor.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: subArr.map((sObj) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      child: Image.asset(
                        sObj["icon"],
                        width: 45,
                        height: 45,
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(
                  height: 40,
                ),

                Container(
                  height: 240,
                  decoration: BoxDecoration(
                      color: TColor.gray70.withOpacity(0.5),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),

                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          _showAddCardPopup(context);
                        },
                        child: DottedBorder(
                          dashPattern: const [5, 4],
                          strokeWidth: 1,
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(16),
                          color: TColor.border.withOpacity(0.1),
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  S.of(context).add_new_card,
                                  style: TextStyle(
                                      color: TColor.gray30,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 6,),
                                Image.asset(
                                  "assets/img/add.png",
                                  width: 14,
                                  height: 14,
                                  color: TColor.gray30,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
