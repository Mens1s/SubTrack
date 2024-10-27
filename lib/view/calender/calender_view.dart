import 'dart:math';

import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackizer/Enum/SubscriptionType.dart';
import 'package:trackizer/common/color_extension.dart';
import 'package:trackizer/entities/Subscription.dart';
import 'package:trackizer/generated//l10n.dart';
import 'package:trackizer/services/SubscriptionService.dart';
import '../../common_widget/subscription_cell.dart';

class CalenderView extends StatefulWidget {
  const CalenderView({super.key});

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  CalendarAgendaController calendarAgendaControllerNotAppBar =
      CalendarAgendaController();
  late DateTime selectedDateNotAppBBar;
  String selectedMonth = DateFormat('MMMM').format(DateTime.now());

  String formattedDate = DateFormat("dd.MM.yyyy").format(DateTime.now());
  Random random = new Random();

  List<Subscription> subscriptionList = [];
  List<DateTime> subscriptionDateList = [];

  Future<void> _getSubscription() async {
    final subscriptionService = SubscriptionService();
    List<Subscription> subs = await subscriptionService.getSubscriptions();
    subs.sort((a, b) => a.startDate.compareTo(b.startDate));

    subscriptionDateList.clear(); // Önceden var olanları temizleyin

    setState(() {

      for (var c in subs) {
        DateTime currentDate = c.startDate;
        subscriptionDateList.add(currentDate);

        if(c.startDate.month >= DateTime.now().month && !(c.endDate.month < DateTime.now().month)){
          subscriptionList.add(c);

          if (c.subscriptionStatus == SubscriptionStatus.weekly) {
            for (int i = 0; i < 4; i++) {
              DateTime weeklyDate = DateTime(
                DateTime.now().year,
                DateTime.now().month,
                c.startDate.day + (i * 7),
              );
              subscriptionDateList.add(weeklyDate);
            }
          } else if (c.subscriptionStatus == SubscriptionStatus.monthly) {
            DateTime monthlyDate = DateTime(
              DateTime.now().year,
              DateTime.now().month,
              c.startDate.day,
            );
            subscriptionDateList.add(monthlyDate);
          } else if (c.subscriptionStatus == SubscriptionStatus.onetime && c.startDate.month == DateTime.now().month) {
            DateTime oneTimeDate = DateTime(
              DateTime.now().year,
              DateTime.now().month,
              c.startDate.day,
            );
            subscriptionDateList.add(oneTimeDate);
          }
        }
      }
    });
  }

  double monthlyTotalPrice = 0.0;
  int monthlySubsCount = 0;

  Future<void> _getMonthlyExpenses() async {

    final subscriptionService = SubscriptionService();
    List<Subscription> subs = await subscriptionService
        .getSubscriptionsByMonth(selectedDateNotAppBBar.month);
    setState(() {
      for(var s in subs){
        monthlyTotalPrice += s.price;
        ++monthlySubsCount;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    selectedDateNotAppBBar = DateTime.now();
    _getSubscription();
    _getMonthlyExpenses();
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    S.of(context).calender,
                                    style: TextStyle(
                                        color: TColor.gray30, fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            S.of(context).subs_schedule,
                            style: TextStyle(
                                color: TColor.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                monthlySubsCount.toString() + S.of(context).monthly_sub_count,
                                style: TextStyle(
                                    color: TColor.gray30,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {

                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: TColor.border.withOpacity(0.1),
                                    ),
                                    color: TColor.gray60.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  alignment: Alignment.center,

                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    CalendarAgenda(
                      controller: calendarAgendaControllerNotAppBar,
                      backgroundColor: Colors.transparent,
                      fullCalendarBackgroundColor: TColor.gray80,
                      locale: S.current.cancel.compareTo("cancel") == 0
                          ? 'en'
                          : 'tr',
                      weekDay: WeekDay.short,
                      fullCalendarDay: WeekDay.short,
                      selectedDateColor: TColor.white,
                      initialDate: DateTime.now(),
                      // Başlangıç tarihi bugünden
                      calendarEventColor: TColor.secondary,
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 140)),
                      lastDate: DateTime.now().add(const Duration(days: 140)),
                      events: subscriptionDateList,
                      onDateSelected: (date) async {
                        setState(() {
                          selectedDateNotAppBBar = date; // Tarih burada güncelleniyor
                          formattedDate = DateFormat("dd.MM.yyyy").format(date);
                        });

                        final subscriptionService = SubscriptionService();
                        List<Subscription> subs = await subscriptionService
                            .getSubscriptionsByMonth(selectedDateNotAppBBar.month);

                        setState(() {
                          subscriptionList.clear();
                          subscriptionList = subs;
                          monthlyTotalPrice = 0;
                          for(var s in subs){
                            monthlyTotalPrice += s.price;
                          }
                          selectedMonth = DateFormat('MMMM').format(date);
                          formattedDate = DateFormat("dd.MM.yyyy").format(date);
                        });
                      },

                      decoration: BoxDecoration(
                        border: Border.all(
                          color: TColor.border.withOpacity(0.15),
                        ),
                        color: TColor.gray60.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),

                      selectDecoration: BoxDecoration(
                        border: Border.all(
                          color: TColor.border.withOpacity(0.15),
                        ),
                        color: TColor.gray60,
                        borderRadius: BorderRadius.circular(12),
                      ),

                      selectedEventLogo: Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: TColor.secondary,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      eventLogo: Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: TColor.secondary,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedMonth,
                        style: TextStyle(
                            color: TColor.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${S.of(context).currency} $monthlyTotalPrice",
                        style: TextStyle(
                            color: TColor.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formattedDate,
                        style: TextStyle(
                            color: TColor.gray30,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        S.of(context).in_upcoming_bills,
                        style: TextStyle(
                            color: TColor.gray30,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  )
                ],
              ),
            ),
            GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1),
                itemCount: subscriptionList.length,
                itemBuilder: (context, index) {
                  var sub = subscriptionList[index] as Subscription? ??
                      Subscription(
                          id: 1,
                          categoryId: 1,
                          cardId: 1,
                          name: "name",
                          desc: "desc",
                          logo: "logo",
                          price: 1,
                          startDate: DateTime.now(),
                          endDate: DateTime.now(),
                          subscriptionStatus: SubscriptionStatus.canceled);

                  return SubscriptionCell(
                    sub: sub,
                    onPressed: () {},
                  );
                }),
            const SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }
}
