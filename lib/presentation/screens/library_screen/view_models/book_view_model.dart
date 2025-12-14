import 'package:library_app/presentation/screens/library_screen/view_models.dart';

class BookViewModel {
  const BookViewModel({
    required this.id,
    required this.title,
    required this.authorName,
    this.coverImageUrl,
    this.borrowedInfo, 
  });

  final String id;
  final String title;
  final String authorName;
  final String? coverImageUrl;
  final BorrowedBookInfoViewModel? borrowedInfo;

  BookStatus get status =>
      borrowedInfo == null ? BookStatus.available : BookStatus.borrowed;
}

enum BookStatus { available, borrowed }
