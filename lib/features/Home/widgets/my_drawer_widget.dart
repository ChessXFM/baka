import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:game/Core/constant.dart';
import 'package:game/features/quiz/bloc/quiz_bloc.dart';

import '../../quiz/bloc/quiz_events.dart';
import '../../study table/models/study_subject_model.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black87, // Dark mode background
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with profile image and name
            const UserAccountsDrawerHeader(
              accountName: Text(
                'Ammar AlQudaimi',
                style: TextStyle(color: Colors.white),
              ),
              accountEmail: null,
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/images/logo.png'), // Replace with your image asset
                radius: 50,
              ),
              decoration: BoxDecoration(
                color: Colors.black54, // Darker background for header
              ),
            ),

            // Buttons for actions
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text(
                'Settings',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Handle settings action
              },
            ),
            ListTile(
              leading: const Icon(Icons.sync, color: Colors.white),
              title: const Text(
                'Sync',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {

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
                // Handle sync action
              },
            ),
            ListTile(
              leading: const Icon(Icons.star, color: Colors.white),
              title: const Text(
                'Premium',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Handle premium action
              },
            ),

            // Spacer to push the content upwards
            const Spacer(),

            // Footer, can add more buttons or info here if needed
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'App Version 1.0.0',
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// myDrawer(BuildContext context) {
//   return Drawer(
//     child: Container(
//       color: Colors.black,
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           const UserAccountsDrawerHeader(
//             decoration: BoxDecoration(color: Colors.black),
//             currentAccountPicture: CircleAvatar(
//               backgroundImage: AssetImage('assets/images/logo.png'),
//             ),
//             accountName: Text(
//               'Ammar AlQudaimi',
//               style: TextStyle(color: Colors.white),
//             ),
//             accountEmail: null,
//           ),
//           ListTile(
//             title: const Text(
//               'Settings',
//               style: TextStyle(color: Colors.white),
//             ),
//             onTap: () {
//               // Handle settings button tap
//             },
//           ),
//           ListTile(
//             title: const Text(
//               'Sync',
//               style: TextStyle(color: Colors.white),
//             ),
//             onTap: () {
//               // Handle sync button tap
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: const Text('اختر مادة'),
//                     content: SizedBox(
//                       width: double.maxFinite,
//                       child: ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: AppConstants.availableSubjects.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           StudySubject subject =
//                               AppConstants.availableSubjects[index];

//                           return ListTile(
//                             leading: FaIcon(subject.icon, color: subject.color),
//                             title: Text(subject.name),
//                             tileColor: null,
//                             onTap: () async {
//                               BlocProvider.of<QuizBloc>(context)
//                                   .add(SyncQuestions(subject.name));
//                               Navigator.of(context).pop();
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//           ListTile(
//             title: const Text(
//               'Go Premium',
//               style: TextStyle(color: Colors.white),
//             ),
//             onTap: () {
//               // Handle premium button tap
//             },
//           ),
//         ],
//       ),
//     ),
//   );
// }
