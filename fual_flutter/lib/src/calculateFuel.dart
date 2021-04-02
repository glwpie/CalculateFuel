// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
//import 'http/mock_client.dart';
part 'calculateFuel.g.dart';

//final http.Client httpClient = MockClient();

//BaseClient createHttpClient() => BrowserClient();

@JsonSerializable()
class FormData {
  String? startingFuel = '60';
  String? lapTime = '1:30';
  String? lapMin = '1';
  String? lapSec = '30';
  String? raceTime = '40';
  String? fuelLap = '4.1';

  FormData({
    this.startingFuel = '60',
    this.lapTime = '1:30',
    this.raceTime = '40',
    this.fuelLap = '4.1',
    this.lapSec = '30',
    this.lapMin = '1',
  });

  factory FormData.fromJson(Map<String, dynamic> json) =>
      _$FormDataFromJson(json);

  Map<String, dynamic> toJson() => _$FormDataToJson(this);
}

class CalculateFuel extends StatefulWidget {
//  final HttpClient? httpClient;

  // CalculateFuel({
  //   //this.httpClient,
  // });

  @override
  _CalculateFuelState createState() => _CalculateFuelState();
}

class _CalculateFuelState extends State<CalculateFuel> {
  FormData formData = FormData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caluclate Fuel'),
      ),
      body: Form(
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                ...[
                  TextFormField(
                    initialValue: '60',
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      labelText: 'Starting Fuel',
                    ),
                    onChanged: (value) {
                      formData.startingFuel = value;
                    },
                    onSaved: (value) {
                      formData.startingFuel = value;
                    },
                  ),
                  // TextFormField(
                  //   initialValue: '1:30',
                  //   decoration: InputDecoration(
                  //     filled: true,
                  //     labelText: 'Lap Time',
                  //   ),
                  //   obscureText: false,
                  //   onChanged: (value) {
                  //     formData.lapTime = value;
                  //   },
                  //   onSaved: (value) {
                  //     formData.lapTime = value;
                  //   },
                  // ),
                  TextFormField(
                    initialValue: '1',
                    decoration: InputDecoration(
                      filled: true,
                      labelText: 'Lap Time Min',
                    ),
                    obscureText: false,
                    onChanged: (value) {
                      formData.lapMin = value;
                    },
                    onSaved: (value) {
                      formData.lapMin = value;
                    },
                  ),
                  TextFormField(
                    initialValue: '30',
                    decoration: InputDecoration(
                      filled: true,
                      labelText: 'Lap Time sec',
                    ),
                    obscureText: false,
                    onChanged: (value) {
                      formData.lapSec = value;
                    },
                    onSaved: (value) {
                      formData.lapSec = value;
                    },
                  ),
                  TextFormField(
                    initialValue: '40',
                    decoration: InputDecoration(
                      filled: true,
                      labelText: 'Race Time',
                    ),
                    obscureText: false,
                    onChanged: (value) {
                      formData.raceTime = value;
                    },
                    onSaved: (value) {
                      formData.raceTime = value;
                    },
                  ),
                  TextFormField(
                    initialValue: '4.1',
                    decoration: InputDecoration(
                      filled: true,
                      labelText: 'Fuel Lap',
                    ),
                    obscureText: false,
                    onChanged: (value) {
                      formData.fuelLap = value;
                    },
                    onSaved: (value) {
                      formData.fuelLap = value;
                    },
                  ),
                  TextButton(
                    child: Text('Do Maths'),
                    onPressed: () async {
                      var response =
                          await http.post(Uri.parse('http://localhost:4049'),
                              headers: {
                                'content-type': 'application/json',
                                'Access-Control-Allow-Origin': '*',
                              },
                              body: (jsonEncode(formData)));

                      print(response.body.isEmpty);

                      print(response.body.toString());
                      if (response.statusCode == 200) {
                        _showDialog(response.body.toString());
                      } else if (response.statusCode == 401) {
                        _showDialog('Unable to sign in.');
                      } else {
                        _showDialog('Something went wrong. Please try again.');
                      }

                      // int intRaceTime = int.parse(formData.raceTime!);
                      // double doubleFuelLap = double.parse(formData.fuelLap!);
                      // int intStartingFuel = int.parse(formData.startingFuel!);

                      // //int intLapMin = int.parse(formData.lapTime!.split(':')[0]);
                      // //int intLapSec = nt.parse(formData.lapTime!.split(':')[1]);

                      // int intLapMin = _lapTimeMin(formData.lapTime!);
                      // int intLapSec = _lapTimeSec(formData.lapTime!);
                      // int intLapSeconds = _lapSeconds(intLapMin, intLapSec);

                      // double doubleTotalLaps =
                      //     _totalLaps(intRaceTime, intLapSeconds);

                      // int result = _fuelCalc(
                      //     doubleTotalLaps, doubleFuelLap, intStartingFuel);

                      //_showDialog(result.toString());
                    },
                  ),
                ].expand(
                  (widget) => [
                    widget,
                    SizedBox(
                      height: 24,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

int _lapTimeMin(String lapTime) {
  return int.parse(lapTime.split(':')[0]);
}

int _lapTimeSec(String lapTime) {
  return int.parse(lapTime.split(':')[1]);
}

int _lapSeconds(int intLapMin, int intLapSec) {
  return (intLapMin * 60 + intLapSec);
}

double _totalLaps(int intRaceTime, int intLapSeconds) {
  return ((intRaceTime * 60) / intLapSeconds);
}

int _fuelCalc(
    double doubleTotalLaps, double doubleFuelLap, int intStartingFuel) {
  return (((doubleTotalLaps + 2) * doubleFuelLap) - intStartingFuel + 1)
      .round();
}
