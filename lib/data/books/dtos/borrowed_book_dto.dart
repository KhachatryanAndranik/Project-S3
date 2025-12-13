import 'package:library_app/data.dart';

class BorrowedBookDto {
  const BorrowedBookDto({
    required this.user,
    required this.borrowedDate,
    required this.dueDate,
  });

  factory BorrowedBookDto.fromJson(Map<String, dynamic> json) {
    return BorrowedBookDto(
      user: UserDto.fromJson(json['user'] as Map<String, dynamic>),
      borrowedDate: DateTime.parse(json['borrowedDate'] as String),
      dueDate: DateTime.parse(json['dueDate'] as String),
    );
  }

  final UserDto user;
  final DateTime borrowedDate;
  final DateTime dueDate;

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'borrowedDate': borrowedDate.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
    };
  }

  BorrowedBookDto copyWith({
    UserDto? user,
    DateTime? borrowedDate,
    DateTime? dueDate,
  }) {
    return BorrowedBookDto(
      user: user ?? this.user,
      borrowedDate: borrowedDate ?? this.borrowedDate,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}
