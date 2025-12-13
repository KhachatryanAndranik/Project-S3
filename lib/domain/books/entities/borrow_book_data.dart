class BorrowBookData {
  BorrowBookData({
    required this.bookId,
    required this.userId,
    required this.borrowedDate,
    required this.dueDate,
  });

  final String bookId;
  final int userId;
  final DateTime? borrowedDate;
  final DateTime? dueDate;

  factory BorrowBookData.fromJson(Map<String, dynamic> json) {
    return BorrowBookData(
      bookId: json['bookId'] as String,
      userId: json['userId'] as int,
      borrowedDate: json['borrowedDate'] != null ? DateTime.parse(json['borrowedDate'] as String) : null,
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookId': bookId,
      'userId': userId,
      'borrowedDate': borrowedDate?.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
    };
  }
}