import 'dart:io';

import 'dto.dart';

void main() async {
  var server = await HttpServer.bind(
    InternetAddress.loopbackIPv4,
    4040,
  );

  print('Listening on localhost:${server.port}');

  server.listen((request) {
    fib(35);
    request.response.write('Hello Dart!');
    request.response.close();
  });
}
