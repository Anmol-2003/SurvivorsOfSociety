import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Test extends StatelessWidget {
  Test({super.key});

  final TextEditingController _controller = TextEditingController();
  Future<http.Response> sendData(String data) async {
    final Uri uri = Uri.parse('http://localhost:3000/register');
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'testData ': data,
      }),
    );

    if (response.statusCode == 201) {
      //Navigator.push(context, MaterialPageRoute(builder: (context) => Registration(countryCode: widget.countryCode, phone: widget.phone)));
      return response;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to send data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter a string',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => sendData(_controller.text),
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            Text('Inputted string: ${_controller.text}'),
          ],
        ),
      ),
    );
  }
}
