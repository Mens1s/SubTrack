import 'package:flutter/material.dart';
import 'package:trackizer/common/color_extension.dart';
import 'package:trackizer/view/subscription_info/subscription_info_view.dart';

import '../../common_widget/customer_arc_painter.dart';
import '../../common_widget/segment_button.dart';
import '../../common_widget/status_button.dart';
import '../../common_widget/subscription_home_row.dart';
import '../../common_widget/upcoming_bills_row.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isSubscription = true;
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
    {"name": "Netflix", "icon": "assets/img/netflix_logo.png", "price": "15.00"}
  ];

  List billArr = [
    {"name": "Spotify", "date": DateTime(2023, 07, 25), "price": "5.99"},
    {
      "name": "YouTube Premium",
      "date": DateTime(2023, 07, 26),
      "price": "18.99"
    },
    {
      "name": "Microsoft OneDrive",
      "date": DateTime(2023, 07, 27),
      "price": "29.99"
    },
    {"name": "Netflix", "date": DateTime(2023, 07, 28), "price": "15.00"}
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: media.width * 1.1,
              decoration: BoxDecoration(
                color: TColor.gray70.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset("assets/img/home_bg.png"),
                  Container(
                    padding: EdgeInsets.only(bottom: media.width * 0.05),
                    width: media.width * 0.72,
                    height: media.width * 0.72,
                    child: CustomPaint(
                      painter: CustomerArcPainter(
                        end: 220,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      Image.asset("assets/img/app_logo.png",
                          width: media.width * 0.25, fit: BoxFit.contain),
                      SizedBox(
                        height: media.width * 0.07,
                      ),
                      Text(
                        "\$2,002",
                        style: TextStyle(
                            color: TColor.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: media.width * 0.055,
                      ),
                      Text(
                        "Bu ayki harcamalar",
                        style: TextStyle(
                            color: TColor.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: media.width * 0.07,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: TColor.border.withOpacity(0.15)),
                            color: TColor.gray60.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            "Cüzdanını Görüntüle",
                            style: TextStyle(
                              color: TColor.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: StatusButton(
                                title: "Active subs",
                                value: "12",
                                statusColor: TColor.secondary,
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: StatusButton(
                                title: "Highest sub",
                                value: "\$19.99",
                                statusColor: TColor.primary10,
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: StatusButton(
                                title: "Lowest subs",
                                value: "\$5.99",
                                statusColor: TColor.secondaryG,
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  Expanded(
                    child: SegmentButton(
                      title: "Üyeliklerin",
                      isActive: isSubscription,
                      onPressed: () {
                        setState(() {
                          isSubscription = !isSubscription;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: SegmentButton(
                      title: "Yaklaşan Ödemeler",
                      isActive: !isSubscription,
                      onPressed: () {
                        setState(() {
                          isSubscription = !isSubscription;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            if (isSubscription)
              ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: subArr.length,
                  itemBuilder: (context, index) {
                    var sObj = subArr[index] as Map? ?? {};
                    return SubscriptionHomeRow(sObj: sObj, onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SubscriptionInfoView(sObj:sObj)));
                    });
                  }),
            if (!isSubscription)
              ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: billArr.length,
                  itemBuilder: (context, index) {
                    var sObj = billArr[index] as Map? ?? {};
                    return UpcomingBillsRow(sObj: sObj, onPressed: () {});
                  }),
            const SizedBox(
              height: 110,
            ),
          ],
        ),
      ),
    );
  }
}
