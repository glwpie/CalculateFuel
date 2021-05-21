// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'calculate_gas.g.dart';

@JsonSerializable()
class FormData {
  TimeOfDay? lapTime;
  TimeOfDay? raceTime;
  double? fuelLap;
  double? startingFuel;

  FormData({
    this.startingFuel,
    this.lapTime,
    this.raceTime,
    this.fuelLap,
  });
}

class CalculateGas extends StatefulWidget {
  @override
  _CalculateGasState createState() => _CalculateGasState();
}

class _CalculateGasState extends State<CalculateGas> {
  FormData formData = FormData(
    lapTime: TimeOfDay(hour: 1, minute: 30),
    raceTime: TimeOfDay(hour: 00, minute: 40),
    startingFuel: 60,
    fuelLap: 4.1,
  );
  var textStrutStyle = new StrutStyle();
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
                  Text(
                    'Starting Fuel: ' + formData.startingFuel!.toString(),
                    strutStyle: textStrutStyle,
                  ),
                  Slider(
                    value: formData.startingFuel!,
                    min: 50,
                    max: 80,
                    divisions: 30,
                    label: formData.startingFuel!.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        formData.startingFuel = value;
                      });
                    },
                  ),
                  TextButton(
                      child: Text('Race Time: ' +
                          formData.raceTime!.hour.toString() +
                          ':' +
                          formData.raceTime!.minute.toString()),
                      onPressed: () async {
                        formData.raceTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(hour: 00, minute: 40),
                          initialEntryMode: TimePickerEntryMode.dial,
                          builder: (BuildContext context, Widget? child) {
                            return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: child!,
                            );
                          },
                        );
                      }),
                  TextButton(
                      child: Text('lap Time: ' +
                          formData.lapTime!.hour.toString() +
                          ':' +
                          formData.lapTime!.minute.toString()),
                      onPressed: () async {
                        formData.lapTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(hour: 1, minute: 30),
                          initialEntryMode: TimePickerEntryMode.dial,
                          builder: (BuildContext context, Widget? child) {
                            return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: child!,
                            );
                          },
                        );
                      }),
                  Text(
                    'Fuel Lap literes: ' + formData.fuelLap!.toString(),
                  ),
                  Slider(
                    value: formData.fuelLap!,
                    min: 2,
                    max: 17,
                    divisions: 150,
                    label: formData.fuelLap!.toString(),
                    onChanged: (value) {
                      setState(() {
                        formData.fuelLap = value;
                      });
                    },
                  ),
                  TextButton(
                    child: Text('Do Fancy Math'),
                    onPressed: () async {
                      double doubleFuelLap = formData.fuelLap!;

                      int intLapSeconds = _lapSeconds(formData.lapTime!);

                      double doubleTotalLaps =
                          _totalLaps(formData.raceTime!, intLapSeconds);

                      int result = _fuelCalc(doubleTotalLaps, doubleFuelLap,
                          formData.startingFuel!);
                      bool requiresMultiStop =
                          _checkMultiPit(result, formData.startingFuel!);
                      if (requiresMultiStop) {
                        _showDialog(_buildMultiStopString(result, formData.startingFuel!));
                      } else {
                        _showDialog(result.toString());
                      }
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

int _lapSeconds(TimeOfDay lapTime) {
  return (lapTime.hour * 60 + lapTime.minute);
}

double _totalLaps(TimeOfDay raceTime, int intLapSeconds) {
  return ((((raceTime.hour * 60) + raceTime.minute) * 60) / intLapSeconds);
}

int _fuelCalc(
    double doubleTotalLaps, double doubleFuelLap, double intStartingFuel) {
  return (((doubleTotalLaps + 2) * doubleFuelLap) - intStartingFuel + 1)
      .round();
}

bool _checkMultiPit(int fuelCalc, double intStartingFuel) {
  if (fuelCalc > intStartingFuel) {
    return true;
  } else {
    return false;
  }
}

String _buildMultiStopString(int remaingFuel, double startingFuel) {
  int pitCounter = 0;
  while (remaingFuel > startingFuel) {
    remaingFuel = remaingFuel - startingFuel.truncate();
    pitCounter++;
  }
  return "$pitCounter stop(s) $startingFuel L, last stop  $remaingFuel L";
}

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: _shrineColorScheme,
    toggleableActiveColor: shrinePink400,
    accentColor: shrineBrown900,
    primaryColor: shrinePink100,
    buttonColor: shrinePink100,
    scaffoldBackgroundColor: shrineBackgroundWhite,
    cardColor: shrineBackgroundWhite,
    textSelectionColor: shrinePink100,
    errorColor: shrineErrorRed,
    buttonTheme: const ButtonThemeData(
      colorScheme: _shrineColorScheme,
      textTheme: ButtonTextTheme.normal,
    ),
    primaryIconTheme: _customIconTheme(base.iconTheme),
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
    iconTheme: _customIconTheme(base.iconTheme),
  );
}

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: shrineBrown900);
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        caption: base.caption?.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: defaultLetterSpacing,
        ),
        button: base.button?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          letterSpacing: defaultLetterSpacing,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: shrineBrown900,
        bodyColor: shrineBrown900,
      );
}

const ColorScheme _shrineColorScheme = ColorScheme(
  primary: shrinePink400,
  primaryVariant: shrineBrown900,
  secondary: shrinePink50,
  secondaryVariant: shrineBrown900,
  surface: shrineSurfaceWhite,
  background: shrineBackgroundWhite,
  error: shrineErrorRed,
  onPrimary: shrineBrown900,
  onSecondary: shrineBrown900,
  onSurface: shrineBrown900,
  onBackground: shrineBrown900,
  onError: shrineSurfaceWhite,
  brightness: Brightness.light,
);

const Color shrinePink50 = Color(0xFFFEEAE6);
const Color shrinePink100 = Color(0xFFFEDBD0);
const Color shrinePink300 = Color(0xFFFBB8AC);
const Color shrinePink400 = Color(0xFFEAA4A4);

const Color shrineBrown900 = Color(0xFF442B2D);
const Color shrineBrown600 = Color(0xFF7D4F52);

const Color shrineErrorRed = Color(0xFFC5032B);

const Color shrineSurfaceWhite = Color(0xFFFFFBFA);
const Color shrineBackgroundWhite = Colors.white;

const defaultLetterSpacing = 0.03;
