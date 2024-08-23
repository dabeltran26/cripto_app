class UserGoogleModel {
  String uid;
  String userName;
  String email;

  UserGoogleModel({
    required this.uid,
    required this.userName,
    required this.email,
  });

  factory UserGoogleModel.fromMap(Map<String, dynamic> json) => UserGoogleModel(
        uid: json["uid"],
        userName: json["user_name"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "user_name": userName,
        "email": email,
      };
}
