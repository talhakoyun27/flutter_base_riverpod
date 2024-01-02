import 'dart:convert';

import 'package:flutter_base_riverpod/_library/helpers/network_manager/data/dto/pagination_dto.dart';


class ListBaseModel<T> {
  final bool status;
  final String message;
  final List<T> data;
  PaginationDto? pagination;

  ListBaseModel({
    required this.status,
    required this.message,
    required this.data,
    this.pagination,
  });

  factory ListBaseModel.fromMap(Map<String, dynamic> json, Function(Map<String, dynamic>)? mappingFunction) {
    return ListBaseModel<T>(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: mappingFunction != null ? List<T>.from(json['data'].map((x) => mappingFunction(x))) : [],
      pagination: json['pagination'] != null ? PaginationDto.fromMap(json['pagination']) : null,
    );
  }

  factory ListBaseModel.fromJson(String str, Function(Map<String, dynamic>)? mappingFunction) =>
      ListBaseModel.fromMap(json.decode(str), mappingFunction);
}
