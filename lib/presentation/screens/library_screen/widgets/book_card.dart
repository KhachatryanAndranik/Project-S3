import 'package:flutter/material.dart';
import 'package:library_app/presentation/screens/library_screen/view_models.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.book});

  final BookViewModel book;

  @override
  Widget build(BuildContext context) {
    final isBorrowed = book.status == BookStatus.borrowed;
    // final borrowedInfo = book.borrowedInfo;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF6D4C41),
        borderRadius: BorderRadius.circular(16),
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
                    book.title,
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
              book.authorName,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: const Color(0xFFEFEBE9)),
            ),
            // if (borrowedInfo != null) ...[
            //   const SizedBox(height: 12),
            //   Text(
            //     'Borrowed by: ${borrowedInfo.user.name} ${borrowedInfo.user.surname}',
            //     style: Theme.of(
            //       context,
            //     ).textTheme.bodySmall?.copyWith(color: const Color(0xFFD7CCC8)),
            //   ),
            //   Text(
            //     'Due: ${borrowedInfo.dueDate.toLocal().toString().split(' ')[0]}',
            //     style: Theme.of(
            //       context,
            //     ).textTheme.bodySmall?.copyWith(color: const Color(0xFFD7CCC8)),
            //   ),
            // ],
          ],
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
