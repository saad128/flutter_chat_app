import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn);

  final void Function(File pickedImage) imagePickFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;

  void _pickImage() async {
    final _picker = ImagePicker();
    PickedFile image = await _picker.getImage(source: ImageSource.camera);
    setState(() {
      _pickedImage = File(image.path);
    });
    widget.imagePickFn(File(image.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
          radius: 40.0,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text(
            'Add Image',
          ),
        ),
      ],
    );
  }
}
