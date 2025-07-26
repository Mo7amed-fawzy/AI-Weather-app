import 'package:celluweather_task1/core/styles/app_theme.dart';
import 'package:flutter/material.dart';

Widget buildCurrentSection(BuildContext context, weather) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    decoration: BoxDecoration(
      color: Colors.blue[50],
      borderRadius: BorderRadius.circular(12),
    ),
    child: ListTile(
      leading: Hero(
        tag: 'icon-${weather.current.conditionIcon}',
        child: Image.network("https:${weather.current.conditionIcon}"),
      ),
      title: Text(
        '${weather.location.name}, ${weather.location.country}',
        style: TextStyle(
          color:
              Theme.of(context).brightness == AppTheme.darkNeoFuturisticTheme
                  ? Colors.white
                  : Colors.black87,
        ),
      ),
      subtitle: Text(
        weather.current.conditionText,
        style: TextStyle(
          color:
              Theme.of(context).brightness == AppTheme.darkNeoFuturisticTheme
                  ? Colors.white
                  : Colors.black87,
        ),
      ),
      trailing: Text(
        '${weather.current.tempC}°C',
        style: TextStyle(
          color:
              Theme.of(context).brightness == AppTheme.darkNeoFuturisticTheme
                  ? Colors.white
                  : Colors.black87,
        ),
      ),
    ),
  );
}
