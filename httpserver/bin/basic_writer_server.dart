// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Server to basic_writer_client.dart.
// Receives JSON encoded data in a POST request and writes it to
// the file specified in the URI.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

part 'FuelFunctions.dart';


String _host = InternetAddress.loopbackIPv4.host;

Future main() async {
  var server = await HttpServer.bind(_host, 4049);
  print('Listening on http://${server.address.address}:${server.port}/');
  await for (var req in server) {
    addCorsHeaders(req.response);

    switch (req.method) {
      case 'POST':
        await handlePost(req);
        break;
      case 'OPTIONS':
        handleOptions(req);
        break;
      default:
        defaultHandler(req);
        break;
    }
  }
}

Future handlePost(HttpRequest req) async {
  final contentType = req.headers.contentType;
  final content = await utf8.decoder.bind(req).asBroadcastStream().join();
  if (contentType?.mimeType == 'application/json') {
    try {
      if (content != null && content is String) {
        Map decodedJson = json.decode(content);

        print(decodedJson['startingFuel']);
        print(decodedJson['lapTime']);
        print(decodedJson['raceTime']);
        print(decodedJson['fuelLap']);
        var result = calculateFuel(decodedJson);
        req.response
          ..statusCode = HttpStatus.ok
          ..write(result);
      }
    } catch (e) { req.response ..statusCode = HttpStatus.internalServerError
        ..write('Exception during file I/O: $e.');
    }
  } else {
    req.response
      ..statusCode = HttpStatus.methodNotAllowed
      ..write('Unsupported request: ${req.method}.');
  }
  await req.response.flush();
  await req.response.close();
}

void defaultHandler(HttpRequest request) {
  final response = request.response;
  response
    ..statusCode = HttpStatus.notFound
    ..write('Not found: ${request.method}, ${request.uri.path}')
    ..close();
}

void handleOptions(HttpRequest request) {
  final response = request.response;
  response
    ..statusCode = HttpStatus.noContent
    ..close();
}

void addCorsHeaders(HttpResponse response) {
  response.headers.add('Access-Control-Allow-Origin', '*');
  response.headers.add('Access-Control-Allow-Methods', '*');
  response.headers.add('Access-Control-Allow-Headers', '*');
}
