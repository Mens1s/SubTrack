import 'dart:ui';

class Categories {
  final int id;
  final String name;
  final String icon;
  final double budget;
  double inUseBudget;
  final Color color;
  final DateTime lastUpdatedTime;//monthly up

  Categories({
    required this.id,
    required this.name,
    required this.icon,
    required this.budget,
    this.inUseBudget = 0,
    required this.color,
    required this.lastUpdatedTime,
  });

  // JSON formatına çevir
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'budget': budget,
      'inUseBudget': inUseBudget,
      'color': colorToHex(color),
      'lastUpdatedTime': lastUpdatedTime.toIso8601String(),
    };
  }

  // JSON formatından geri dönüştür
  // Factory constructor to create a Categories instance from JSON
  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      budget: json['budget'],
      inUseBudget: json['inUseBudget'],
      color: colorFromHex(json['color'].toString()), // Convert hex to Color
      lastUpdatedTime: DateTime.parse(json['lastUpdatedTime'])
    );
  }

  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2, 8)}'; // Get hex format without alpha
  }
  static Color colorFromHex(String hexColor) {
    return Color(int.parse(hexColor.replaceFirst('#', '0xff')));
  }

  int get getId => id;
  String get getName => name;
  String get getIcon => icon;
  double get getBudget => budget;
  double get getInUseBudget => inUseBudget;
  Color get getColor => color;
}
