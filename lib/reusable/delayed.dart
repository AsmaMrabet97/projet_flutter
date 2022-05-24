import 'package:flutter/material.dart';
import 'dart:async';

class delayed extends StatefulWidget {
  final Widget child;
  final int delay;
  const delayed({required this.delay, required this.child});

  @override
  State<delayed> createState() => _delayedState();
}

class _delayedState extends State<delayed> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animOffset;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    final Curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    );
    _animOffset = Tween<Offset>(
      begin: Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(Curve);
    Timer(Duration(milliseconds: widget.delay), () {
      _controller.forward();
    });
  }

  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
    );
  }
}
