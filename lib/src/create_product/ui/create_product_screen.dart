import 'dart:io';
import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/create_product_bloc.dart';
import '../bloc/create_product_event.dart';
import '../bloc/create_product_state.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  File? _imageFile;

  // Build FormData for the API request
  d.FormData _buildFormData(Map<String, dynamic> fields) {
    return d.FormData.fromMap({
      "productName": fields['name'],
      "salesRate": fields['salesRate'],
      "purchaseRate": fields['purchaseRate'],
      "quantity": fields['quantity'],
      "unit": fields['unit'],
      "duration": fields['duration'],
      "fromDate": DateFormat('yyyy-MM-dd').format(fields['fromDate']),
      "toDate": DateFormat('yyyy-MM-dd').format(fields['toDate']),
      "productImage": _imageFile != null ? d.MultipartFile.fromFileSync(_imageFile!.path) : null,
    });
  }

  // Pick an image from the gallery or camera
  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      BlocProvider.of<CreateProductBloc>(context).add(
        CreateProductRequested(formData: _buildFormData(_formKey.currentState?.fields.map((key, value) => MapEntry(key, value.value)) ?? {})),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FormBuilder(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20),

              // Product Name Field
              FormBuilderTextField(
                name: 'name',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                initialValue: 'Product Alpha',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid product name.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Product Name **',
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),

              // Sales Rate Field
              FormBuilderTextField(
                name: 'salesRate',
                initialValue: '500',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter sales rate.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Sales Rate **',
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),

              // Purchase Rate Field
              FormBuilderTextField(
                name: 'purchaseRate',
                initialValue: '400',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter purchase rate.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Purchase Rate **',
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),

              // Quantity Field
              FormBuilderTextField(
                name: 'quantity',
                initialValue: '100',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter quantity.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Quantity **',
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),

              // Unit Field
              FormBuilderTextField(
                name: 'unit',
                initialValue: 'kg',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter unit.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Unit **',
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),

              // Duration Field
              FormBuilderTextField(
                name: 'duration',
                initialValue: 'monthly',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter duration.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Duration **',
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),

              // From Date Picker
              FormBuilderDateTimePicker(
                name: 'fromDate',
                initialValue: DateTime.now(),
                inputType: InputType.date,
                validator: (value) {
                  if (value == null) {
                    return 'Please select a from date.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'From Date **',
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
                ),
              ),
              const SizedBox(height: 20),

              // To Date Picker
              FormBuilderDateTimePicker(
                name: 'toDate',
                initialValue: DateTime.now(),
                inputType: InputType.date,
                validator: (value) {
                  if (value == null) {
                    return 'Please select a to date.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'To Date **',
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
                ),
              ),
              const SizedBox(height: 20),

              // Product Image Picker
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Product Image',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => _buildImagePickerBottomSheet(context),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                      child: _imageFile == null
                          ? const Icon(Icons.camera_alt, size: 40, color: Colors.white)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 10),
               const   Text(
                    'Tap to change image',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Submit Button
              BlocConsumer<CreateProductBloc, CreateProductState>(
                listener: (context, state) {
                  if (state is CreateProductSuccess) {
                    Fluttertoast.showToast(msg: state.message);
                  } else if (state is CreateProductError) {
                    Fluttertoast.showToast(msg: state.message);
                  }
                },
                builder: (context, state) {
                  if (state is CreateProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        final formData = _buildFormData(_formKey.currentState!.value);
                        context.read<CreateProductBloc>().add(CreateProductRequested(formData: formData));
                      }
                    },
                    child: const Text('Create Product'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Image Picker Bottom Sheet
  Widget _buildImagePickerBottomSheet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 20.0),
            Center(
              child: Container(
                height: 7.0,
                width: 50.0,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
            Container(height: 30),
            ListTile(
              title: const Text('From Gallery 🖼️'),
              onTap: () async {
                await _pickImage(context, ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('From Camera 📷'),
              onTap: () async {
                await _pickImage(context, ImageSource.camera);
                Navigator.pop(context);
              },
            ),
            Container(height: 20),
          ],
        ),
      ),
    );
  }
}