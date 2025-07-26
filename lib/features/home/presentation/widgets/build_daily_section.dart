import 'package:flutter/material.dart';

Widget buildDailySection(weather) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final isWide = constraints.maxWidth > 500;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Daily Forecast',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: ListView.builder(
              key: ValueKey(weather.daily.length),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: weather.daily.length,
              itemBuilder: (context, index) {
                final day = weather.daily[index];
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      child:
                          isWide
                              ? Row(
                                children: [
                                  Image.network(
                                    "https:${day.conditionIcon}",
                                    width: 50,
                                    height: 50,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      day.date,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(day.conditionText),
                                  ),
                                  Text('${day.maxTempC}° / ${day.minTempC}°'),
                                ],
                              )
                              : ListTile(
                                contentPadding: const EdgeInsets.all(4),
                                leading: Image.network(
                                  "https:${day.conditionIcon}",
                                  width: 50,
                                  height: 50,
                                ),
                                title: Text(
                                  day.date,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(day.conditionText),
                                trailing: Text(
                                  '${day.maxTempC}° / ${day.minTempC}°',
                                ),
                              ),
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
