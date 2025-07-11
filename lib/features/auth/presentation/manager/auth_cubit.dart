import 'package:celluweather_task1/features/auth/data/datasources/supabase_auth_datasource.dart';
import 'package:celluweather_task1/features/auth/data/datasources/local_storage_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SupabaseAuthDatasource authDatasource;
  final LocalStorageCubit localStorageCubit;

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  AuthCubit(this.authDatasource, this.localStorageCubit) : super(AuthInitial());

  Future<void> loginUser() async {
    emit(AuthLoading());
    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      await authDatasource.login(email, password);
      localStorageCubit.setLoggedIn(true);

      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signUp() async {
    emit(AuthLoading());
    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final fullName = fullNameController.text.trim();

      await authDatasource.signUp(email, password, fullName: fullName);
      localStorageCubit.setLoggedIn(true);
      emit(AuthSuccess());
    } catch (e) {
      if (e is AuthException && e.message.contains("Email not confirmed")) {
        emit(AuthFailure("Please confirm your email first."));
      } else {
        emit(AuthFailure(e.toString()));
      }
    }
  }

  @override
  Future<void> close() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
