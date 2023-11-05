import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:sih_sos/Authentication/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';

class addFamilyInfo extends StatefulWidget {

  static String verify = "";
  final String phone;
  final String countryCode;
  const addFamilyInfo(
      {super.key, required this.phone, required this.countryCode});

  @override
  State<addFamilyInfo> createState() => _addFamilyInfoState();
}

class _addFamilyInfoState extends State<addFamilyInfo> {

  String _guardianNumber_1 = "";
  String _guardianNumber_2 = "";
  String _guardianNumber_3 = "";

  // -----------Sending Data to the server ----------------------
  void registerUser(String userNumber, String number1, String number2, String number3) async {
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
    String loc = "${position.latitude} ${position.longitude}";
    var registerBody = {
      'user' : userNumber,
      'guardian1' : number1,
      'guardian2' : number2,
      'guardian3' : number3,
      'location' : loc,
    };


    var response = await http.post(Uri.parse('http://192.168.239.224:3000/register'),
      headers: {'Content-Type':"application/json"},
      body: jsonEncode(registerBody),
    );
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91$userNumber",
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        addFamilyInfo.verify = verificationId;
        Navigator.pushNamed(context, "otp");
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Additional Information",
          style: TextStyle(fontSize: 28),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "We require this information as in case of an emergency your family is notified.",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "Be assured that this information will be used for your own safety\nand will not be used to violate your privacy.",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              const Text(
                "Guardian 1",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 0.9, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: SizedBox(
                  width: double.infinity,
                  child: TextField(
                    onChanged: (value) {
                      _guardianNumber_1 = value;
                    },
                    textAlign: TextAlign.center,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              const Text(
                "Guardian 2",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 0.9, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: SizedBox(
                  width: double.infinity,
                  child: TextField(
                    onChanged: (value) {
                      _guardianNumber_2 = value;
                    },
                    textAlign: TextAlign.center,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              const Text(
                "Guardian 3",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 0.9, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: SizedBox(
                  width: double.infinity,
                  child: TextField(
                    onChanged: (value) {
                      _guardianNumber_3 = value;
                    },
                    textAlign: TextAlign.center,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () =>
                  registerUser(widget.phone ,_guardianNumber_1, _guardianNumber_2, _guardianNumber_3),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple[100],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Text("Send the code"),
              ),
            ]),
          )),
    );
  }
}
