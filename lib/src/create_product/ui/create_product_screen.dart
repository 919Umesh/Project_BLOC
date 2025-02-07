import 'dart:io';
import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/extensions/image_picker.dart';
import '../bloc/create_product_bloc.dart';
import '../bloc/create_product_event.dart';
import '../bloc/create_product_state.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final _formKeyProduct = GlobalKey<FormBuilderState>();

  File? _imageFile;
  final List<String> _categories = [
    'Electronics',
    'Clothing',
    'Books',
    'Food',
    'Other',
    'Furniture',
    'Toys'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FormBuilder(
          key: _formKeyProduct,
          child: ListView(
            children: [
              const SizedBox(height: 20),
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
              // FormBuilderDropdown(
              //   name: 'category',
              //   decoration: InputDecoration(
              //     labelText: 'Category **',
              //     contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
              //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
              //   ),
              //   validator: (value) {
              //     if (value == null) {
              //       return 'Please select a category.';
              //     }
              //     return null;
              //   },
              //   items: _categories
              //       .map((category) => DropdownMenuItem(
              //     value: category,
              //     child: Text(category),
              //   ))
              //       .toList(),
              // ),
              // const SizedBox(height: 20),
              // SearchChoices.single(
              //   displayClearIcon: true,
              //   hint: const Text('Select a category'),
              //   value: _categories[0],
              //   menuBackgroundColor: Colors.white,
              //   icon: const Icon(Icons.arrow_drop_down),
              //   underline: Container(
              //     height: 1,
              //     color: Colors.grey,
              //   ),
              //   isExpanded: true,
              //   items: _categories
              //       .map((category) => DropdownMenuItem(
              //     value: category,
              //     child: Text(category),
              //   )).toList(),
              //   onChanged: (value) {
              //     _formKeyProduct.currentState?.fields['category']?.didChange(value);
              //   },
              //   selectedValueWidgetFn: (item) {
              //     return Text(item.toString());
              //   },
              //   dialogBox: true,
              //   keyboardType: TextInputType.text,
              //   searchHint: const Text('Search categories...'),
              //   validator: (value) {
              //     if (value == null) {
              //       return 'Please select a category.';
              //     }
              //     return null;
              //   },
              // ),
              // const SizedBox(height: 20),
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
              FormBuilderTextField(
                name: 'duration',
                initialValue: 'Monthly',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter quantity.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Duration **',
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
                ),
              ),
              // From Date Picker
              const SizedBox(height: 20),
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
                  ImagePickerWidget(
                    onImageSelected: (file) {
                      setState(() {
                        _imageFile = file;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
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
                    onPressed: () async {
                      if (_formKeyProduct.currentState?.saveAndValidate() ?? false) {
                        final formData = d.FormData.fromMap({
                          ..._formKeyProduct.currentState!.value,
                          if (_imageFile != null) 'productImage': await d.MultipartFile.fromFile(_imageFile!.path),
                        });
                        BlocProvider.of<CreateProductBloc>(context,listen: false).add(CreateProductRequested(formData: formData));
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
}