import 'package:celluweather_task1/features/home/presentation/manager/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForecastScreen extends StatelessWidget {
  final String city;

  const ForecastScreen({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    context.read<ForecastCubit>().fetchForecast(city);

    return Scaffold(
      backgroundColor: const Color(0xFF0A1E46),
      body: SafeArea(
        child: BlocBuilder<ForecastCubit, ForecastState>(
          builder: (context, state) {
            if (state is ForecastLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ForecastLoaded) {
              final selectedDay = state.selectedDay;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Hello',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Eslam Sameh',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.menu, color: Colors.white, size: 28),
                      ],
                    ),
                  ),

                  // Horizontal Days
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.forecast.length,
                      itemBuilder: (context, index) {
                        final day = state.forecast[index];
                        return GestureDetector(
                          onTap: () {
                            context.read<ForecastCubit>().selectDay(index);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  index == state.selectedIndex
                                      ? Colors.white
                                      : Colors.white24,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  // day.dayName,
                                  day.date.split('-').first,
                                  style: TextStyle(
                                    color:
                                        index == state.selectedIndex
                                            ? Colors.black
                                            : Colors.white70,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  day.date.split('-').last,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        index == state.selectedIndex
                                            ? Colors.black
                                            : Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Steps
                  Center(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.blueAccent,
                              width: 6,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.directions_walk,
                                color: Colors.white,
                                size: 30,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '5234',
                                style: TextStyle(
                                  fontSize: 36,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Steps',
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Stats Row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatCircle('12.4', 'KM'),
                        _buildStatCircle('${selectedDay.humidity}', 'Humidity'),
                        _buildStatCircle('${selectedDay.wind}', 'Wind'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Placeholder Chart
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          'Graph Placeholder',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Bottom Navigation
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.star, color: Colors.white),
                        Icon(Icons.person, color: Colors.white),
                        Icon(Icons.home, color: Colors.white, size: 30),
                        Icon(Icons.check_box, color: Colors.white),
                        Icon(Icons.star_border, color: Colors.white),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              );
            } else if (state is ForecastError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildStatCircle(String value, String label) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(
              value: 0.8,
              color: Colors.blueAccent,
              backgroundColor: Colors.white24,
              strokeWidth: 6,
            ),
            Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}
