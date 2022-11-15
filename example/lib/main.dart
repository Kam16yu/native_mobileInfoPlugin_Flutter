import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mobile_info/mobile_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _mobileInfoPlugin = MobileInfo();
  Map<String, String> _deviceSpecifications = {};
  List<String> _acquiredSpecs = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    Map<String, String> deviceSpecifications;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      deviceSpecifications = await _mobileInfoPlugin.getSpecifications() ?? {};
    } on PlatformException {
      deviceSpecifications = {};
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      _deviceSpecifications = deviceSpecifications;
      _acquiredSpecs = deviceSpecifications.keys.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Device specifications'),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: _deviceSpecifications.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.greenAccent,
                shadowColor: Colors.grey,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      '${_acquiredSpecs[index]}:',
                      style: const TextStyle(fontSize: 18.0),
                    )),
                    Expanded(
                        child: Text(
                      _deviceSpecifications[_acquiredSpecs[index]] ?? 'Empty',
                      style: const TextStyle(fontSize: 18.0),
                    ))
                  ],
                ),
              );
            },
          ),
        ),
        floatingActionButton: IconButton(
            onPressed: () => initPlatformState(),
            icon: const Icon(Icons.search),
            splashColor: Colors.greenAccent),
      ),
    );
  }
}
