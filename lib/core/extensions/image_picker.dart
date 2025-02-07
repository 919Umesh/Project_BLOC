import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function(File?) onImageSelected;

  const ImagePickerWidget({super.key, required this.onImageSelected});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      widget.onImageSelected(_imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => _buildImagePickerBottomSheet(context),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
          ),
        );
      },
      child: CircleAvatar(
        radius: 50.0,
        backgroundColor: Colors.grey.shade300,
        backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
        child: _imageFile == null
            ? const Icon(Icons.camera_alt, size: 40, color: Colors.white)
            : null,
      ),
    );
  }

  Widget _buildImagePickerBottomSheet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 20.0),
            Center(
              child: Container(
                height: 7.0,
                width: 50.0,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
            Container(height: 30),
            ListTile(
              title: const Text('From Gallery 🖼️'),
              onTap: () async {
                await _pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('From Camera 📷'),
              onTap: () async {
                await _pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
            Container(height: 20),
          ],
        ),
      ),
    );
  }
}