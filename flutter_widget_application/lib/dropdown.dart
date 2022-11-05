import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> listCountry = ['Indonesia', 'Malaysia', 'Singapore'];
  String? _selectedCountry;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("DropdownButton"),
          centerTitle: true,
        ),
        body: Center(
          child: DropdownButton(
            hint: Text("Select your country"),
            items: listCountry.map(
              (String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
            value: _selectedCountry,
            onChanged: (String? value) {
              setState(() {
                _selectedCountry = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
