// admin_event.dart
abstract class AdminEvent {}

class AddQuestionEvent extends AdminEvent {
  final String subject;
  final Map<String, dynamic> questionData;

  AddQuestionEvent({required this.subject, required this.questionData});
}