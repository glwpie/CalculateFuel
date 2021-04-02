// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'calculate_gas.g.dart';

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

class CalculateGas extends StatefulWidget {
  @override
  _CalculateGasState createState() => _CalculateGasState();
}

class _CalculateGasState extends State<CalculateGas> {
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
                      int intRaceTime = int.parse(formData.raceTime!);
                      double doubleFuelLap = double.parse(formData.fuelLap!);
                      int intStartingFuel = int.parse(formData.startingFuel!);

                      int intLapMin = _lapTimeMin(formData.lapTime!);
                      int intLapSec = _lapTimeSec(formData.lapTime!);
                      int intLapSeconds = _lapSeconds(intLapMin, intLapSec);

                      double doubleTotalLaps =
                          _totalLaps(intRaceTime, intLapSeconds);

                      int result = _fuelCalc(
                          doubleTotalLaps, doubleFuelLap, intStartingFuel);

                      _showDialog(result.toString());
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
