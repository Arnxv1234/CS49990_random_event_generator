import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Event Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RandomEventScreen(),
    );
  }
}

class RandomEventScreen extends StatefulWidget {
  @override
  _RandomEventScreenState createState() => _RandomEventScreenState();
}

class _RandomEventScreenState extends State<RandomEventScreen> {
  String _randomActivity = '';
  bool _loading = false;

  Future<void> _getRandomActivity() async {
    setState(() {
      _loading = true;
    });

    final response = await http.get(Uri.parse('http://www.boredapi.com/api/activity?key=5881028'));

    setState(() {
      _loading = false;
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _randomActivity = responseData['activity'];
      } else {
        _randomActivity = 'Failed to fetch activity';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Event Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_loading)
              CircularProgressIndicator()
            else if (_randomActivity.isNotEmpty)
              Text(
                'Random Activity:',
                style: TextStyle(fontSize: 20),
              ),
            if (_randomActivity.isNotEmpty)
              SizedBox(height: 20),
            if (_randomActivity.isNotEmpty)
              Text(
                _randomActivity,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getRandomActivity,
              child: Text('Generate Random Activity'),
            ),
          ],
        ),
      ),
    );
  }
}





