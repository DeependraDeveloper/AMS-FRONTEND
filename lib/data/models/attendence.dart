import 'dart:convert';

class Attendence {
  final String? id;
  final String? user;
  final String? status;
  final String? inTime;
  final String? outTime;
  final int? duration;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Attendence({
    this.id,
    this.user,
    this.status,
    this.inTime,
    this.outTime,
    this.duration,
    this.createdAt,
    this.updatedAt,
  });

  Attendence copyWith({
    String? id,
    String? user,
    String? status,
    String? inTime,
    String? outTime,
    int? duration,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Attendence(
        id: id ?? this.id,
        user: user ?? this.user,
        status: status ?? this.status,
        inTime: inTime ?? this.inTime,
        outTime: outTime ?? this.outTime,
        duration: duration ?? this.duration,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Attendence.fromRawJson(String str) =>
      Attendence.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attendence.fromJson(Map<String, dynamic> json) => Attendence(
        id: json["_id"],
        user: json["user"],
        status: json["status"],
        inTime: json["inTime"],
        outTime: json["outTime"],
        duration: json["duration"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "status": status,
        "inTime": inTime,
        "outTime": outTime,
        "duration": duration,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
