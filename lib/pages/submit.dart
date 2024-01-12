import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textFieldController = TextEditingController();
  String _submittedText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter TextField with Submit Button'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textFieldController,
              decoration: InputDecoration(
                labelText: 'Enter Text',
              ),
            ),
            SizedBox(height: 16.0),
            RaisedButton(
              onPressed: () {
                setState(() {
                  _submittedText = _textFieldController.text;
                });
              },
              child: Text('Submit'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Submitted Text: $_submittedText',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}

RaisedButton({required Null Function() onPressed, required Text child}) {
}