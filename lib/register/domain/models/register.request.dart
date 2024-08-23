class RegisterRequest {
  final String uid;
  final String name;
  final String email;

  RegisterRequest({
    required this.uid,
    required this.name,
    required this.email,
  });

  factory RegisterRequest.fromMap(Map<String, dynamic> json) => RegisterRequest(
    uid: json["uid"],
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toMap() => {
    "uid": uid,
    "name": name,
    "email": email,
  };
}