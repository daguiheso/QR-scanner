import 'dart:convert';

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));
String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
  int? id;
  String? type;
  String value;

  ScanModel({
    this.id,
    this.type,
    required this.value,
  }) {
    type = value.contains('http') ? 'http' : 'geo';
  }

  ScanModel.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    type = json['type'],
    value = json['value'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'value': value,
  };
}
