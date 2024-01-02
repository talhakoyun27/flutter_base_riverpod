import 'dart:convert';

class LogInArgument {
  final String email;
  final String password;

  LogInArgument({required this.email, required this.password});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});
    result.addAll({'password': password});

    return result;
  }

  String toJson() => json.encode(toMap());

  factory LogInArgument.fromMap(Map<String, dynamic> map) {
    return LogInArgument(
      email: map['email'],
      password: map['password'],
    );
  }

  factory LogInArgument.fromJson(String source) =>
      LogInArgument.fromMap(json.decode(source));
}
