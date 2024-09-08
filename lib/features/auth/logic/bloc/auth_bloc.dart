// lib/features/auth/logic/bloc/auth_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/features/auth/logic/bloc/auth_event.dart';
import 'package:game/features/auth/logic/bloc/auth_state.dart';
import 'package:game/features/auth/data/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
  }

  void _onSignInRequested(
      SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.signIn(event.email, event.password);
      emit(Authenticated());
    } catch (e) {
      emit(AuthError('فشل تسجيل الدخول .. قد تحتاج لتشغيل VPN'));
    }
  }
}
