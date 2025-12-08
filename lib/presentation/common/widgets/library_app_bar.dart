import 'package:flutter/material.dart';

class LibraryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LibraryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar();
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}