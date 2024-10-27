import 'dart:math';

import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:trackizer/common/color_extension.dart';
import 'package:trackizer/entities/CreditCard.dart';
import 'package:trackizer/entities/Subscription.dart';
import 'package:trackizer/services/CreditCardService.dart';
import 'package:trackizer/services/SubscriptionService.dart';
import 'package:trackizer/view/calender/calender_view.dart';
import 'package:trackizer/generated//l10n.dart';

class CardsView extends StatefulWidget {
  const CardsView({super.key});

  @override
  State<CardsView> createState() => _CardsViewState();
}



class _CardsViewState extends State<CardsView> {

  int currentCardId = 1;


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

  List<Subscription> subscriptionList = [];
  List<Subscription> subscriptionViewList = [];

  Future<void> _getSubscription() async {
    final subscriptionService = SubscriptionService();

    // Fetch credit cards
    List<Subscription> subs = await subscriptionService.getSubscriptions();

    // Update the state with the fetched cards
    setState(() {
      subscriptionList = subs; // Assign the fetched cards to the list
      subscriptionViewList = subscriptionList.where((sub){
        return sub.cardId == creditCardList[0].id;
      }).toList();
    });
  }

  @override
  void initState() {
    _getCreditCards();
    _getSubscription();
  }
  SwiperController controller = SwiperController();

  Widget buildSwiper() {
    return Swiper(
      itemCount: creditCardList.length,
      customLayoutOption: CustomLayoutOption(startIndex: -1, stateCount: 3)
        ..addRotate([-45.0 / 180, 0.0, 45.0 / 180])
        ..addTranslate([
          const Offset(-370.0, -40.0),
          Offset.zero,
          const Offset(370.0, -40.0),
        ]),
      fade: 1.0,
      onIndexChanged: (index) {
        var creditCard = creditCardList[index] as CreditCard? ?? CreditCard(id: 1, cardName: "cardName", cardHolderName: "cardHolderName", lastFourDigit: "lastFourDigit", expDate: "expDate");
        setState(() {
          subscriptionViewList = subscriptionList.where((sub){
            return sub.cardId == creditCard.id;
          }).toList();
        });
      },
      scale: 0.8,
      itemWidth: 232.0,
      itemHeight: 350,
      controller: controller,
      layout: SwiperLayout.STACK,
      viewportFraction: 0.8,
      itemBuilder: ((context, index) {
        var creditCard = creditCardList[index] as CreditCard? ?? CreditCard(id: 1, cardName: "cardName", cardHolderName: "cardHolderName", lastFourDigit: "lastFourDigit", expDate: "expDate");
        currentCardId = creditCard.getId;

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
                  creditCard.getCardName ,
                  style: TextStyle(
                      color: TColor.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 115,
                ),
                Text(
                  creditCard.getCardHolderName ,
                  style: TextStyle(
                      color: TColor.gray20,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "**** **** **** " + creditCard.getLastFourDigit ,
                  style: TextStyle(
                      color: TColor.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  creditCard.getExpDate,
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
              setState(() async {
                // Kredi kartı bilgilerini almak için TextEditingController'lar kullanıyoruz.
                String cardName = nameController.text.trim();
                String cardHolderName = holderNameController.text.trim();
                String lastFourDigit = numberController.text.trim();
                String expDate = expiryController.text.trim();

                if (cardName.isEmpty || cardHolderName.isEmpty || lastFourDigit.isEmpty || expDate.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Lütfen tüm alanları doldurun!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  CreditCardService service = CreditCardService();
                  service.addCreditCard(
                    CreditCard(
                      id: 1,
                      cardName: cardName,
                      cardHolderName: cardHolderName,
                      lastFourDigit: lastFourDigit,
                      expDate: expDate,
                    ),
                  );
                  final creditCardService = CreditCardService();

                  // Fetch credit cards
                  List<CreditCard> cards = await creditCardService.getCreditCards();
                  setState(() {
                    creditCardList = cards; // Assign the fetched cards to the list
                  });

                  // Başarılı mesajı göster
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Kredi kartı başarıyla eklendi!'),
                      backgroundColor: Colors.green,
                    ),
                  );

                }
              });
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

                    ],
                  ),
                ),

                const SizedBox(
                  height: 500,
                ),

                Text(
                  S.of(context).subscriptions,
                  style: TextStyle(
                      color: TColor.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // Yatay kaydırma
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: subscriptionViewList.map((sub) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                        child: Image.asset(
                          sub.logo,
                          width: 45,
                          height: 45,
                        ),
                      );
                    }).toList(),
                  ),
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
