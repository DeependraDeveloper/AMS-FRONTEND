import 'dart:convert';

class Leave {
  final String? id;
  final String? leaveType;
  final String? leaveReason;
  final String? leaveFrom;
  final String? leaveTo;
  final String? leaveStatus;
  final String? leaveAppliedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Leave({
    this.id,
    this.leaveType,
    this.leaveReason,
    this.leaveFrom,
    this.leaveTo,
    this.leaveStatus,
    this.leaveAppliedBy,
    this.createdAt,
    this.updatedAt,
  });

  Leave copyWith({
    String? id,
    String? leaveType,
    String? leaveReason,
    String? leaveFrom,
    String? leaveTo,
    String? leaveStatus,
    String? leaveAppliedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Leave(
        id: id ?? this.id,
        leaveType: leaveType ?? this.leaveType,
        leaveReason: leaveReason ?? this.leaveReason,
        leaveFrom: leaveFrom ?? this.leaveFrom,
        leaveTo: leaveTo ?? this.leaveTo,
        leaveStatus: leaveStatus ?? this.leaveStatus,
        leaveAppliedBy: leaveAppliedBy ?? this.leaveAppliedBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Leave.fromRawJson(String str) => Leave.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Leave.fromJson(Map<String, dynamic> json) => Leave(
        id: json["_id"],
        leaveType: json["leaveType"],
        leaveReason: json["leaveReason"],
        leaveFrom: json["leaveFrom"],
        leaveTo: json["leaveTo"],
        leaveStatus: json["leaveStatus"],
        leaveAppliedBy: json["leaveAppliedBy"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "leaveType": leaveType,
        "leaveReason": leaveReason,
        "leaveFrom": leaveFrom,
        "leaveTo": leaveTo,
        "leaveStatus": leaveStatus,
        "leaveAppliedBy": leaveAppliedBy,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
