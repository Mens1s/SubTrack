import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackizer/Enum/SubscriptionType.dart';
import 'package:trackizer/entities/Subscription.dart';
import 'package:trackizer/services/CategoriesService.dart';

class SubscriptionService {
  static const String _key = 'subscriptions';

  Future<List<Subscription>> getSubscriptions() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Subscription.fromJson(json)).toList();
  }

  Future<List<Subscription>> getSubscriptionsByCreditCardId(int cardId) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString);

    return jsonList
        .map((json) => Subscription.fromJson(json))
        .where((subscription) => subscription.cardId == cardId)
        .toList();
  }

  Future<void> addSubscription(Subscription subscription) async {
    final subscriptions = await getSubscriptions();

    int newId = subscriptions.isNotEmpty
        ? subscriptions.map((s) => s.id).reduce((a, b) => a > b ? a : b) + 1
        : 1;
    DateTime endDate = subscription.endDate;

    if(subscription.subscriptionStatus == SubscriptionStatus.onetime){
      endDate = DateTime.now();
    }
    final newSubscription = Subscription(
      id: newId,
      categoryId: subscription.categoryId,
      cardId:subscription.cardId,
      name:subscription.name,
      desc:subscription.desc,
      logo:subscription.logo,
      price:subscription.price,
      startDate:subscription.startDate,
      endDate:endDate,
      subscriptionStatus:subscription.subscriptionStatus,
    );

    subscriptions.add(newSubscription);
    await _saveSubscriptions(subscriptions);
  }

  Future<void> updateSubscription(Subscription updatedSubscription) async {
    final subscriptions = await getSubscriptions();
    final index = subscriptions.indexWhere((s) => s.id == updatedSubscription.id);
    if (index != -1) {
      subscriptions[index] = updatedSubscription;
      await _saveSubscriptions(subscriptions);
    }
  }

  Future<void> removeSubscription(int id) async {
    final subscriptions = await getSubscriptions();
    subscriptions.removeWhere((s) => s.id == id);
    await _saveSubscriptions(subscriptions);
  }

  Future<void> _saveSubscriptions(List<Subscription> subscriptions) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(subscriptions.map((s) => s.toJson()).toList());
    await prefs.setString(_key, jsonString);
    final catService = CategoriesService();
    await catService.updateMonthlyCategories();
  }

  Future<List<Subscription>> getSubscriptionsByMonth(int month) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString);

    return jsonList
        .map((json) => Subscription.fromJson(json))
        .where((subscription) => subscription.startDate.month <= month && subscription.endDate.month >= month)
        .toList();
  }
}
