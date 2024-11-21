// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class QuickAccessData {
  final String id;
  final String title;
  final IconData? icon;
  final String? imageIcon;


  QuickAccessData( {
    this.imageIcon,
    required this.id,
    required this.title,
    this.icon,
  });

}
