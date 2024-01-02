import 'dart:convert';

class Profile {
  int id;
  String? name;
  String? surname;
  String? phone;
  String? email;
  String? birthday;
  String? location;
  String? photo;
  int? followedCount;
  int? followerCount;
  int? storyCount;
  bool hasProgram;

  List<String>? userMedal;

  Profile({
    required this.id,
    required this.name,
    required this.surname,
    required this.phone,
    required this.email,
    required this.location,
    required this.photo,
    this.hasProgram = false,
    this.birthday,
    this.followedCount,
    this.followerCount,
    this.storyCount,
    this.userMedal,
  });

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id']?.toInt() ?? 0,
      name: map['name'],
      surname: map['surname'],
      phone: map['phone'],
      email: map['email'],
      birthday: map['birthday'],
      location: map['location'],
      photo: map['photo'],
      followedCount: map['followedCount']?.toInt(),
      followerCount: map['followerCount']?.toInt(),
      storyCount: map['storyCount']?.toInt(),
      hasProgram: map['hasProgram'] ?? false,
      userMedal: List<String>.from(map['userMedal']),
    );
  }

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source));
}
