import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trackizer/view/add_subscription/add_subscription_view.dart';
import 'package:trackizer/view/calender/calender_view.dart';
import 'package:trackizer/view/card/cards_view.dart';
import 'package:trackizer/view/spending_budgets/spending_budgets_view.dart';

import '../../common/color_extension.dart';
import '../home/home_view.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int selectedTab = 0;
  PageStorageBucket pageStorageBucket = PageStorageBucket();
  Widget currentTabView = HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.gray,
      body: Stack(
        children: [
          PageStorage(bucket: pageStorageBucket, child: currentTabView),
          SafeArea(
            child: Column(
              children: [
                const Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset("assets/img/bottom_bar_bg.png"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectedTab = 0;
                                    currentTabView = const HomeView();
                                  });
                                },
                                icon: Image.asset(
                                  "assets/img/home.png",
                                  width: 20,
                                  height: 20,
                                  color: selectedTab == 0
                                      ? TColor.white
                                      : TColor.gray40,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectedTab = 1;
                                    currentTabView =
                                        const SpendingBudgetsView();
                                  });
                                },
                                icon: Image.asset(
                                  "assets/img/budgets.png",
                                  width: 20,
                                  height: 20,
                                  color: selectedTab == 1
                                      ? TColor.white
                                      : TColor.gray40,
                                ),
                              ),
                              const SizedBox(
                                width: 50,
                                height: 50,
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectedTab = 2;
                                    currentTabView = const CalenderView();
                                  });
                                },
                                icon: Image.asset(
                                  "assets/img/calendar.png",
                                  width: 20,
                                  height: 20,
                                  color: selectedTab == 2
                                      ? TColor.white
                                      : TColor.gray40,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectedTab = 3;
                                    currentTabView = const CardsView();
                                  });
                                },
                                icon: Image.asset(
                                  "assets/img/creditcards.png",
                                  width: 20,
                                  height: 20,
                                  color: selectedTab == 3
                                      ? TColor.white
                                      : TColor.gray40,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddSubScriptionView(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: TColor.secondary.withOpacity(0.25),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          ], borderRadius: BorderRadius.circular(50)),
                          child: Image.asset("assets/img/center_btn.png",
                              width: 55, height: 55),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
