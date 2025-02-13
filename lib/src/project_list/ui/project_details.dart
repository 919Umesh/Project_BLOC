import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';

class ProjectDetailsPage extends StatefulWidget {
  final String name;
  final String address;
  const ProjectDetailsPage({super.key,required this.name,required this.address});

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Center(
        child: Text(widget.address),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Fluttertoast.showToast(msg: "Button Pressed");
          },
          icon:const Icon(Bootstrap.house_add),
          label:const Text('Add Project')),
    );
  }
}
