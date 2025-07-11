import 'package:hydrated_bloc/hydrated_bloc.dart';

class LocalStorageCubit extends HydratedCubit<bool> {
  LocalStorageCubit() : super(false);

  void setLoggedIn(bool value) => emit(value);

  @override
  bool? fromJson(Map<String, dynamic> json) {
    return json['isLoggedIn'] as bool?;
  }

  @override
  Map<String, dynamic>? toJson(bool state) {
    return {'isLoggedIn': state};
  }
}
