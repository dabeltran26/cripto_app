import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  String email;
  @HiveField(1)
  String name;
  @HiveField(2)
  DateTime birthday;
  @HiveField(3)
  int age;
  @HiveField(4)
  String uid;

  UserModel({
    required this.email,
    required this.name,
    required this.birthday,
    required this.age,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'birthday': birthday.toIso8601String(),
      'age': age,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      name: map['name'],
      birthday: DateTime.parse(map['birthday']),
      age: map['age'],
      uid: map['uid'],
    );
  }
}
