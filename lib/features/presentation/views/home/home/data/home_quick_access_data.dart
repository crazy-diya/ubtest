// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class HomeQuickAccessData {
  final String id;
  final String title;
  final IconData? icon;
  final String? imageIcon;
  final VoidCallback onTap;


  HomeQuickAccessData({
    required this.id,
    required this.title,
     this.icon,
     this.imageIcon, 
    required this.onTap
  });

}
