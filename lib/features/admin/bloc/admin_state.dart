// admin_state.dart
abstract class AdminState {}

class AdminInitial extends AdminState {}

class QuestionAddedSuccess extends AdminState {}

class QuestionAddFailed extends AdminState {
  final String error;

  QuestionAddFailed(this.error);
}
