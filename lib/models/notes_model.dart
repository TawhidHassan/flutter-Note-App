
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NotesModel {
  String id;
  String title;
  String createdAt;

  NotesModel({
    @required this.id,
    @required this.title,
    @required this.createdAt
  });
}