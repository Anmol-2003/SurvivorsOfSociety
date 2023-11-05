import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'familylocation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
//import 'sendSOS/tofamily.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //final storage = FirebaseStorage.instance.ref();

  //variables ------------
  String imgUrl = "";
  Reference ref = FirebaseStorage.instance.ref();

  double latitude = 0;
  double longitude = 0;
  //String _mobileNumber = '';
  FirebaseAuth user = FirebaseAuth.instance;
  Map<String, dynamic> data = {};
  //------------

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
      print("Lat : ${latitude}, Long : ${longitude}");
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 120,
                        width: 150,
                        child: TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            side: MaterialStateProperty.all(const BorderSide(
                                color: Colors.grey, width: 0.5)),
                          ),
                          child: const Column(children: [
                            Icon(Icons.camera_alt_outlined,
                                size: 50,
                                color: Color.fromARGB(255, 133, 140, 233)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Image verification",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            )
                          ]),
                          onPressed: () async {
                            ImagePicker imgPicker = ImagePicker();
                            XFile? file = await imgPicker.pickImage(
                                source: ImageSource.camera);
                            //String uniqueFilename = DateTime.now().millisecondsSinceEpoch.toString();

                            Reference upload = ref.child('images');
                            try {
                              await upload.putFile(File(file!.path));
                              imgUrl = await upload.getDownloadURL();
                            } catch (error) {}
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        height: 120,
                        width: 150,
                        child: TextButton(
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(const BorderSide(
                                color: Colors.grey, width: 0.5)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                          ),
                          child: const Column(children: [
                            Icon(
                              Icons.family_restroom_rounded,
                              size: 50,
                              color: Color.fromARGB(255, 133, 140, 233),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Family Location",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            )
                          ]),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapScreen(
                                        lat: latitude, long: longitude)));
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 390,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    onPressed: _determinePosition,
                    child: const Text(
                      "SOS",
                      style: TextStyle(color: Colors.white, fontSize: 33),
                    ),
                  ),
                ]),
          ),
        ));
  }
}
