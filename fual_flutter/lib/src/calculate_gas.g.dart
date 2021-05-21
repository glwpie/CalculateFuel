// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculate_gas.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormData _$FormDataFromJson(Map<String, dynamic> json) {
  return FormData(
    startingFuel: json['startingFuel'] as double?,
    lapTime: json['laptime'] as TimeOfDay?,
    raceTime: json['raceTime'] as TimeOfDay?,
    fuelLap: json['fuelLap'] as double?,
  );
}

Map<String, dynamic> _$FormDataToJson(FormData instance) => <String, dynamic>{
      'startingFuel': instance.startingFuel,
      'lapTime': instance.lapTime,
      'raceTime': instance.raceTime,
      'fuelLap': instance.fuelLap,
    };
                  // Row(
                  //   children: <Widget>[
                  //     Expanded(
                  //       child: Slider(
                  //         value: formData.startingFuel!,
                  //         min: 50,
                  //         max: 100,
                  //         divisions: 50,
                  //         label: formData.startingFuel!.round().toString(),
                  //         onChanged: (value) {
                  //           setState(() {
                  //             formData.startingFuel = value;
                  //           });
                  //         },
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Slider(
                  //         value: formData.startingFuel!,
                  //         min: 50,
                  //         max: 100,
                  //         divisions: 50,
                  //         label: formData.startingFuel!.round().toString(),
                  //         onChanged: (value) {
                  //           setState(() {
                  //             formData.startingFuel = value;
                  //           });
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // ToggleButtons(
                  //   color: Colors.black.withOpacity(0.60),
                  //   selectedColor: Color(0xFF6200EE),
                  //   selectedBorderColor: Color(0xFF6200EE),
                  //   fillColor: Color(0xFF6200EE).withOpacity(0.08),
                  //   splashColor: Color(0xFF6200EE).withOpacity(0.12),
                  //   hoverColor: Color(0xFF6200EE).withOpacity(0.04),
                  //   borderRadius: BorderRadius.circular(4.0),
                  //   constraints: BoxConstraints(minHeight: 36.0),
                  //   isSelected: fualLapToggle,
                  //   onPressed: (index) {
                  //     // Respond to button selection
                  //     setState(() {
                  //       fualLapToggle[index] = !fualLapToggle[index];
                  //       if (index == 0) {
                  //         formData.fuelLap = formData.fuelLap! + 1.0;
                  //       }
                  //       if (index == 1) {
                  //         formData.fuelLap = formData.fuelLap! + 0.1;
                  //       }
                  //       if (index == 2) {
                  //         formData.fuelLap = formData.fuelLap! - 1.0;
                  //       }
                  //       if (index == 3) {
                  //         formData.fuelLap = formData.fuelLap! - 0.1;
                  //       }
                  //     });
                  //   },
                  //   children: [
                  //     Padding(
                  //       padding: EdgeInsets.symmetric(horizontal: 16.0),
                  //       child: Text('increment Liter'),
                  //     ),
                  //     Padding(
                  //       padding: EdgeInsets.symmetric(horizontal: 16.0),
                  //       child: Text('increment .1 liter'),
                  //     ),
                  //     Padding(
                  //       padding: EdgeInsets.symmetric(horizontal: 16.0),
                  //       child: Text('decrement Liter'),
                  //     ),
                  //     Padding(
                  //       padding: EdgeInsets.symmetric(horizontal: 16.0),
                  //       child: Text('decrement .1 liter'),
                  //     ),
                  //   ],
                  // ),