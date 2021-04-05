import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_fav_places/providers/great_places.dart';
import 'package:my_fav_places/widgets/image_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static String routeName = "/addPlace";
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  late TextEditingController _titleTxtController;
  String? _titleErrorText;
  // final Map<String, dynamic> _placeDetails = {};
  File? _pickedImage;

  // ignore: use_setters_to_change_properties
  void _selectImage(File? pickedImage) {
    _pickedImage = pickedImage;
  }

  bool _savePlace() {
    if (_titleTxtController.text.isEmpty || _pickedImage == null) {
      if (_titleTxtController.text.isEmpty) {
        setState(() {
          _titleErrorText = "Required Field";
        });
      }
      return false;
    }
    _titleErrorText = null;
    // ignore: unnecessary_statements
    Provider.of<GreatPlaces>(context, listen: false).addPlace(
        _titleTxtController.text, _pickedImage!); //doing null check above
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Place added")));
    Navigator.pop(context);
    return true;
  }

  @override
  void initState() {
    _titleTxtController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a New Place"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Place Name", errorText: _titleErrorText),
                    controller: _titleTxtController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ImageInput(
                    onSelectImage: _selectImage,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Pick Image",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              ),
            ),
          )),
          ElevatedButton.icon(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                ),
                backgroundColor: MaterialStateColor.resolveWith(
                    (states) => Theme.of(context).accentColor),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            icon: const Icon(Icons.place),
            onPressed: _savePlace,
            label: const Text("Add Place"),
          )
        ],
      ),
    );
  }
}
