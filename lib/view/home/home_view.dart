import 'package:flutter/material.dart';
import 'package:trackizer/Enum/SubscriptionType.dart';
import 'package:trackizer/common/color_extension.dart';
import 'package:trackizer/entities/Subscription.dart';
import 'package:trackizer/services/SubscriptionService.dart';
import 'package:trackizer/view/subscription_info/subscription_info_view.dart';
import 'package:trackizer/generated//l10n.dart';
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
  List<Subscription> subscriptionList = [];
  List<Subscription> subscriptionOrderedList = [];
  var activeSub = 0;
  double highestSub = -1;
  double lowestSub = 1;
  double totalSubTrack = 0;
  Future<void> _getSubscription() async {
    final subscriptionService = SubscriptionService();

    // Fetch credit cards
    List<Subscription> subs = await subscriptionService.getSubscriptions();
    subs.sort((a,b) => a.price.compareTo(b.price));

    // Update the state with the fetched cards
    setState(() {
      activeSub = subs.length;
      subscriptionList = subs; // Assign the fetched cards to the list
      highestSub = subs.last.price;
      lowestSub = subs.first.price;

      for(var s in subs){
        totalSubTrack += s.price;
      }
    });


    setState(() {
      subs.sort((a, b) => a.startDate.compareTo(b.startDate));
      subscriptionOrderedList = subs; // Assign the fetched cards to the list
    });
  }

  bool isSubscription = true;

  @override
  void initState() {
    super.initState(); // Call the initialization method
    _getSubscription();
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
              height: media.width * 0.95,
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
                        height: media.width * 0.01,
                      ),
                      Image.asset("assets/img/app_logo.png",
                          width: media.width * 0.25, fit: BoxFit.contain),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      Text(
                        "${S.of(context).currency}$totalSubTrack",
                        style: TextStyle(
                            color: TColor.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      Text(
                        S.of(context).monthly_expenses,
                        style: TextStyle(
                            color: TColor.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: media.width * 0.065,
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
                            S.of(context).view_your_wallet,
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
                                title: S.of(context).active_subs,
                                value: activeSub.toString(),
                                statusColor: TColor.secondary,
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: StatusButton(
                                title: S.of(context).highest_sub,
                                value: "${S.of(context).currency} $highestSub",
                                statusColor: TColor.primary10,
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: StatusButton(
                                title: S.of(context).lowest_sub,
                                value: "${S.of(context).currency} $lowestSub",
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
                      title: S.of(context).memberships,
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
                      title: S.of(context).upcoming_bills,
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
                  itemCount: subscriptionList.length,
                  itemBuilder: (context, index) {
                    var sub = subscriptionList[index] as Subscription? ?? Subscription(id: 1, categoryId: 1, cardId: 1, name: "name", desc: "desc", logo: "logo", price: 111, startDate: DateTime.now(), endDate: DateTime.now(), subscriptionStatus: SubscriptionStatus.canceled);
                    return SubscriptionHomeRow(sub: sub, onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SubscriptionInfoView(sub:sub)));
                    });
                  }),
            if (!isSubscription)
              ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: subscriptionOrderedList.length,
                  itemBuilder: (context, index) {
                    var sub = subscriptionOrderedList[index] as Subscription? ?? Subscription(id: 1, categoryId: 1, cardId: 1, name: "name", desc: "desc", logo: "logo", price: 111, startDate: DateTime.now(), endDate: DateTime.now(), subscriptionStatus: SubscriptionStatus.canceled);
                    return UpcomingBillsRow(sub: sub, onPressed: () {});
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
