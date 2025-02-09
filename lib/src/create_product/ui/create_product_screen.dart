// import 'dart:io';
// import 'package:dio/dio.dart' as d;
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../core/extensions/image_picker.dart';
// import '../bloc/create_product_bloc.dart';
// import '../bloc/create_product_event.dart';
// import '../bloc/create_product_state.dart';
//
// class CreateProductScreen extends StatefulWidget {
//   const CreateProductScreen({super.key});
//
//   @override
//   State createState() => _CreateProductScreenState();
// }
//
// class _CreateProductScreenState extends State<CreateProductScreen> {
//   final _formKeyProduct = GlobalKey<FormBuilderState>();
//
//   File? _imageFile;
//   // final List<String> _categories = [
//   //   'Electronics',
//   //   'Clothing',
//   //   'Books',
//   //   'Food',
//   //   'Other',
//   //   'Furniture',
//   //   'Toys'
//   // ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Create Product'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: FormBuilder(
//           key: _formKeyProduct,
//           child: ListView(
//             children: [
//               const SizedBox(height: 20),
//               FormBuilderTextField(
//                 name: 'name',
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 initialValue: 'Product Alpha',
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a valid product name.';
//                   }
//                   return null;
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'Product Name **',
//                   contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
//                 ),
//                 keyboardType: TextInputType.text,
//               ),
//               const SizedBox(height: 20),
//               // Sales Rate Field
//               FormBuilderTextField(
//                 name: 'salesRate',
//                 initialValue: '500',
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter sales rate.';
//                   }
//                   if (double.tryParse(value) == null) {
//                     return 'Please enter a valid number.';
//                   }
//                   return null;
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'Sales Rate **',
//                   contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
//                 ),
//                 keyboardType: TextInputType.number,
//               ),
//               const SizedBox(height: 20),
//               // FormBuilderDropdown(
//               //   name: 'category',
//               //   decoration: InputDecoration(
//               //     labelText: 'Category **',
//               //     contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
//               //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
//               //   ),
//               //   validator: (value) {
//               //     if (value == null) {
//               //       return 'Please select a category.';
//               //     }
//               //     return null;
//               //   },
//               //   items: _categories
//               //       .map((category) => DropdownMenuItem(
//               //     value: category,
//               //     child: Text(category),
//               //   ))
//               //       .toList(),
//               // ),
//               // const SizedBox(height: 20),
//               // SearchChoices.single(
//               //   displayClearIcon: true,
//               //   hint: const Text('Select a category'),
//               //   value: _categories[0],
//               //   menuBackgroundColor: Colors.white,
//               //   icon: const Icon(Icons.arrow_drop_down),
//               //   underline: Container(
//               //     height: 1,
//               //     color: Colors.grey,
//               //   ),
//               //   isExpanded: true,
//               //   items: _categories
//               //       .map((category) => DropdownMenuItem(
//               //     value: category,
//               //     child: Text(category),
//               //   )).toList(),
//               //   onChanged: (value) {
//               //     _formKeyProduct.currentState?.fields['category']?.didChange(value);
//               //   },
//               //   selectedValueWidgetFn: (item) {
//               //     return Text(item.toString());
//               //   },
//               //   dialogBox: true,
//               //   keyboardType: TextInputType.text,
//               //   searchHint: const Text('Search categories...'),
//               //   validator: (value) {
//               //     if (value == null) {
//               //       return 'Please select a category.';
//               //     }
//               //     return null;
//               //   },
//               // ),
//               // const SizedBox(height: 20),
//               FormBuilderTextField(
//                 name: 'purchaseRate',
//                 initialValue: '400',
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter purchase rate.';
//                   }
//                   if (double.tryParse(value) == null) {
//                     return 'Please enter a valid number.';
//                   }
//                   return null;
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'Purchase Rate **',
//                   contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
//                 ),
//                 keyboardType: TextInputType.number,
//               ),
//               const SizedBox(height: 20),
//               // Quantity Field
//               FormBuilderTextField(
//                 name: 'quantity',
//                 initialValue: '100',
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter quantity.';
//                   }
//                   if (double.tryParse(value) == null) {
//                     return 'Please enter a valid number.';
//                   }
//                   return null;
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'Quantity **',
//                   contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
//                 ),
//                 keyboardType: TextInputType.number,
//               ),
//               const SizedBox(height: 20),
//               // Unit Field
//               FormBuilderTextField(
//                 name: 'unit',
//                 initialValue: 'kg',
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter unit.';
//                   }
//                   return null;
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'Unit **',
//                   contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
//                 ),
//                 keyboardType: TextInputType.text,
//               ),
//               const SizedBox(height: 20),
//               FormBuilderTextField(
//                 name: 'duration',
//                 initialValue: 'Monthly',
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter quantity.';
//                   }
//                   return null;
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'Duration **',
//                   contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
//                 ),
//               ),
//               // From Date Picker
//               const SizedBox(height: 20),
//               FormBuilderDateTimePicker(
//                 name: 'fromDate',
//                 initialValue: DateTime.now(),
//                 inputType: InputType.date,
//                 validator: (value) {
//                   if (value == null) {
//                     return 'Please select a from date.';
//                   }
//                   return null;
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'From Date **',
//                   contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               // To Date Picker
//               FormBuilderDateTimePicker(
//                 name: 'toDate',
//                 initialValue: DateTime.now(),
//                 inputType: InputType.date,
//                 validator: (value) {
//                   if (value == null) {
//                     return 'Please select a to date.';
//                   }
//                   return null;
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'To Date **',
//                   contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               // Product Image Picker
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Product Image',
//                     style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   ImagePickerWidget(
//                     onImageSelected: (file) {
//                       setState(() {
//                         _imageFile = file;
//                       });
//                     },
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     'Tap to change image',
//                     style: TextStyle(color: Colors.blue),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               // Submit Button
//               BlocConsumer<CreateProductBloc, CreateProductState>(
//                 listener: (context, state) {
//                   if (state is CreateProductSuccess) {
//                     Fluttertoast.showToast(msg: state.message);
//                   } else if (state is CreateProductError) {
//                     Fluttertoast.showToast(msg: state.message);
//                   }
//                 },
//                 builder: (context, state) {
//                   if (state is CreateProductLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   return ElevatedButton(
//                     onPressed: () async {
//                       if (_formKeyProduct.currentState?.saveAndValidate() ?? false) {
//                         final formData = d.FormData.fromMap({
//                           ..._formKeyProduct.currentState!.value,
//                           if (_imageFile != null) 'productImage': await d.MultipartFile.fromFile(_imageFile!.path),
//                         });
//                         BlocProvider.of<CreateProductBloc>(context,listen: false).add(CreateProductRequested(formData: formData));
//                       }
//                     },
//                     child: const Text('Create Product'),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  Widget _buildFormField({
    required String name,
    required String label,
    String? initialValue,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    Widget? suffix,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: FormBuilderTextField(
        name: name,
        initialValue: initialValue,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator ?? (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontFamily: 'inter',
          ),
          suffixIcon: suffix,
          filled: true,
          fillColor: Colors.grey[50],
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
        keyboardType: keyboardType,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: const Text(
          'Create Product',
          style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'inter'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKeyProduct,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Picker Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  children: [
                    ImagePickerWidget(
                      onImageSelected: (file) {
                        setState(() {
                          _imageFile = file;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Tap to change product image',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'inter',
                      ),
                    ),
                  ],
                ),
              ),

              // Form Fields
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Product Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'inter',
                      ),
                    ),
                    const SizedBox(height: 24),

                    _buildFormField(
                      name: 'name',
                      label: 'Product Name',
                      initialValue: 'Product Alpha',
                      suffix: const Icon(Icons.inventory_2_outlined),
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: _buildFormField(
                            name: 'salesRate',
                            label: 'Sales Rate',
                            initialValue: '500',
                            keyboardType: TextInputType.number,
                            suffix: const Icon(Icons.attach_money),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildFormField(
                            name: 'purchaseRate',
                            label: 'Purchase Rate',
                            initialValue: '400',
                            keyboardType: TextInputType.number,
                            suffix: const Icon(Icons.shopping_cart_outlined),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: _buildFormField(
                            name: 'quantity',
                            label: 'Quantity',
                            initialValue: '100',
                            keyboardType: TextInputType.number,
                            suffix: const Icon(Icons.numbers),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildFormField(
                            name: 'unit',
                            label: 'Unit',
                            initialValue: 'kg',
                            suffix: const Icon(Icons.scale_outlined),
                          ),
                        ),
                      ],
                    ),

                    _buildFormField(
                      name: 'duration',
                      label: 'Duration',
                      initialValue: 'Monthly',
                      suffix: const Icon(Icons.timer_outlined),
                    ),

                    const Text(
                      'Validity Period',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[50],
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          FormBuilderDateTimePicker(
                            name: 'fromDate',
                            initialValue: DateTime.now(),
                            inputType: InputType.date,
                            decoration: InputDecoration(
                              labelText: 'From Date',
                              prefixIcon: const Icon(Icons.calendar_today),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          FormBuilderDateTimePicker(
                            name: 'toDate',
                            initialValue: DateTime.now(),
                            inputType: InputType.date,
                            decoration: InputDecoration(
                              labelText: 'To Date',
                              prefixIcon: const Icon(Icons.calendar_today),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),
                    BlocConsumer<CreateProductBloc, CreateProductState>(
                      listener: (context, state) {
                        if (state is CreateProductSuccess) {
                          Fluttertoast.showToast(
                            msg: state.message,
                            backgroundColor: Colors.green,
                          );
                        } else if (state is CreateProductError) {
                          Fluttertoast.showToast(
                            msg: state.message,
                            backgroundColor: Colors.red,
                          );
                        }
                      },
                      builder: (context, state) {
                        return Container(
                          width: double.infinity,
                          height: 56,
                          margin: const EdgeInsets.only(bottom: 24),
                          child: ElevatedButton(
                            onPressed: state is CreateProductLoading
                                ? null
                                : () async {
                              if (_formKeyProduct.currentState?.saveAndValidate() ?? false) {
                                final formData = d.FormData.fromMap({
                                  ..._formKeyProduct.currentState!.value,
                                  if (_imageFile != null)
                                    'productImage': await d.MultipartFile.fromFile(_imageFile!.path),
                                });
                                BlocProvider.of<CreateProductBloc>(context, listen: false)
                                    .add(CreateProductRequested(formData: formData));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: state is CreateProductLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text(
                              'Create Product',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'inter',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}