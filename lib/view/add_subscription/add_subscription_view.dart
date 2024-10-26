import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trackizer/common/color_extension.dart';
import 'package:trackizer/common_widget/primary_button.dart';
import 'package:trackizer/common_widget/round_textfield.dart';

import '../../common_widget/image_button.dart';

class AddSubScriptionView extends StatefulWidget {
  const AddSubScriptionView({super.key});

  @override
  State<AddSubScriptionView> createState() => _AddSubScriptionViewState();
}

class _AddSubScriptionViewState extends State<AddSubScriptionView> {
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtAmount = TextEditingController();

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

  double amountVal = 0.09;

  @override
  void initState() {
    super.initState();
    txtAmount.text = amountVal.toStringAsFixed(2);
  }

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
                              "New",
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
                        "Add new\n subscription",
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
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: RoundTextField(title: "Description", titleAlign: TextAlign.center,controller: txtDescription )
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageButton(
                    image: "assets/img/minus.png",
                    onPressed: () {
                      setState(() {
                        amountVal = (amountVal - 0.1).clamp(0.0, double.infinity);
                        txtAmount.text = amountVal.toStringAsFixed(2);
                      });
                    },
                  ),

                  Column(
                    children: [
                      Text(
                        "Monthly price",
                        style: TextStyle(
                            color: TColor.gray40,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),

                      const SizedBox(height: 4,),

                      SizedBox(
                        width: 220,
                        child: TextField(
                          controller: txtAmount,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child:
              PrimaryButton(title: "Add this platform", onPressed: () {}),
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
