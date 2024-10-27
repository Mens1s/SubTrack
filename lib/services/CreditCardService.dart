import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackizer/entities/CreditCard.dart';

class CreditCardService {
  static const String _key = 'creditCards';

  // Tüm kredi kartlarını al
  Future<List<CreditCard>> getCreditCards() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => CreditCard.fromJson(json)).toList();
  }

  // Kredi kartı güncelle
  Future<void> addCreditCard(CreditCard creditCard) async {
    final creditCards = await getCreditCards();

    // Mevcut kredi kartlarından en yüksek ID'yi bul
    int newId = creditCards.isNotEmpty
        ? creditCards.map((c) => c.id).reduce((a, b) => a > b ? a : b) + 1
        : 1;

    // Yeni kredi kartı nesnesini oluştur
    final newCreditCard = CreditCard(
      id: newId,
      cardName: creditCard.cardName,
      cardHolderName: creditCard.cardHolderName,
      lastFourDigit: creditCard.lastFourDigit,
      expDate: creditCard.expDate,
    );

    creditCards.add(newCreditCard);
    await _saveCreditCards(creditCards);
  }

  // Kredi kartı sil
  Future<void> removeCreditCard(int id) async {
    final creditCards = await getCreditCards();
    creditCards.removeWhere((c) => c.id == id);
    await _saveCreditCards(creditCards);
  }

  // Kredi kartı listesini kaydet
  Future<void> _saveCreditCards(List<CreditCard> creditCards) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(creditCards.map((c) => c.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }
}
