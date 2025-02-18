import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_bloc/core/core.dart';
import 'package:project_bloc/src/user_list/bloc/user_list_bloc.dart';
import '../../../app/themes/colors.dart';
import '../../../core/widgets/custom_dropdown.dart';
import '../../user_list/model/user_list_model.dart';
import '../bloc/create_project_bloc.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _name, _duration, _location, _members, _amount, _status;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _clearForm();
    });
  }

  void _clearForm() {
    setState(() {
      _name = _duration = _location = _members = _status = _amount = null;
    });
  }
  String? _selectedUser;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateProjectBloc, CreateProjectState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          state.message.successToast();
          _clearForm();
          Navigator.pop(context);
        }
        if (state is RegisterError) {
          state.message.errorToast();
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.grey[100],
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                title:  Text(
                  "Create Project",
                  style:GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),

                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _buildForm(),
                ),
              ),
            ),
            if (state is RegisterLoading)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildForm() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),
              const SizedBox(height: 32),
              _buildTextField(
                label: "Project Name",
                hint: "Enter project name",
                icon: Icons.work_outline,
                onSaved: (value) => _name = value,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: "Duration",
                hint: "Enter project duration",
                icon: Icons.timer_outlined,
                onSaved: (value) => _duration = value,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: "Location",
                hint: "Enter project location",
                icon: Icons.location_on_outlined,
                onSaved: (value) => _location = value,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: "Members",
                      hint: "Number",
                      icon: Icons.people_outline,
                      keyboardType: TextInputType.number,
                      onSaved: (value) => _members = value,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      label: "Amount",
                      hint: "Budget",
                      icon: Icons.attach_money,
                      keyboardType: TextInputType.number,
                      onSaved: (value) => _amount = value,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildStatusDropdown(),
            // BlocBuilder<UserListBloc, UserListState>(
            //   builder: (context, state) {
            //     if (state is UserListLoadError) {
            //       return const Center(child: Text('Some error occurred'));
            //     }
            //     if (state is UserListLoadSuccess) {
            //       if (state.users.isEmpty) {
            //         return const Center(child: Text('No Users'));
            //       }
            //       return Column(
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.all(16.0),
            //             child: TextField(
            //               controller: TextEditingController(text: _selectedUser ?? ""),
            //               readOnly: true,
            //               decoration: const InputDecoration(
            //                 labelText: "Selected User",
            //                 border: OutlineInputBorder(),
            //               ),
            //             ),
            //           ),
            //           ElevatedButton(
            //             onPressed: () {
            //               _showDropDown(context, state.users);
            //             },
            //             child: const Text("Select User"),
            //           ),
            //         ],
            //       );
            //     }
            //
            //     // Default loading state
            //     return const Center(child: CircularProgressIndicator());
            //   },
            // ),
              const SizedBox(height: 32),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  void _showDropDown(BuildContext context, List<UserModel> userList) {
    List<SelectedListItem<String>> dropdownItems = userList
        .map((user) => SelectedListItem<String>(data: user.name))
        .toList();

    CustomDropDown.show(
      context: context,
      items: dropdownItems,
      onSelected: (selectedItems) {
        setState(() {
          _selectedUser = selectedItems.join(", ");
        });

        Fluttertoast.showToast(
          msg: "Selected: $_selectedUser",
          backgroundColor: Colors.blue,
          textColor: Colors.white,
        );
      },
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Icon(
          Icons.rocket_launch,
          size: 48,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(height: 16),
         Text(
          "Project Details",
           style: GoogleFonts.aBeeZee(
             fontSize: 18,
             color: kPrimaryColor,
             fontWeight: FontWeight.w800,
           ),
        ),
        const SizedBox(height: 8),
         Text(
          "Fill in the information below to create a new project",
           style: GoogleFonts.aBeeZee(
             fontSize: 18,
             fontWeight: FontWeight.w600,
           ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    required Function(String?) onSaved,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
      keyboardType: keyboardType,
      onSaved: onSaved,
      validator: (value) => value?.isEmpty ?? true ? "This field is required" : null,
    );
  }

  Widget _buildStatusDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: "Status",
        prefixIcon: const Icon(Icons.flag_outlined, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),

    value: _status,
      items: ["pending", "in-progress", "complete"]
          .map((status) => DropdownMenuItem(
        value: status,
        child: Text(status),
      ))
          .toList(),
      onChanged: (value) => setState(() => _status = value),
      onSaved: (value) => _status = value,
      validator: (value) => value == null ? "Please select a status" : null,
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submitForm,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
      child:  Text(
        "Create New Project",
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<CreateProjectBloc>().add(
        ProjectCreateRequested(
          name: _name ?? '',
          duration: _duration ?? '',
          location: _location ?? '',
          members: _members ?? '',
          amount: _amount ?? '',
          status: _status ?? '',
        ),
      );
    } else {
      Fluttertoast.showToast(msg: "Please fill all required fields");
    }
  }
}