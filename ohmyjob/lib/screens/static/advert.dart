import 'package:flutter/material.dart';

import '../../models/Job.dart';

class AdvertScreen extends StatefulWidget {
  final Job job;

  AdvertScreen({required this.job});

  @override
  State<AdvertScreen> createState() => AdvertScreenState();
}

class AdvertScreenState extends State<AdvertScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.job.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(widget.job.company, style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text(
              widget.job.description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
