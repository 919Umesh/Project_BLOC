import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:project_bloc/src/product_list/bloc/product_list_bloc.dart';
import 'package:project_bloc/src/product_list/bloc/product_list_state.dart';
import 'package:project_bloc/src/user_list/bloc/user_list_bloc.dart';

import '../../../core/extensions/shimmer_effect.dart';
import '../bloc/product_list_event.dart';
import 'app_bar.dart';

class LedgerFormPage extends StatefulWidget {
  const LedgerFormPage({super.key});

  @override
  State<LedgerFormPage> createState() => _LedgerFormPageState();
}

class _LedgerFormPageState extends State<LedgerFormPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  String? selectedUserId;
  String? selectedProductId;

  @override
  void initState() {
    super.initState();
    context.read<UserListBloc>().add(LoadUsersRequested());
    context.read<UserListBloc>().add(UserNameRequested());
    context.read<ProductListBloc>().add(ProductListRequested());
  }

  void _onSubmit() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState!.value;
      debugPrint('--------- Form Fields ------');
      _formKey.currentState!.fields.forEach((key, field) {
        debugPrint('$key: ${field.value}');
      });
      debugPrint('Form Data: $formData');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Ledger Entry',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AppBarPage()));
              },
              icon: const Icon(Bootstrap.activity))
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              BlocBuilder<UserListBloc, UserListState>(
                builder: (context, state) {
                  if (state is UserNameLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is UserNameLoadSuccess) {
                    return FormBuilderDropdown<String>(
                      name: 'user_id',
                      decoration: InputDecoration(
                        labelText: 'Select User',
                        labelStyle: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                      initialValue: selectedUserId,
                      items: state.userList.map((user) {
                        return DropdownMenuItem<String>(
                          value: user.id,
                          child: Text(
                            user.name,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Please select a user',
                        ),
                      ]),
                      onChanged: (value) {
                        setState(() {
                          selectedUserId = value;
                        });
                      },
                    );
                  } else if (state is UserNameLoadError) {
                    return Center(
                      child: Text(
                        'Error: ${state.nameErrorMessage}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'amount',
                decoration: InputDecoration(
                  labelText: 'Amount',
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixText: '\$',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'Please enter an amount',
                  ),
                  FormBuilderValidators.numeric(
                    errorText: 'Please enter a valid number',
                  ),
                  FormBuilderValidators.min(
                    0.01,
                    errorText: 'Amount must be greater than 0',
                  ),
                ]),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'description',
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                maxLines: 3,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'Please enter a description',
                  ),
                  FormBuilderValidators.minLength(
                    10,
                    errorText: 'Description must be at least 10 characters',
                  ),
                ]),
              ),
              const SizedBox(height: 16),
              BlocBuilder<ProductListBloc, ProductListState>(
                builder: (context, state) {
                  if (state is ProductListLoading) {
                    return const ShimmerEffect(
                        width: double.infinity, height: 50, borderRadius: 8);
                  } else if (state is ProductListSuccess) {
                    return FormBuilderDropdown<String>(
                      name: 'product_id',
                      decoration: InputDecoration(
                        labelText: 'Select Product',
                        labelStyle: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                      initialValue: selectedProductId,
                      items: state.products.map((product) {
                        return DropdownMenuItem<String>(
                          value: product.id,
                          child: Text(
                            product.name,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Please select a product',
                        ),
                      ]),
                      onChanged: (value) {
                        setState(() {
                          selectedProductId = value;
                        });
                      },
                    );
                  } else if (state is ProductListFailure) {
                    return Center(
                      child: Text(
                        'Error: ${state.errorMessage}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
              FormBuilderRadioGroup(
                name: 'first_option',
                options: const [
                  FormBuilderFieldOption(value: 'Male'),
                  FormBuilderFieldOption(value: 'Female'),
                ],
              ),
              FormBuilderChoiceChip(
                name: 'first_choice',
                options: const [
                  FormBuilderChipOption(
                      value: 'Choice 1', child: Text('Choice 1')),
                  FormBuilderChipOption(
                      value: 'Choice 2', child: Text('Choice 2')),
                ],
              ),
              BlocBuilder<UserListBloc, UserListState>(
                builder: (context, state) {
                  if (state is UserNameLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is UserNameLoadSuccess) {
                    return FormBuilderFilterChip(
                      name: 'first_filter',
                      decoration: const InputDecoration(
                        labelText: 'Select Filters',
                        border: InputBorder.none,
                      ),
                      spacing: 8.0,
                      runSpacing: 8.0,
                      selectedColor: Colors.blue,
                      backgroundColor: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Colors.blue),
                      ),
                      labelStyle: const TextStyle(color: Colors.black),
                      options: state.userList.map((users) {
                        return FormBuilderChipOption(
                          value: users.id, // Use dynamic values
                          child: Text(
                              users.name), // Display product name dynamically
                        );
                      }).toList(),
                    );
                  } else if (state is UserListLoadError) {
                    return Center(
                      child: Text(
                        'Error: ${state.errorMessage}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 16),
              FormBuilderSwitch(
                name: 'enable_feature',
                title: const Text('Enable Feature'),
                initialValue: false,
                // Default value
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                activeColor: Colors.blue,
                // Color when switched on
                inactiveThumbColor: Colors.grey,
                // Color when switched off
                inactiveTrackColor: Colors.grey[300],
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'This field is required',
                  ),
                ]),
                onChanged: (value) {
                  debugPrint('Switch Value: $value');
                },
              ),
              const SizedBox(height: 10),
              FormBuilderCheckbox(
                name: 'agree_terms',
                title: const Text('I agree to the terms and conditions'),
                initialValue: false,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                validator: FormBuilderValidators.equal(
                  true,
                  errorText: 'You must accept terms and conditions to continue',
                ),
                onChanged: (value) {
                  debugPrint('Checkbox value: $value');
                },
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Create Ledger Entry',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
