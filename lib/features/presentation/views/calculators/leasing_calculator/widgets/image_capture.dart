import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

class ImageSelectionContainer extends StatefulWidget {
  final String title;
  final String title2;
  final String description;
  final double width;

  ImageSelectionContainer({required this.title, required this.title2, required this.description, required this.width});

  @override
  _ImageSelectionContainerState createState() => _ImageSelectionContainerState();
}

class _ImageSelectionContainerState extends State<ImageSelectionContainer> {
  File? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      final File imageFile = File(pickedImage.path);
      setState(() {
        _selectedImage = imageFile;
      });
    }
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  Widget _buildImageWidget() {
    if (_selectedImage != null) {
      return Stack(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Image.memory(
              _selectedImage!.readAsBytesSync(),
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: GestureDetector(
              onTap: _removeImage,
              child: Container(
                decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors(context).whiteColor,
                ),
                child:  Icon(Icons.close, color: colors(context).negativeColor),
              ),
            ),
          ),
        ],
      );
    } else {
      return const Icon(Icons.camera_alt, size: 50);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Select Image'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.camera),
                      title: const Text('Take a Picture'),
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.camera);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.image),
                      title: const Text('Choose from Gallery'),
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.gallery);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: DottedBorder(
        color: _selectedImage == null ?
        colors(context).greyColor!
            : Colors.transparent,
        dashPattern: const [6, 6],
        strokeCap: StrokeCap.round,
        radius: const Radius.circular(15),
        borderType: BorderType.RRect,
        child: Container(
          width: widget.width,
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: colors(context).secondaryColor400,
            border: Border.all(style: BorderStyle.none),
          ),
          //color: Colors.grey[300],
          child: _selectedImage == null? Padding(
            padding: const EdgeInsets.only(left: 8,right: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(textAlign: TextAlign.center,widget.title,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: colors(context).blackColor,),),
                // SvgPicture.asset(
                //   AppImages.icUpload,
                // ),
                Icon(Icons.file_upload_outlined,color: colors(context).greyColor,size: 30,),
                Text(textAlign: TextAlign.center,widget.title2,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: colors(context).blackColor,),),
                Text(textAlign: TextAlign.center,widget.description,style: TextStyle(fontSize: 10,fontWeight: FontWeight.w400,color: colors(context).greyColor200,),),
              ],
            ),
          ): _buildImageWidget(),
        ),
      ),
    );
  }
}