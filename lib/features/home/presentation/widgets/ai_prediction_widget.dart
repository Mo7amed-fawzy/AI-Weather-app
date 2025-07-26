import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:celluweather_task1/features/ai_analysis/presentation/manager/ai_predict_cubit.dart';

class AiPredictionWidget extends StatefulWidget {
  const AiPredictionWidget({super.key});

  @override
  State<AiPredictionWidget> createState() => _AiPredictionWidgetState();
}

class _AiPredictionWidgetState extends State<AiPredictionWidget>
    with SingleTickerProviderStateMixin {
  final List<int> inputs = [1, 0, 1, 1, 0];

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPredictPressed() {
    context.read<AiPredictCubit>().predict(inputs);
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiPredictCubit, AiPredictState>(
      builder: (context, state) {
        Widget content;

        if (state.isLoading) {
          content = const Padding(
            padding: EdgeInsets.all(16),
            child: CircularProgressIndicator(),
          );
        } else if (state.error != null) {
          content = Column(
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 40),
              const SizedBox(height: 8),
              Text(
                state.error!,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        } else if (state.result != null) {
          final isPositive = state.result == 1;

          content = ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.purpleAccent.withValues(alpha: 0.2),
                    Colors.blueAccent.withValues(alpha: 0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isPositive ? Colors.greenAccent : Colors.redAccent,
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: (isPositive ? Colors.greenAccent : Colors.redAccent)
                        .withValues(alpha: 0.6),
                    blurRadius: 20,
                    spreadRadius: 1,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(
                    isPositive ? Icons.check_circle : Icons.cancel,
                    color: isPositive ? Colors.greenAccent : Colors.redAccent,
                    size: 40,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      isPositive
                          ? 'Conditions look ideal – go for it with confidence!'
                          : 'Not the ideal time – prepare wisely.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color:
                            isPositive ? Colors.greenAccent : Colors.redAccent,
                        shadows: [
                          Shadow(
                            blurRadius: 12,
                            color: (isPositive
                                    ? Colors.greenAccent
                                    : Colors.redAccent)
                                .withValues(alpha: 0.6),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          content = const Text('click to predict ');
        }

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 20),
          elevation: 2,
          color: Theme.of(context).cardColor.withValues(alpha: 0.95),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'AI Vision',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton.icon(
                      onPressed: _onPredictPressed,
                      icon: const Icon(Icons.bolt, size: 20),
                      label: const Text('Predict Now'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF6C63FF),
                        shadowColor: const Color(0xFF6C63FF),
                        elevation: 8,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder:
                          (child, animation) =>
                              FadeTransition(opacity: animation, child: child),
                      child: content,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
