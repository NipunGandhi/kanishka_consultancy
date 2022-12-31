import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kanishka_consultancy/screen/homepage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../controller.dart';
import '../services/location_service.dart';

class PhotoChooser extends StatefulWidget {
  const PhotoChooser({Key? key}) : super(key: key);
  static String name = '/PhotoChooser';

  @override
  State<PhotoChooser> createState() => _PhotoChooserState();
}

class _PhotoChooserState extends State<PhotoChooser> {
  File? _image;
  final MyController _instance = Get.find();

  Future getImage(source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      // final imageTemporary = File(image.path);
      final imagePermanent = await saveFilePermanently(image.path);
      setState(() {
        this._image = imagePermanent;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Future<File> saveFilePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File("${directory.path}/$name");

    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Photo"),
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: Text(
                "Mark Your Attendance",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 40),
            _image != null
                ? CircleAvatar(
                    radius: 100.0,
                    backgroundImage: Image.file(
                      _image!,
                    ).image,
                  )
                : const CircleAvatar(
                    radius: 100.0,
                    backgroundImage: NetworkImage(
                        'https://www.pngfind.com/pngs/m/110-1102775_download-empty-profile-hd-png-download.png'),
                    backgroundColor: Colors.transparent,
                  ),
            const SizedBox(height: 30),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                child: Row(
                  children: const [
                    Icon(Icons.camera),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Pick from Camera"),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () async {
                  if (_image != null) {
                    Position position = await determinePosition();
                    _instance.attendanceMarked = true;
                    _instance.data.position = position;
                    _instance.data.image = _image;
                    Get.defaultDialog(
                      title: "Data Captured are",
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 100.0,
                              backgroundImage: Image.file(
                                _image!,
                              ).image,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Latitude - ${position.latitude}"),
                          Text("Longitude - ${position.longitude}"),
                          Text("Time - ${position.timestamp}"),
                          Text("Altitude - ${position.altitude}"),
                        ],
                      ),
                    );
                    Future.delayed(const Duration(milliseconds: 1500), () {})
                        .then(
                      (value) => Navigator.pushReplacementNamed(
                        context,
                        HomePageScreen.name,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Add Photo First')));
                  }
                },
                child: Row(
                  children: const [
                    Icon(Icons.done),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Mark Attendance"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
