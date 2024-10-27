import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackizer/entities/Categories.dart';
import 'package:trackizer/services/SubscriptionService.dart';

class CategoriesService {
  static const String _key = 'categories';

  // Tüm abonelikleri al
  Future<List<Categories>> getCategoriess() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
   print(jsonString);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Categories.fromJson(json)).toList();
  }

  Future<void> addCategories(Categories ctg) async {
    final CategoriesList = await getCategoriess();

    int newId = CategoriesList.isNotEmpty
        ? CategoriesList.map((s) => s.id).reduce((a, b) => a > b ? a : b) + 1
        : 1;

    final newCategory = Categories(
        id: newId,
        icon: ctg.icon,
        name: ctg.name,
        budget: ctg.budget,
        inUseBudget: ctg.inUseBudget,
        color: ctg.color,
        lastUpdatedTime: DateTime.now());

    CategoriesList.add(newCategory);
    await _saveCategoriess(CategoriesList);
  }

  // Aboneliği güncelle
  Future<void> updateCategories(Categories updatedCategories) async {
    final Categoriess = await getCategoriess();
    final index = Categoriess.indexWhere((s) => s.id == updatedCategories.id);
    if (index != -1) {
      Categoriess[index] = updatedCategories;
      await _saveCategoriess(Categoriess);
    }
  }

  Future<void> updateCategoriesList(List<Categories> updatedCategories) async {
    final categoriesList = await getCategoriess();

    for (var updatedCategory in updatedCategories) {
      final index = categoriesList.indexWhere((c) => c.id == updatedCategory.id);

      if (index != -1) {
        categoriesList[index] = updatedCategory; // Kategoriyi güncelle
      }
    }

    await _saveCategoriess(categoriesList);
  }

  // Aboneliği sil
  Future<void> removeCategories(int id) async {
    final Categoriess = await getCategoriess();
    Categoriess.removeWhere((s) => s.id == id);
    await _saveCategoriess(Categoriess);
  }

  // Listeyi kaydet
  Future<void> _saveCategoriess(List<Categories> Categoriess) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(Categoriess.map((s) => s.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }

  Future<void> updateMonthlyCategories() async {
    final subService = SubscriptionService();
    final listSubs = await subService.getSubscriptions();
    final listCategories = await getCategoriess();
    final monthId = DateTime.now().month;

    for(var cat in listCategories){
      cat.inUseBudget = 0;
    }

    for(var cat in listCategories){
      for(var sub in listSubs){

        if(cat.id == sub.categoryId && sub.startDate.month <= monthId && sub.endDate.month >= monthId){
          cat.inUseBudget += sub.price;
        }
      }
    }
    await updateCategoriesList(listCategories);
  }
}
