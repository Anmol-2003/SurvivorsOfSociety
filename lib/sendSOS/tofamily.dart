import 'package:flutter/material.dart';

class SendSOS extends StatefulWidget {
  final double lat;
  final double long;
  final String mobileNumber;
  final Map<String, dynamic> data;

  const SendSOS({super.key, required this.lat, required this.long, required this.mobileNumber, required this.data});

  @override
  State<SendSOS> createState() => _SendSOSState();
}

class _SendSOSState extends State<SendSOS> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Testing...", style: TextStyle(fontSize: 28),),),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: Column(
            children: [
              Text("Extracted phone number : ${widget.mobileNumber}\n", style: const TextStyle(fontSize: 22),),
              Text("Extracted database : \n", style: const TextStyle(fontSize: 22),),
              Text("${widget.data}", )
            ],
          ),
        ),
      ),
    );
  }
}


