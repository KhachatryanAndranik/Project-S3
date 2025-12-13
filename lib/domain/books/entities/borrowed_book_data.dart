import 'package:library_app/data.dart';
import 'package:library_app/domain.dart';
import 'package:library_app/presentation/screens/library_screen/view_models.dart';

class BorrowedBookData {
  const BorrowedBookData({
    required this.user,
    required this.borrowedDate,
    required this.dueDate,
  });

  final User user;
  final DateTime borrowedDate;
  final DateTime dueDate;

  factory BorrowedBookData.fromDto(BorrowedBookDto dto) {
    return BorrowedBookData(
      user: User.fromDto(dto.user),
      borrowedDate: dto.borrowedDate,
      dueDate: dto.dueDate,
    );
  }

  BorrowedBookInfoViewModel toViewModel() {
    return BorrowedBookInfoViewModel(
      user: user.toViewModel(),
      borrowedDate: borrowedDate,
      dueDate: dueDate,
    );
  }
}
