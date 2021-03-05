import 'dart:io';
import 'dart:isolate';

import 'dto.dart';

Future main() async {
  var server = await HttpServer.bind(
    InternetAddress.loopbackIPv4,
    4040,
  );

  final cpuCores = 4;
  final isolatePorts = List<SendPort>(cpuCores);
  var roundRobin = -1;

  for (var i = 0; i < cpuCores; i++) {
    final receivePort = ReceivePort();
    await Isolate.spawn(echo, IsolateData(receivePort.sendPort, 'isolate $i'));
    isolatePorts[i] = await receivePort.first;
  }

  print('Listening on localhost:${server.port}');

  await for (HttpRequest request in server) {
    roundRobin = (roundRobin + 1) % cpuCores;
    final msg = await send(isolatePorts[roundRobin], 'req');
    request.response.write(msg);
    await request.response.close();
  }
}

Future send(SendPort port, msg) {
  final response = ReceivePort();
  port.send([msg, response.sendPort]);
  return response.first;
}

Future<void> echo(IsolateData isolateData) async {
  final port = ReceivePort();
  isolateData.port.send(port.sendPort);

  await for (var msg in port) {
    final request = msg[0];
    SendPort replyTo = msg[1];

    fib(35);

    replyTo.send('Hello Dart!');
  }
}
