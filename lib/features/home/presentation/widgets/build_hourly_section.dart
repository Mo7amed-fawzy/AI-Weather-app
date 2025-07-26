import 'package:celluweather_task1/core/styles/app_theme.dart';
import 'package:flutter/material.dart';

Widget buildHourlySection(weather) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final isWide = constraints.maxWidth > 600;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hourly Forecast',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: isWide ? 160 : 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: weather.hourly.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final hour = weather.hourly[index];
                return TweenAnimationBuilder(
                  duration: Duration(milliseconds: 400 + (index * 50)),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.scale(scale: value, child: child),
                    );
                  },
                  child: Container(
                    width: isWide ? 100 : 80,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          hour.time.split(' ').last,
                          style: TextStyle(
                            fontSize: isWide ? 16 : 14,
                            fontWeight: FontWeight.w500,
                            color:
                                Theme.of(context).brightness ==
                                        AppTheme.darkNeoFuturisticTheme
                                    ? Colors.white
                                    : Colors.black87,
                          ),
                        ),
                        Image.network(
                          "https:${hour.conditionIcon}",
                          width: isWide ? 50 : 40,
                          height: isWide ? 50 : 40,
                        ),
                        Text(
                          '${hour.tempC}°C',
                          style: TextStyle(
                            fontSize: isWide ? 16 : 14,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).brightness ==
                                        AppTheme.darkNeoFuturisticTheme
                                    ? Colors.white
                                    : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    },
  );
}
