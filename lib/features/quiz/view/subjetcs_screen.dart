import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:game/features/quiz/view/quiz_screen.dart';

import '../../study table/models/study_subject_model.dart';

class SubjectSelectionScreen extends StatelessWidget {
  static const String routeName = '/Subjects';
  final List<StudySubject> subjects = [
    StudySubject('علوم', FontAwesomeIcons.flask, Colors.green, true),
    StudySubject('رياضيات', FontAwesomeIcons.calculator, Colors.blue, true),
    StudySubject('فيزياء', FontAwesomeIcons.atom, Colors.redAccent, true),
    StudySubject('كيمياء', FontAwesomeIcons.flask, Colors.orange, true),
    StudySubject('إنجليزي', FontAwesomeIcons.book, Colors.purple, true),
    StudySubject('وطنية', FontAwesomeIcons.flag, Colors.teal, true),
  ];

  SubjectSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختيار المواد'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Text(
              'اختر المواد',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  return SubjectCard(subject: subjects[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  final StudySubject subject;

  const SubjectCard({Key? key, required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (subject.isLocked) {
          _showUnlockDialog(context, subject);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('تم اختيار المادة: ${subject.name}')),
          );
        }
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: subject.isLocked
            ? Colors.grey
            : subject.color, // Change color if locked
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(subject.icon, size: 40, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              subject.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showUnlockDialog(BuildContext context, StudySubject subject) {
    final TextEditingController codeController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Unlock ${subject.name}'),
          content: TextField(
            controller: codeController,
            decoration: const InputDecoration(hintText: 'Enter unlock code'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (codeController.text == 'kakashi') {
                  // Example unlock code
                  subject.isLocked = false; // Unlock the subject
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuizScreen(
                              subject: subject.name))); // Close the dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('${subject.name} has been unlocked!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Incorrect code!')),
                  );
                }
              },
              child: const Text('Unlock'),
            ),
          ],
        );
      },
    );
  }
}
