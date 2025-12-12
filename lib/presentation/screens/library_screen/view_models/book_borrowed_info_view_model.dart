import 'package:library_app/presentation/common.dart';

class BookBorrowedInfoViewModel {
  const BookBorrowedInfoViewModel({
    required this.user,
    required this.borrowedDate,
    required this.dueDate,
  });

  final UserViewModel user;
  final DateTime borrowedDate;
  final DateTime dueDate;
}
