

import 'package:equatable/equatable.dart';

import '../../quiz/model/quiz_model.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object> get props => [];
}

// Event for adding a single question
class AddQuestionEvent extends AdminEvent {
  final String subject;
  final Quiz question;

  const AddQuestionEvent({required this.subject, required this.question});

  @override
  List<Object> get props => [subject, question];
}
