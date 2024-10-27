import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackizer/entities/Categories.dart';
import 'package:trackizer/entities/CreditCard.dart';
import 'package:trackizer/entities/Subscription.dart';
import 'package:trackizer/services/CategoriesService.dart';
import 'package:trackizer/services/CreditCardService.dart';
import 'package:trackizer/services/SubscriptionService.dart';
import 'package:trackizer/view/add_subscription/add_subscription_view.dart';
import 'package:trackizer/view/calender/calender_view.dart';
import 'package:trackizer/view/card/cards_view.dart';
import 'package:trackizer/view/spending_budgets/spending_budgets_view.dart';
import 'package:trackizer/Enum/SubscriptionType.dart';
import '../../common/color_extension.dart';
import '../home/home_view.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  @override
  void initState() {
    super.initState();
    _initializeData(); // Call the initialization method
  }

  Future<void> _initializeData() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstRun = prefs.getBool('isFirstRun') ?? true;

    if (isFirstRun) {
      final subscriptionService = SubscriptionService();
      final categoryService = CategoriesService();
      final creditCardService = CreditCardService();

      final creditCard = CreditCard(
        id: 1,
        cardName: 'Ahmetin Kartı',
        cardHolderName: 'Ahmet Yiğit',
        expDate: '12/25',
        lastFourDigit: '1234',
      );

      await creditCardService.addCreditCard(creditCard);

      final category = Categories(id: 1, icon:"assets/img/security.png", color: Colors.orange, name: "Security", budget: 100, inUseBudget: 0, lastUpdatedTime: DateTime.now());

      await categoryService.addCategories(category);

      final subscription = Subscription(
        id: 1,
        categoryId: 1,
        cardId: 1, // Kart ID
        name: 'Spotify',
        desc: 'Müzik aboneliği',
        logo: 'assets/img/spotify_logo.png',
        price: 9.99,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 30)),
        subscriptionStatus: SubscriptionStatus.monthly,
      );


      await subscriptionService.addSubscription(subscription);

      // İlk çalıştırmanın yapıldığını kaydet
      await prefs.setBool('isFirstRun', false);

    }
    /*
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.clear();
    */
  }


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
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
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
                                    currentTabView = const SpendingBudgetsView();
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
