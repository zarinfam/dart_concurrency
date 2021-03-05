import 'dart:convert';

import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;

import 'dto.dart';

void main() async {
  var handler = const shelf.Pipeline()
      // .addMiddleware(shelf.logRequests())
      .addHandler(_echoRequest);

  var server = await io.serve(handler, 'localhost', 8080);

  print('Serving at http://${server.address.host}:${server.port}');
}

shelf.Response _echoRequest(shelf.Request request) {
  fib(35);
  final user = User('saeed', 'saeed@zarin.me');
  return shelf.Response.ok(jsonEncode(user));
}