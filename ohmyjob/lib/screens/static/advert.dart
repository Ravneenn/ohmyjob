import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        title: Text(widget.job.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("İlan Sahibi: ", style: TextStyle(fontSize: 22)),
                Text(widget.job.company,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              "İlan Açıklaması:",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Container(
                  child: Text(
                    widget.job.description,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
                color: Color.fromRGBO(3, 158, 241, 0.15),
                borderRadius: BorderRadius.circular(50)),
            child: Center(
                child: Text(
              "Başvur",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
          )
        ],
      ),
    );
  }
}
