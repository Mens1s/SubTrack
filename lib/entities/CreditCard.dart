class CreditCard {
  final int id;
  final String cardName;
  final String cardHolderName;
  final String lastFourDigit;
  final String expDate;

  CreditCard({
    required this.id,
    required this.cardName,
    required this.cardHolderName,
    required this.lastFourDigit,
    required this.expDate,
  });

  // JSON formatına çevirme
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardName': cardName,
      'cardHolderName': cardHolderName,
      'lastFourDigit': lastFourDigit,
      'expDate': expDate,
    };
  }

  // JSON formatından geri dönüştürme
  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(
      id: json['id'],
      cardName: json['cardName'],
      cardHolderName: json['cardHolderName'],
      lastFourDigit: json['lastFourDigit'],
      expDate: json['expDate'],
    );
  }

  // Getter'lar
  int get getId => id;
  String get getCardName => cardName;
  String get getCardHolderName => cardHolderName;
  String get getLastFourDigit => lastFourDigit;
  String get getExpDate => expDate;
}
