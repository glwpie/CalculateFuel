// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.


import 'package:flutter/material.dart';
//import 'package:http/browser_client.dart';
//import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
//import 'dart:html';

import 'src/http/mock_client.dart';
import 'src/calculateFuel.dart';
import 'src/calculate_gas.dart';

// Set up a mock HTTP client.
final http.Client httpClient = MockClient();
//var httpClient = new HttpClient();

void main() {
  runApp(FormApp());
}

final demos = [

  Demo(
    name: 'Calculate Fuel with Web Request',
    route: '/calculateFuel',
    builder: (context) => CalculateFuel(
      //httpClient: httpClient,
    ),
  ),
  Demo(
    name: 'Calculate Gas Offline',
    route: '/calculate_gas',
    builder: (context) => CalculateGas(
      //httpClient: httpClient,
    ),
  ),
];

class FormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Samples',
      theme: ThemeData(primarySwatch: Colors.teal),
      routes: Map.fromEntries(demos.map((d) => MapEntry(d.route!, d.builder!))),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Samples'),
      ),
      body: ListView(
        children: [...demos.map((d) => DemoTile(d))],
      ),
    );
  }
}

class DemoTile extends StatelessWidget {
  final Demo demo;

  DemoTile(this.demo);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(demo.name!),
      onTap: () {
        Navigator.pushNamed(context, demo.route!);
      },
    );
  }
}

class Demo {
  final String? name;
  final String? route;
  final WidgetBuilder? builder;

  const Demo({this.name, this.route, this.builder});
}
