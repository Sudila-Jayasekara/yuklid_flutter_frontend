import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/question.dart';
import '../providers/auth_provider.dart';
import '../services/user_service.dart';
import '../widgets/mcq_widgets.dart';
import 'login_page.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  QuestionPageState createState() => QuestionPageState();
}

class QuestionPageState extends State<QuestionPage> {
  late Future<Question> _questionFuture;

  @override
  void initState() {
    super.initState();
    _questionFuture = _fetchQuestion();
  }

  Future<Question> _fetchQuestion() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return UserService.getRandomQuestion(authProvider.token!);
  }

  void _refreshQuestion() {
    setState(() {
      _questionFuture = _fetchQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Question'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authProvider.logout();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()));
            },
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min, // Use minimum vertical space
        children: [
          FutureBuilder<Question>(
            future: _questionFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                if (snapshot.error.toString().contains('Unauthorized')) {
                  authProvider.logout();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()));
                  return const SizedBox.shrink();
                }
                return Center(child: Text('Error: ${snapshot.error.toString().replaceFirst('Exception: ', '')}'));
              } else if (snapshot.hasData) {
                final question = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: MCQWidget(
                    questionId: question.id,
                    questionText: question.questionText,
                    options: question.options.map((option) => {
                      'id': option.id,
                      'text': option.text,
                    }).toList(),
                    onOptionSelected: (selectedOptionId, questionId) {
                      print('Selected option $selectedOptionId for question $questionId');
                    },
                  ),
                );
              }
              return const Center(child: Text('No question found'));
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _refreshQuestion,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('Next Question'),
            ),
          ),
        ],
      ),
    );
  }
}