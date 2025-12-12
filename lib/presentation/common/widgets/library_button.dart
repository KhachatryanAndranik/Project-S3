import 'package:flutter/material.dart';

class LibraryButton extends StatelessWidget {
  const LibraryButton.text({
    super.key,
    required String label,
    required VoidCallback onTap,
    Color? backgroundColor,
    TextStyle? textStyle,
  }) : _label = label,
       _icon = null,
       _onTap = onTap,
       _backgroundColor = backgroundColor,
       _textStyle = textStyle;

  const LibraryButton.icon({
    super.key,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    Color? backgroundColor,
    TextStyle? textStyle,
  }) : _label = label,
       _icon = icon,
       _onTap = onTap,
       _backgroundColor = backgroundColor,
       _textStyle = textStyle;

  static const Color _defaultBrown = Color(0xFF8D6E63); // warm brown
  static const BorderRadius _radius = BorderRadius.all(Radius.circular(16));

  final String _label;
  final IconData? _icon;
  final VoidCallback _onTap;
  final Color? _backgroundColor;
  final TextStyle? _textStyle;

  @override
  Widget build(BuildContext context) {
    final color = _backgroundColor ?? _defaultBrown;
    final textColor = _textStyle?.color ?? Colors.white;

    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: _onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(color: color, borderRadius: _radius),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_icon != null) ...[
                Icon(_icon, color: textColor),
                const SizedBox(width: 8),
              ],
              Text(
                _label,
                style:
                    _textStyle ??
                    Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
