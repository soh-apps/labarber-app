// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImagePickerWidget extends StatefulWidget {
  final String? imageUrl;
  final Function(File?) onImageSelected;

  const ImagePickerWidget({super.key, this.imageUrl, required this.onImageSelected});

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey[200],
            backgroundImage: _image != null
                ? FileImage(_image!)
                : (widget.imageUrl != null
                    ? CachedNetworkImageProvider(widget.imageUrl!)
                    : const AssetImage('assets/images/avatar.png')) as ImageProvider,
            child: _image == null && widget.imageUrl == null
                ? Icon(Icons.camera_alt, size: 40, color: Colors.grey[800])
                : null,
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _pickImage,
          child: const Text('Carregar Imagem'),
        ),
      ],
    );
  }
}
