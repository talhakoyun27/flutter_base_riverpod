import 'dart:convert';

class User {
  final int id;
  final String name;
  final String tc;
  final String surname;
  final String phone;
  final String email;
  final String photo;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.tc,
    required this.surname,
    required this.phone,
    required this.email,
    required this.photo,
    required this.token,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      tc: map['tc'] ?? '',
      surname: map['surname'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      photo: map['photo'] ?? '',
      token: map['token'] ?? '',
    );
  }

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
