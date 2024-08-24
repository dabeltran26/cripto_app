class UserModel {
  String email;
  String password;
  String name;
  DateTime birthday;
  int age;
  String uid;

  UserModel({
    required this.email,
    required this.password,
    required this.name,
    required this.birthday,
    required this.age,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'birthday': birthday.toIso8601String(),
      'age': age,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      password: map['password'],
      name: map['name'],
      birthday: DateTime.parse(map['birthday']),
      age: map['age'],
      uid: map['uid'],
    );
  }
}
