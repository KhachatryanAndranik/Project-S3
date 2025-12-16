import 'dart:async';

import 'package:flutter/material.dart';

class SearchBookSection extends StatefulWidget {
  const SearchBookSection({
    required this.onQueryChanged,
    this.initialQuery = '',
    this.debounce = const Duration(milliseconds: 300),
    super.key,
  });

  final ValueChanged<String> onQueryChanged;
  final String initialQuery;
  final Duration debounce;

  @override
  State<SearchBookSection> createState() => _SearchBookSectionState();
}

class _SearchBookSectionState extends State<SearchBookSection> {
  late final TextEditingController _controller;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(widget.debounce, () {
      widget.onQueryChanged(value);
    });
  }

  void _onSubmitted(String value) {
    _debounceTimer?.cancel();
    widget.onQueryChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: _onChanged,
      onSubmitted: _onSubmitted,
      textInputAction: TextInputAction.search,
      decoration: const InputDecoration(
        hintText: 'Search by title or author',
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}
