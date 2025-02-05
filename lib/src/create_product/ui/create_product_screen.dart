import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create'),
      actions: [

      ],),
      body: Center(
        child: Text('Center'),
      ),
    );
  }
}
