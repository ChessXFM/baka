import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
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

//
// Add Single Question
  Future<void> addQuestion(String subject, Quiz question) async {
    try {
      final docRef = _firestore.collection('questions').doc(subject);

      // Get the current document
      final doc = await docRef.get();

      if (doc.exists && doc.data() != null) {
        // Update the 'questions' array with a new question that Firebase generates an ID for
        await docRef.update({
          'questions': FieldValue.arrayUnion([
            {
              'id': _firestore
                  .collection('questions')
                  .doc()
                  .id, // Generate unique ID for the question
              'question': question.question,
              'options': question.options,
              'correctAnswer': question.correctAnswer,
            }
          ])
        });
      } else {
        // If the document does not exist, create it with the new question
        await docRef.set({
          'questions': [
            {
              'id': _firestore
                  .collection('questions')
                  .doc()
                  .id, // Generate unique ID for the question
              'question': question.question,
              'options': question.options,
              'correctAnswer': question.correctAnswer,
            }
          ]
        });
      }

      print("Question added successfully for subject: $subject");
    } on FirebaseException catch (e) {
      print("Firebase error: ${e.message}");
      throw Exception("Failed to add question to Firebase: ${e.message}");
    } catch (e) {
      print("Error adding question: $e");
      throw Exception("An unexpected error occurred: $e");
    }
  }

//
// Add Multi Questions
  Future<void> addMultipleQuestions(
      String subject, List<Quiz> questions) async {
    try {
      final docRef = _firestore.collection('questions').doc(subject);

      // Prepare the list of questions to be added
      List<Map<String, dynamic>> questionsToAdd = questions.map((quiz) {
        return {
          'id': _firestore
              .collection('questions')
              .doc()
              .id, // Generate unique ID for each question
          'question': quiz.question,
          'options': quiz.options,
          'correctAnswer': quiz.correctAnswer,
        };
      }).toList();

      // Get the current document
      final doc = await docRef.get();

      if (doc.exists && doc.data() != null) {
        await docRef
            .update({'questions': FieldValue.arrayUnion(questionsToAdd)});
      } else {
        // If document doesn't exist, create it with the new questions
        await docRef.set({'questions': questionsToAdd});
      }

      print("Questions added successfully for subject: $subject");
    } on FirebaseException catch (e) {
      print("Firebase error: ${e.message}");
      throw Exception("Failed to add questions to Firebase: ${e.message}");
    } catch (e) {
      print("Error adding questions: $e");
      throw Exception("An unexpected error occurred: $e");
    }
  }

//
// Add Questions From Json File
  Future<void> addQuestionsFromJson(String subject, String jsonFilePath) async {
    try {
      // تحميل ملف JSON كـ String
      final String jsonString = await rootBundle.loadString(jsonFilePath);

      // فك تشفير JSON إلى قائمة من العناصر الديناميكية
      final List<dynamic> jsonData = json.decode(jsonString);

      // تحويل بيانات JSON إلى قائمة من كائنات Quiz مع توليد id لكل سؤال
      List<Quiz> questions = jsonData.map((questionData) {
        return Quiz(
          id: _firestore
              .collection('questions')
              .doc()
              .id, // توليد id فريد للسؤال
          question: questionData['question'],
          options: List<String>.from(questionData['options']),
          correctAnswer: questionData['correctAnswer'],
        );
      }).toList();

      // استدعاء الدالة لإضافة الأسئلة المتعددة مع توليد معرفات فريدة
      await addMultipleQuestions(subject, questions);

      print("Questions from JSON added successfully for subject: $subject");
    } on FirebaseException catch (e) {
      print("Firebase error: ${e.message}");
      throw Exception(
          "Failed to add questions from JSON to Firebase: ${e.message}");
    } catch (e) {
      print("Error adding questions from JSON: $e");
      throw Exception("An unexpected error occurred: $e");
    }
  }
}
