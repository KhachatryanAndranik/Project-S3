import 'package:library_app/presentation/common/view_models/user_view_model.dart';
import 'package:library_app/presentation/screens/library_screen/view_models.dart';

class BookViewModel {
  const BookViewModel({
    required this.id,
    required this.title,
    required this.authorName,
    this.borrowedInfo,
  });

  final String id;
  final String title;
  final String authorName;
  final BookBorrowedInfoViewModel? borrowedInfo;

  BookStatus get status =>
      borrowedInfo == null ? BookStatus.available : BookStatus.borrowed;
}

enum BookStatus { available, borrowed }

final booksMock = <BookViewModel>[
  BookViewModel(id: '1', title: '1984', authorName: 'George Orwell'),
  BookViewModel(
    id: '2',
    title: 'To Kill a Mockingbird',
    authorName: 'Harper Lee',
    borrowedInfo: BookBorrowedInfoViewModel(
      user: UserViewModel(
        id: 0,
        name: 'John Doe',
        surname: 'Smith',
        username: 'johndoe',
        email: 'johndoe@example.com',
      ),
      borrowedDate: DateTime(2024, 5, 1),
      dueDate: DateTime(2024, 5, 15),
    ),
  ),
  BookViewModel(
    id: '3',
    title: 'The Great Gatsby',
    authorName: 'F. Scott Fitzgerald',
  ),
  BookViewModel(
    id: '4',
    title: 'Pride and Prejudice',
    authorName: 'Jane Austen',
  ),
  BookViewModel(
    id: '5',
    title: 'Brave New World',
    authorName: 'Aldous Huxley',
    borrowedInfo: BookBorrowedInfoViewModel(
      user: UserViewModel(
        id: 1,
        name: 'Alice',
        surname: 'Johnson',
        username: 'alicej',
        email: 'alice@example.com',
      ),
      borrowedDate: DateTime(2024, 6, 10),
      dueDate: DateTime(2024, 6, 24),
    ),
  ),
  BookViewModel(id: '6', title: 'Moby-Dick', authorName: 'Herman Melville'),
  BookViewModel(
    id: '7',
    title: 'The Catcher in the Rye',
    authorName: 'J.D. Salinger',
    borrowedInfo: BookBorrowedInfoViewModel(
      user: UserViewModel(
        id: 2,
        name: 'Bob',
        surname: 'Williams',
        username: 'bobw',
        email: 'bob@example.com',
      ),
      borrowedDate: DateTime(2024, 7, 2),
      dueDate: DateTime(2024, 7, 16),
    ),
  ),
  BookViewModel(
    id: '8',
    title: 'Crime and Punishment',
    authorName: 'Fyodor Dostoevsky',
  ),
  BookViewModel(
    id: '9',
    title: 'The Hobbit',
    authorName: 'J.R.R. Tolkien',
    borrowedInfo: BookBorrowedInfoViewModel(
      user: UserViewModel(
        id: 3,
        name: 'Carol',
        surname: 'Baker',
        username: 'carolb',
        email: 'carol@example.com',
      ),
      borrowedDate: DateTime(2024, 8, 5),
      dueDate: DateTime(2024, 8, 19),
    ),
  ),
  BookViewModel(id: '10', title: 'The Alchemist', authorName: 'Paulo Coelho'),
  BookViewModel(id: '11', title: 'Sapiens', authorName: 'Yuval Noah Harari'),
  BookViewModel(
    id: '12',
    title: 'Dune',
    authorName: 'Frank Herbert',
    borrowedInfo: BookBorrowedInfoViewModel(
      user: UserViewModel(
        id: 4,
        name: 'David',
        surname: 'Nguyen',
        username: 'davidn',
        email: 'david@example.com',
      ),
      borrowedDate: DateTime(2024, 9, 1),
      dueDate: DateTime(2024, 9, 15),
    ),
  ),
];
