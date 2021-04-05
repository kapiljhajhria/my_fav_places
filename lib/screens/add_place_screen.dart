import 'package:flutter/material.dart';
import 'package:my_fav_places/widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static String routeName = "/addPlace";
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  late TextEditingController _titleTxtController;
  // final Map<String, dynamic> _placeDetails = {};

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
                    decoration: const InputDecoration(labelText: "Place Name"),
                    controller: _titleTxtController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ImageInput(),
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
            onPressed: () {},
            label: const Text("Add Place"),
          )
        ],
      ),
    );
  }
}
