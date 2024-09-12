// lib/features/auth/logic/bloc/auth_bloc.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/features/auth/bloc/auth_event.dart';
import 'package:game/features/auth/bloc/auth_state.dart';
import 'package:game/features/auth/model/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
final FirebaseFirestore firestore;
  AuthBloc({required this.authRepository,required this.firestore}) : super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
     on<SignUpRequested>(_onSignUpRequested);
  }

  void _onSignInRequested(
      SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.signIn(event.email, event.password);
      emit(Authenticated());
    } catch (e) {
      emit(const AuthError('فشل تسجيل الدخول .. قد تحتاج لتشغيل VPN'));
    }
  }

  // Sign Up Logic
  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      // Register the user with Firebase Authentication
      UserCredential userCredential = await authRepository.signUp(event.email, event.password);

      User? user = userCredential.user;

      // Store username in Firestore
      if (user != null) {
        await firestore.collection('users').doc(user.uid).set({
          'username': event.username,
          'email': event.email,
        });

        // Optionally set the display name in Firebase Authentication
        await user.updateDisplayName(event.username);
      }

      emit(Authenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
////


// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final FirebaseAuth _firebaseAuth;
//   final FirebaseFirestore _firestore;

//   AuthBloc(this._firebaseAuth, this._firestore) : super(AuthInitial()) {
//     on<SignUpRequested>(_onSignUpRequested);
//     on<SignInRequested>(_onSignInRequested);
//   }

//   // Sign Up Logic
//   Future<void> _onSignUpRequested(
//       SignUpRequested event, Emitter<AuthState> emit) async {
//     emit(AuthLoading());

//     try {
//       // Register the user with Firebase Authentication
//       UserCredential userCredential = await _firebaseAuth
//           .createUserWithEmailAndPassword(
//               email: event.email, password: event.password);

//       User? user = userCredential.user;

//       // Store username in Firestore
//       if (user != null) {
//         await _firestore.collection('users').doc(user.uid).set({
//           'username': event.username,
//           'email': event.email,
//         });

//         // Optionally set the display name in Firebase Authentication
//         await user.updateDisplayName(event.username);
//       }

//       emit(Authenticated());
//     } catch (e) {
//       emit(AuthError(e.toString()));
//     }
//   }

//   // Sign In Logic
//   Future<void> _onSignInRequested(
//       SignInRequested event, Emitter<AuthState> emit) async {
//     emit(AuthLoading());

//     try {
//       await _firebaseAuth.signInWithEmailAndPassword(
//         email: event.email,
//         password: event.password,
//       );
//       emit(Authenticated());
//     } catch (e) {
//       emit(AuthError(e.toString()));
//     }
//   }
// }
