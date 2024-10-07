

import 'package:equatable/equatable.dart';

abstract class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object> get props => [];
}

class AdminInitialState extends AdminState {}

//
// State when adding question is in progress
class AddingQuestionState extends AdminState {}

// State when adding question is successful
class QuestionAddedSuccessState extends AdminState {}

// State when adding question fails
class QuestionAddedFailureState extends AdminState {
  final String errorMessage;

  const QuestionAddedFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
