import 'dart:convert';

class ItemBaseModel<T> {
  final bool status;
  final String message;
  final T data;

  ItemBaseModel({required this.status, required this.message, required this.data});

  factory ItemBaseModel.fromMap(Map<String, dynamic> json, Function(Map<String, dynamic>)? mappingFunction) {
    return ItemBaseModel<T>(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: mappingFunction != null ? mappingFunction(json['data']) : json['data'],
    );
  }
  factory ItemBaseModel.fromJson(String str, Function(Map<String, dynamic>)? mappingFunction) =>
      ItemBaseModel.fromMap(json.decode(str), mappingFunction);
}
