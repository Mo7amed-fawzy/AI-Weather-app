import 'package:flutter/material.dart';

class AnimatedGradientBackground extends StatefulWidget {
  final Widget child;

  const AnimatedGradientBackground({super.key, required this.child});

  @override
  State<AnimatedGradientBackground> createState() =>
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _alignment;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    _alignment = TweenSequence([
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
        weight: 50,
      ),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return SizedBox.expand(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: _alignment.value,
                end: Alignment.center,
                colors: [
                  const Color(0xFF1E1E2F),
                  const Color(0xFF6C63FF).withOpacity(0.2),
                  const Color(0xFF00C9FF).withOpacity(0.2),
                ],
              ),
            ),
            child: widget.child,
          ),
        );
      },
    );
  }
}
