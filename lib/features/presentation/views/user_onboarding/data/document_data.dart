// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

class DocumentData {
  File? fileImage;
  String? memoryImage;
  String title;
  DocumentData({
    this.fileImage,
    this.memoryImage,
    required this.title,
  });
}
