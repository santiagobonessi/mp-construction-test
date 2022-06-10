import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './diary.dart';

class Diaries with ChangeNotifier {
  Diaries(this._items);

  List<Diary> _items = [];

  List<Diary> get items {
    return [..._items];
  }

  Future<void> createDiary(Diary newDiary) async {
    final url = Uri.parse('https://reqres.in/');
    try {
      final response = await http.post(
        url,
        body: json.encode(newDiary),
      );
      if (response.statusCode >= 400) {
        // SUCCESSFUL CREATION, ADD TO ITEMS LIST AND NOTIFY LISTENERS
        _items.add(newDiary);
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }
}
