import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game/features/quiz/model/quiz_model.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

Future<List<Quiz>> fetchNewQuestions(String subject) async {
    // Assume you have a collection named 'questions'
    final querySnapshot = await _db
        .collection('questions')
        .where('subject', isEqualTo: subject) // Filter by subject
        .get();

    return querySnapshot.docs.map((doc) {
      return Quiz(id: doc['id'],
        question: doc['question'],
        options: List<String>.from(doc['options']),
        correctAnswer: doc['correctAnswer'], 
      );
    }).toList();
  }

}
