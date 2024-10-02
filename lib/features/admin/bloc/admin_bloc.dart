// admin_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'admin_event.dart';
import 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AdminBloc() : super(AdminInitial());

  Stream<AdminState> mapEventToState(AdminEvent event) async* {
    if (event is AddQuestionEvent) {
      try {
        await _firestore.collection('questions').doc(event.subject).update({
          'questions': FieldValue.arrayUnion([event.questionData])
        });
        yield QuestionAddedSuccess();
      } catch (e) {
        yield QuestionAddFailed(e.toString());
      }
    }
  }
}
