import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Diary with ChangeNotifier {
  final String? id;
  final List<XFile>? photos;
  final String? comments;
  final DateTime? date;
  final String? area;
  final String? category;
  final List<String>? tags;
  final String? event;
  final bool? isPhotoGalleryIncluded;

  Diary({
    this.id,
    this.photos,
    this.comments,
    this.date,
    this.area,
    this.category,
    this.tags,
    this.event,
    this.isPhotoGalleryIncluded,
  });
}
