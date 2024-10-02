import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/features/quiz/model/quiz_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<List<Quiz>> fetchNewQuestions(String subject) async {
  try {
    // Fetch the document for the selected subject
    final doc = await _firestore.collection('questions').doc(subject).get();

    // Check if the document exists
    if (doc.exists && doc.data() != null) {
      // Fetch the 'questions' array from the document
      final List<Map<String, dynamic>> questions = List<Map<String, dynamic>>.from(doc.data()!['questions']);

      // Map the data to a list of Quiz objects
      return questions.map((questionData) {
        return Quiz(
          id: questionData['id'],
          question: questionData['question'],
          options: List<String>.from(questionData['options']), // Assuming 'options' is the field for answers
          correctAnswer: questionData['correctAnswer'],
        );
      }).toList();
    } else {
      throw Exception("No questions found for subject: $subject");
    }
  } catch (e) {
    // Handle any errors that might occur during fetching
    print("Error fetching questions: $e");
    return [];
  }
}


}
