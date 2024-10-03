import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:game/Core/constant.dart';
import 'package:game/features/quiz/bloc/quiz_bloc.dart';

import '../../features/quiz/bloc/quiz_events.dart';
import '../../features/study table/models/study_subject_model.dart';

myDrawer(BuildContext context) {
  return Drawer(
    child: Container(
      color: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.black),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo.png'),
            ),
            accountName: Text(
              'Ammar AlQudaimi',
              style: TextStyle(color: Colors.white),
            ),
            accountEmail: null,
          ),
          ListTile(
            title: const Text(
              'Settings',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              // Handle settings button tap
            },
          ),
          ListTile(
            title: const Text(
              'Sync',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              // Handle sync button tap
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('اختر مادة'),
                    content: SizedBox(
                      width: double.maxFinite,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: AppConstants.availableSubjects.length,
                        itemBuilder: (BuildContext context, int index) {
                          StudySubject subject =
                              AppConstants.availableSubjects[index];

                          return ListTile(
                            leading: FaIcon(subject.icon, color: subject.color),
                            title: Text(subject.name),
                            tileColor: null,
                            onTap: () async {
                              BlocProvider.of<QuizBloc>(context)
                                  .add(SyncQuestions(subject.name));
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
          ListTile(
            title: const Text(
              'Go Premium',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              // Handle premium button tap
            },
          ),
        ],
      ),
    ),
  );
}
