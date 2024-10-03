import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/features/quiz/model/quiz_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<List<Quiz>> fetchNewQuestions(String subject) async {
    try {
      // Fetch the document for the selected subject
      final doc = await _firestore.collection('questions').doc(subject).get();

      // Check if the document exists
      if (!doc.exists || doc.data() == null) {
        throw Exception("No questions found for subject: $subject");
      }

      // Fetch the 'questions' array from the document
      final List<Map<String, dynamic>> questions =
          List<Map<String, dynamic>>.from(doc.data()!['questions']);

      // Log or report successful fetch
      print("Questions fetched successfully for subject: $subject");

      // Map the data to a list of Quiz objects
      return questions.map((questionData) {
        return Quiz(
          id: questionData['id'],
          question: questionData['question'],
          options: List<String>.from(questionData['options']),
          correctAnswer: questionData['correctAnswer'],
        );
      }).toList();
    } on FirebaseException catch (e) {
      // Handle Firebase-specific errors
      print("Firebase error: ${e.message}");
      throw Exception("Failed to fetch questions from Firebase: ${e.message}");
    } catch (e) {
      // Handle any other errors
      print("Error fetching questions: $e");
      throw Exception("An unexpected error occurred: $e");
    }
  }
}
