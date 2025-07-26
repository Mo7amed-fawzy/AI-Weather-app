import 'package:flutter/material.dart';

Widget buildDailySection(weather) {
  return SingleChildScrollView(
    child: Column(
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
                  child: ListTile(
                    leading: Image.network("https:${day.conditionIcon}"),
                    title: Text(day.date),
                    subtitle: Text(day.conditionText),
                    trailing: Text('${day.maxTempC}° / ${day.minTempC}°'),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
