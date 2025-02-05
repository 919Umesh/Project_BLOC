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
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Bootstrap.house_add),
      ),
      drawer: Drawer(
        clipBehavior: Clip.antiAlias, // Corrected clipBehavior
        child: Column(
          children: [
            // Drawer Header with an Image
            Container(
              width: double.infinity,
              height: 200, // Adjust height as needed
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/profile.jpg'), // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Drawer Items
            const Text('dsg'),
            const Text('dsg'),
            const Text('dsg'),
            const Text('dsg'),
            const Text('dsg'),
          ],
        ),
      ),
    );
  }
}
