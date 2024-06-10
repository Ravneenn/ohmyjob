import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/Job.dart';
import '../widgets/bnb.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final List<Job> jobs = List.generate(
    10,
    (index) => Job(
      title: 'Job Title $index',
      company: 'Company Name $index',
      description: 'Job Description for Job Title $index',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Listings'),
      ),
      body: ListView.builder(
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          final job = jobs[index];
          return GestureDetector(
            onTap: () {
              context.push('/jobDetail', extra: job);
            },
            child: Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Color.fromRGBO(3, 158, 241, 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    job.company,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    job.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: bnb(
        index: 0,
      ),
    );
  }
}
