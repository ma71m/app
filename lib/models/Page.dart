import 'package:flutter/material.dart';

class PageModel {
  final Widget widget;
  final Color? color;
  final String? title;
  final String? body;
  final String? imageAssetPath;

  PageModel({
    required this.widget,
    this.color,
    this.title,
    this.body,
    this.imageAssetPath,
  });
}
