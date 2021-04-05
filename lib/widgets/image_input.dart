import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import "package:images_picker/images_picker.dart";
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  const ImageInput({Key? key, required this.onSelectImage}) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final _picker = ImagePicker();
    late final PickedFile? pickedFile;
    try {
      pickedFile = await _picker.getImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 600,
      );
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Failed to pick Image")));
    }
    // List<Media>? res = await ImagesPicker.openCamera();
    // _storedImage = File.fromUri(Uri.parse(res![0].path!));
    if (pickedFile == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("No Image Selected")));
      return;
    }
    final File imageFIle = File.fromUri(Uri(path: pickedFile.path));
    _storedImage = imageFIle;
    setState(() {});
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final String fileName = path.basename(imageFIle.path);
    final File saveImage = await imageFIle.copy('${appDir.path}/$fileName');
    widget.onSelectImage(saveImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: _storedImage == null
              ? const Center(
                  child: Text(
                    "No Image Taken",
                    textAlign: TextAlign.center,
                  ),
                )
              : Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            icon: const Icon(Icons.camera),
            onPressed: () {
              _takePicture();
            },
            label: const Text("Take Picture"),
            style: ButtonStyle(
              textStyle: MaterialStateProperty.resolveWith(
                (states) => TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        )
      ],
    );
  }
}
