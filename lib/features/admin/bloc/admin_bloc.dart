// admin_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../quiz/services/firebase_service.dart';
import '../../quiz/services/local_storage_service.dart';
import 'admin_event.dart';
import 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final LocalStorageService localStorageService = LocalStorageService();
  final FirebaseService firebaseService = FirebaseService();

  AdminBloc() : super(AdminInitialState()) {
    on<AddQuestionEvent>(_onAddQuestion);
  }

  Stream<AdminState> mapEventToState(AdminEvent event) async* {
    if (event is AddQuestionEvent) {
      try {
        await _firestore.collection('questions').doc(event.subject).update({
          'questions': FieldValue.arrayUnion([event.question])
        });
        yield QuestionAddedSuccessState();
      } catch (e) {
        yield QuestionAddedFailureState(errorMessage: e.toString());
      }
    }
  }

  //

  // Handler for adding a question to Firebase
  Future<void> _onAddQuestion(
      AddQuestionEvent event, Emitter<AdminState> emit) async {
    emit(AddingQuestionState());

    try {
      // Call the Firebase service to add the question
      await firebaseService.addQuestion(event.subject, event.question);

      // Emit success state if the question is added successfully
      emit(QuestionAddedSuccessState());
    } catch (e) {
      // Emit failure state if an error occurs
      emit(QuestionAddedFailureState(errorMessage: e.toString()));
    }
  }
}
