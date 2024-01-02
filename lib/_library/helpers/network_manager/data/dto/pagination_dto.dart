import 'dart:convert';

class PaginationDto {
  final int total;
  final int count;
  final int perPage;
  final int currentPage;
  final int totalPages;

  PaginationDto({
    required this.total,
    required this.count,
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'total': total});
    result.addAll({'count': count});
    result.addAll({'per_page': perPage});
    result.addAll({'current_page': currentPage});
    result.addAll({'total_pages': totalPages});

    return result;
  }

  factory PaginationDto.fromMap(Map<String, dynamic> map) {
    return PaginationDto(
      total: map['total']?.toInt() ?? 0,
      count: map['count']?.toInt() ?? 0,
      perPage: map['per_page']?.toInt() ?? 0,
      currentPage: map['current_page']?.toInt() ?? 0,
      totalPages: map['total_pages']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaginationDto.fromJson(String source) => PaginationDto.fromMap(json.decode(source));
}
