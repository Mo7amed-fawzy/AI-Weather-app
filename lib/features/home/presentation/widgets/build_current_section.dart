import 'package:flutter/material.dart';

Widget buildCurrentSection(BuildContext context, weather) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final textColor = isDark ? Colors.white : Colors.black87;

  return LayoutBuilder(
    builder: (context, constraints) {
      final isWide = constraints.maxWidth > 400;

      return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child:
            isWide
                ? Row(
                  children: [
                    Hero(
                      tag: 'icon-${weather.current.conditionIcon}',
                      child: Image.network(
                        "https:${weather.current.conditionIcon}",
                        width: 60,
                        height: 60,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${weather.location.name}, ${weather.location.country}',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            weather.current.conditionText,
                            style: TextStyle(color: textColor),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${weather.current.tempC}°C',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                )
                : Column(
                  children: [
                    Hero(
                      tag: 'icon-${weather.current.conditionIcon}',
                      child: Image.network(
                        "https:${weather.current.conditionIcon}",
                        width: 60,
                        height: 60,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${weather.location.name}, ${weather.location.country}',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      weather.current.conditionText,
                      style: TextStyle(color: textColor),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${weather.current.tempC}°C',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
      );
    },
  );
}
