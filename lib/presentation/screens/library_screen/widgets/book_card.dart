import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/domain.dart';
import 'package:library_app/presentation/common.dart';
import 'package:library_app/presentation/screens/library_screen/bloc/cubit/library_cubit.dart';
import 'package:library_app/presentation/screens/library_screen/view_models.dart';

class BookCard extends StatefulWidget {
  const BookCard({super.key, required this.book});

  final BookViewModel book;

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> with TickerProviderStateMixin {
  static const _animationDuration = Duration(milliseconds: 250);
  static const _defaultBorrowDays = 14;
  static const _maxBorrowDays = 365;

  bool _isOpen = false;

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  void _returnBook(int userId) {
    final returnData = BorrowBookData(bookId: widget.book.id, userId: userId);

    context.read<LibraryCubit>().returnBook(returnData);
  }

  void _borrowBook(int userId, DateTime dueDate) {
    final now = DateTime.now();
    final borrowData = BorrowBookData(
      bookId: widget.book.id,
      userId: userId,
      borrowedDate: now,
      dueDate: dueDate,
    );

    context.read<LibraryCubit>().borrowBook(borrowData);
  }

  Future<void> _pickDueDateAndBorrow(int userId) async {
    final now = DateTime.now();
    final initial = now.add(const Duration(days: _defaultBorrowDays));

    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime(initial.year, initial.month, initial.day),
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(
        now.year,
        now.month,
        now.day,
      ).add(const Duration(days: _maxBorrowDays)),
    );

    if (selected == null) return;

    _borrowBook(userId, selected);
  }

  @override
  Widget build(BuildContext context) {
    final isBorrowed = widget.book.status == BookStatus.borrowed;
    final borrowedInfo = widget.book.borrowedInfo;

    return InkWell(
      onTap: _toggle,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: _animationDuration,
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: const Color(0xFF6D4C41),
          borderRadius: BorderRadius.circular(16),
          image: widget.book.coverImageUrl != null
              ? DecorationImage(
                  image: NetworkImage(widget.book.coverImageUrl!),
                  fit: BoxFit.cover,
                  opacity: 0.8,
                )
              : null,
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.book.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  _StatusChip(isBorrowed: isBorrowed),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                widget.book.authorName,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFFEFEBE9),
                ),
              ),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthenticatedState) {
                    final currentId = state.user.id;

                    return Column(
                      children: [
                        if (!isBorrowed) ...[
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () => _pickDueDateAndBorrow(currentId),
                              child: const Text('Borrow'),
                            ),
                          ),
                        ] else ...[
                          if (currentId == borrowedInfo?.user.id) ...[
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                onPressed: () => _returnBook(currentId),
                                child: const Text('Return'),
                              ),
                            ),
                          ],
                        ],
                      ],
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
              AnimatedSize(
                duration: _animationDuration,
                curve: Curves.easeInOut,
                alignment: Alignment.topCenter,
                child: (!_isOpen || borrowedInfo == null)
                    ? const SizedBox.shrink()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          Text(
                            'Borrowed by: ${borrowedInfo.user.name} ${borrowedInfo.user.surname}',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: const Color(0xFFD7CCC8)),
                          ),
                          Text(
                            'borrowed: ${borrowedInfo.borrowedDate.toLocal().toString().split(' ')[0]}',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: const Color(0xFFD7CCC8)),
                          ),
                          Text(
                            'Due: ${borrowedInfo.dueDate.toLocal().toString().split(' ')[0]}',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: const Color(0xFFD7CCC8)),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.isBorrowed});

  final bool isBorrowed;

  @override
  Widget build(BuildContext context) {
    final bgColor = isBorrowed
        ? const Color(0xFF8D6E63)
        : const Color(0xFF4E342E);
    final label = isBorrowed ? 'Borrowed' : 'Available';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
