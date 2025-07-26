import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:celluweather_task1/features/home/data/datasource/city_search_remote_datasource.dart';

class CitySearchCubit extends Cubit<List<String>> {
  final CitySearchRemoteDataSource citySearchRemote;

  CitySearchCubit(this.citySearchRemote) : super([]);

  Timer? _debounce;

  void search(String query) {
    // كل مرة نكتب فيها حاجة، نلغي الـ timer القديم
    _debounce?.cancel();

    if (query.isEmpty) {
      emit([]);
      return;
    }

    // نبدأ timer جديد
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        final cities = await citySearchRemote.searchCities(query);
        emit(cities);
      } catch (_) {
        emit([]);
      }
    });
  }

  void clearSuggestions() {
    emit([]);
    _debounce?.cancel();
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
