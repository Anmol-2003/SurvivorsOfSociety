import 'package:flutter/material.dart';
import 'familyinfo.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _countryCode = TextEditingController();
  var _phone = "";

  @override
  void initState() {
    _countryCode.text = "+91";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registration", style: TextStyle(fontSize: 28),),),
      body: Container(
        //alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child:   SingleChildScrollView(
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20), 
                child: Text("Phone Verification", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
              ),
              const SizedBox(height: 5,),
              const Text("We need to verify your phone number.", 
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,),
              const SizedBox(height: 30,),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: _countryCode,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                          onChanged: (value) {
                            _phone = value;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone",
                      ),
                    ))
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => addFamilyInfo(phone: _phone, countryCode: _countryCode.text)));
                }, 
                style: ElevatedButton.styleFrom(  
                  backgroundColor: Colors.deepPurple[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                child: const Text("Next", style: TextStyle(fontSize: 16),),
                )
            ],
          ),
        )
      ),
    );
  }
}


