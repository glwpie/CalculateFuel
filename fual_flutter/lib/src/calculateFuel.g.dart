// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculateFuel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormData _$FormDataFromJson(Map<String, dynamic> json) {
  return FormData(
    startingFuel: json['startingFuel'] as String?,
    lapTime: json['laptime'] as String?,
    raceTime: json['raceTime'] as String?,
    fuelLap: json['fuelLap'] as String?,
  );
}

Map<String, dynamic> _$FormDataToJson(FormData instance) => <String, dynamic>{
      'startingFuel': instance.startingFuel,
      'lapTime': instance.lapTime,
      'raceTime': instance.raceTime,
      'fuelLap': instance.fuelLap,
    };
