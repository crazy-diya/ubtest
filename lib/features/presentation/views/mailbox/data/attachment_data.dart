// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';


class AttachmentData {
  final String fileName;
  final String filePath;
  final String base64File;
  final String extension;
  final File file;
  AttachmentData({
    required this.fileName,
    required this.filePath,
    required this.base64File,
    required this.extension,
    required this.file,
  });

}
