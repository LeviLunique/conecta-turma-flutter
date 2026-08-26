import 'package:flutter/material.dart';

class ContentShell extends StatelessWidget {
  const ContentShell({
    super.key,
    required this.child,
    this.maxWidth = 1080,
    this.padding = const EdgeInsets.fromLTRB(20, 20, 20, 40),
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
