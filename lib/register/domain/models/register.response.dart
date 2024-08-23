class SignUpResponse {
  String email;
  dynamic deleted;
  String uid;
  DateTime createdAt;
  String name;

  SignUpResponse({
    required this.email,
    required this.deleted,
    required this.uid,
    required this.createdAt,
    required this.name,
  });

  factory SignUpResponse.fromMap(Map<String, dynamic> json) => SignUpResponse(
    email: json["email"],
    deleted: json["deleted"],
    uid: json["uid"],
    createdAt: DateTime.parse(json["created_at"]),
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "email": email,
    "deleted": deleted,
    "uid": uid,
    "created_at": createdAt.toIso8601String(),
    "name": name,
  };
}
