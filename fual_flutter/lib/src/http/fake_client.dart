// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {
  MockClient() {
    when(post(Uri.parse('https://example.com/signin'), body: anyNamed('body')))
        .thenAnswer((answering) {
      var body = answering.namedArguments[Symbol('body')];

      if (body != null && body is String) {
        var decodedJson = json.decode(body);

        if (decodedJson['startingFuel'] == '60' &&
            decodedJson['laptime'] == '1:10' &&
            decodedJson['raceTime'] == '40' &&
            decodedJson['fuelLap'] == '4.1') {
          return Future.value(http.Response('', 200));
        }
      }

      return Future.value(http.Response('', 401));
    });

    when(post(Uri.parse('https://example.com/signout')))
        .thenAnswer((_) => Future.value(http.Response('', 401)));
  }
}
