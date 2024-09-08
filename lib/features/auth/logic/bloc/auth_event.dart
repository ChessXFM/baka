// lib/features/auth/logic/bloc/auth_event.dart

import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
class SignUpRequested extends AuthEvent {
  final String username;
  final String email;
  final String password;

  const SignUpRequested(this.username,this.email, this.password);

  @override
  List<Object> get props => [username,email, password];
}