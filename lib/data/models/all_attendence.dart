import 'dart:convert';
import 'package:amsystm/data/models/attendence.dart';

class AllAttendence {
  final int? month;
  final int? year;
  final List<Attendence>? attendences;

  const AllAttendence({
    this.month,
    this.year,
    this.attendences,
  });

  AllAttendence copyWith({
    int? month,
    int? year,
    List<Attendence>? attendences,
  }) =>
      AllAttendence(
        month: month ?? this.month,
        year: year ?? this.year,
        attendences: attendences ?? this.attendences,
      );

  factory AllAttendence.fromRawJson(String str) =>
      AllAttendence.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllAttendence.fromJson(Map<String, dynamic> json) => AllAttendence(
        month: json["month"],
        year: json["year"],
        attendences: json["attendences"] == null
            ? []
            : List<Attendence>.from(
                json["attendences"]!.map((x) => Attendence.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "month": month,
        "year": year,
        "attendences": attendences == null
            ? []
            : List<dynamic>.from(attendences!.map((x) => x.toJson())),
      };
}
