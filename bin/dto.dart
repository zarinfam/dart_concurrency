import 'dart:isolate';

class User {
  final String name;
  final String email;

  User(this.name, this.email);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'email': email,
      };
}

int fib(int n) {
  if (n < 2) {
    return n;
  }
  return fib(n - 2) + fib(n - 1);
}

class IsolateData {
  final SendPort _port;
  final String _name;

  IsolateData(this._port, this._name);

  String get name => _name;

  SendPort get port => _port;
}