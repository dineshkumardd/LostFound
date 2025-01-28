import 'package:flutter/material.dart';

class GlobalProvider with ChangeNotifier {
  List<Map<String, dynamic>> _formData = [];

  List<String> _items = [];

  List<Map<String, dynamic>> get formData => _formData;
  List<String> get items => _items;

  void addFormData(Map<String, dynamic> newData) {
    _formData.add(newData);
    notifyListeners();
  }

  void addItem(String item) {
    _items.add(item);
    notifyListeners(); // Notify listeners when a new item is added
  }
}
