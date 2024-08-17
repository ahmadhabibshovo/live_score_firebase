import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:live_score/View/screens/widgets/football_score_card.dart';
import 'package:live_score/entities/football.dart';
import 'package:live_score/local_notification_service.dart';

class MatchListScreen extends StatefulWidget {
  const MatchListScreen({super.key});

  @override
  State<MatchListScreen> createState() => _MatchListScreenState();
}

class _MatchListScreenState extends State<MatchListScreen> {
  final firebaseFireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Football'),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder(
          stream: firebaseFireStore.collection('football').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              final docs = snapshot.data?.docs ?? [];
              return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (_, index) {
                    final data = docs[index];
                    return FootballScoreCard(
                      football: Football(
                          team1Name: data.get('team1Name'),
                          team2Name: data.get('team2Name'),
                          team1Score: data.get('team1Score'),
                          team2Score: data.get('team2Score')),
                    );
                  });
            }
            return Text('Error');
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          LocalNotificationService.instance.sendNotification(
              title: 'Live Score App', description: "Local Notification !!!");
        },
        child: Icon(Icons.notifications_active_outlined),
      ),
    );
  }
}
