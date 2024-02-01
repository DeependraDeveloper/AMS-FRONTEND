import 'dart:convert';

class User {
  final String? name;
  final String? role;
  final String? email;
  final String? password;
  final int? phone;
  final String? address;
  final String? department;
  final String? designation;
  final String? organization;
  final String? id;
  final String? token;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const User({
    this.name,
    this.role,
    this.email,
    this.password,
    this.phone,
    this.address,
    this.department,
    this.designation,
    this.organization,
    this.id,
    this.token,
    this.createdAt,
    this.updatedAt,
  });

  User copyWith({
    String? name,
    String? role,
    String? email,
    String? password,
    int? phone,
    String? address,
    String? department,
    String? designation,
    String? organization,
    String? id,
    String? token,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      User(
        name: name ?? this.name,
        role: role ?? this.role,
        email: email ?? this.email,
        password: password ?? this.password,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        department: department ?? this.department,
        designation: designation ?? this.designation,
        organization: organization ?? this.organization,
        id: id ?? this.id,
        token: token ?? this.token,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        role: json["role"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        address: json["address"],
        department: json["department"],
        designation: json["designation"],
        organization: json["organization"],
        id: json["_id"],
        token: json["token"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "role": role,
        "email": email,
        "password": password,
        "phone": phone,
        "address": address,
        "department": department,
        "designation": designation,
        "organization": organization,
        "_id": id,
        "token": token,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
