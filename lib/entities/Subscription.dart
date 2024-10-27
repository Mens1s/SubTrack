import 'package:trackizer/Enum/SubscriptionType.dart';

class Subscription {
  final int id;
  final int categoryId;
  final int cardId;
  final String name;
  final String desc;
  final String logo;
  final double price;
  final DateTime startDate;
  final DateTime endDate;
  final SubscriptionStatus subscriptionStatus;

  Subscription({
    required this.id,
    required this.categoryId,
    required this.cardId,
    required this.name,
    required this.desc,
    required this.logo,
    required this.price,
    required this.startDate,
    required this.endDate,
    required this.subscriptionStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'cardId': cardId,
      'name': name,
      'desc': desc,
      'logo': logo,
      'price': price,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'subscriptionStatus': subscriptionStatus.index,
    };
  }

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      categoryId: json['categoryId'],
      cardId: json['cardId'],
      name: json['name'],
      desc: json['desc'],
      logo: json['logo'],
      price: json['price'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      subscriptionStatus: SubscriptionStatus.values[json['subscriptionStatus']],
    );
  }
}
