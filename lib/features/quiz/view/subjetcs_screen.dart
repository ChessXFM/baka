import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:game/Core/constant.dart';
import 'package:game/features/quiz/bloc/quiz_events.dart';
import 'package:game/features/quiz/view/quiz_screen.dart';
import '../../study table/models/study_subject_model.dart';
import '../bloc/quiz_bloc.dart';
import '../bloc/quiz_states.dart';

class SubjectSelectionScreen extends StatelessWidget {
  static const String routeName = '/Subjects';

  const SubjectSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<QuizBloc>().add(const GetUnlockedSubjects());
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختيار المواد'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) {
            List<String> unlockedSubjects = [];
            if (state is GettingUnlockedSubjectsState) {
              unlockedSubjects = state.unlockedSubjects;
            }
            if (state is SubjectUnlockedState) {
              unlockedSubjects = state.unlockedSubjects;
            }
            return Column(
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: AppConstants.availableSubjects.length,
                    itemBuilder: (context, index) {
                      return SubjectCard(
                        isUnlocked: unlockedSubjects.contains(
                            AppConstants.availableSubjects[index].name),
                        subject: AppConstants.availableSubjects[index],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  final StudySubject subject;
  final bool isUnlocked;

  const SubjectCard({Key? key, required this.subject, required this.isUnlocked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isUnlocked) {
          _showUnlockDialog(context, subject);
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QuizScreen(subject: subject.name)),
          );
        }
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: !isUnlocked ? Colors.grey : subject.color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(subject.icon, size: 40, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              subject.arabicName,
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
          title: Text('فتح مادة :  ${subject.arabicName}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('أدخل الكود الخاص:'),
              TextField(
                controller: codeController,
                decoration: const InputDecoration(hintText: 'الكود'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (codeController.text == 'kakashi') {
                  context.read<QuizBloc>().add(UnlockSubject(subject.name));
                  context.read<QuizBloc>().add(const GetUnlockedSubjects());
                  // Example unlock code
                  subject.isLocked = false; // Unlock the subject
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            QuizScreen(subject: subject.name)),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('تم فتح المادة :${subject.name}')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('كود خاطئ ! تأكد من دقة الكود .. ')),
                  );
                }
              },
              child: const Text('إدخال'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء الأمر'),
            ),
          ],
        );
      },
    );
  }
}
