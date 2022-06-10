import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './diary.dart';

class Diaries with ChangeNotifier {
  Diaries();

  final List<Diary> _items = [];

  List<Diary> get items {
    return [..._items];
  }

  Future<void> createDiary(Diary newDiary) async {
    final url = Uri.parse('https://reqres.in/api/users');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'comments': newDiary.comments,
          'date': newDiary.date != null ? newDiary.date!.toIso8601String() : null,
          'area': newDiary.area,
          'category': newDiary.category,
          'tags': newDiary.tags,
          'event': newDiary.event
        }),
      );
      // if successful creation, add base64 images to some storage, add to items list and notify listeners
      if (response.statusCode < 400) {
        if (newDiary.photos != null && newDiary.photos!.isNotEmpty) {
          // Save images first
          for (var photo in newDiary.photos!) {
            try {
              File imagefile = File(photo.path);
              Uint8List imagebytes = await imagefile.readAsBytes();
              String base64string = base64.encode(imagebytes);
              final response = await http.post(
                url,
                body: json.encode({
                  'image': base64string,
                }),
              );
              print(response);
            } catch (error) {
              print('Error when try to upload photos to storage');
            }
          }
        }

        _items.add(newDiary);
        notifyListeners();
      }
    } catch (error) {
      throw error;
    }
  }
}
