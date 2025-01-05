// //CreateProjectScreen
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:multi_select_flutter/multi_select_flutter.dart';
// import 'package:project_bloc/core/extensions/context_ext.dart';
// import 'package:project_bloc/src/create_project/bloc/create_project_bloc.dart';
// import '../../../app/app.dart';
// import '../../../core/core.dart';
//
//
// class CreateProjectScreen extends StatefulWidget {
//   const CreateProjectScreen({super.key});
//
//   @override
//   State<CreateProjectScreen> createState() => _CreateProjectScreenState();
// }
//
// class _CreateProjectScreenState extends State<CreateProjectScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   late String? _name = "",
//       _duration = "",
//       _location = "",
//       _members = "",
//       _amount = "";
//   late final List<String> _status = [];
//   late List<MultiSelectItem<String>> _dropdownItems = [];
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _clearForm();
//     });
//   }
//
//   void _clearForm() {
//     setState(() {
//       _generateDropDownItems();
//       _name = _duration = _location = _members = _amount = null;
//       _status.clear();
//     });
//   }
//
//   void _generateDropDownItems() {
//     final List<String> dropDownList = [
//       "Passenger Car (PC)",
//       "Multi utility Vehicle (MUV)",
//       "Light Commercial Vehicle (LCV)",
//       "Heavy Commercial Vehicle (HCV)",
//     ];
//
//     _dropdownItems = dropDownList
//         .map((indexData) => MultiSelectItem<String>(indexData, indexData))
//         .toList();
//
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<CreateProjectBloc, CreateProjectState>(
//       builder: (BuildContext context, state) {
//         return Stack(
//           children: [
//             Scaffold(
//               appBar: AppBar(title: const Text("Register")),
//               body: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 10.0,
//                     vertical: 20.0,
//                   ),
//                   child: _buildForm(),
//                 ),
//               ),
//             ),
//             if (state is RegisterLoading) LoadingScreen().show(),
//           ],
//         );
//       },
//       listener: (BuildContext context, CreateProjectState state) {
//         if (state is RegisterSuccess) {
//           state.message.successToast();
//           Future.delayed(const Duration(seconds: 0));
//           // Navigator.pushNamed(
//           //   context,
//           //   AppRoute.otpScreen,
//           //   arguments: UpdatePinModel(
//           //     phoneNumber: _userName ?? "",
//           //     password: _password ?? "",
//           //     confirmPassword: _password ?? "",
//           //     pinFromEnum: PinFromEnum.register,
//           //   ),
//           // );
//         }
//         if (state is RegisterError) {
//           state.message.errorToast();
//         }
//       },
//     );
//   }
//
//   Widget _buildForm() {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           CustomTextFromField(
//             labelText: "Login Mobile No",
//             hintText: 'Login Mobile No',
//             onSaved: (value) => _name = value,
//             keyboardType: TextInputType.number,
//             maxLenght: 10,
//             onChanged: (value) {
//               _formKey.currentState!.validate();
//               _name = value;
//               setState(() {});
//             },
//             validator: (value) => value!.numberValidation(),
//           ),
//
//           ///
//           ///
//           ///
//           CustomTextFromField(
//             labelText: "Password",
//             hintText: 'Password',
//             // controller: registerPassword,
//             onSaved: (value) {
//               _duration = value;
//             },
//             onChanged: (value) {
//               _formKey.currentState!.validate();
//             },
//             validator: (value) => value.passwordValidation(),
//           ),
//
//           CustomTextFromField(
//             labelText: "Machanic Full Name",
//             hintText: 'Machanic Full Name',
//             // controller: machanicName,
//             onSaved: (value) {
//               _location = value;
//             },
//             onChanged: (value) {
//               _formKey.currentState!.validate();
//             },
//             validator: (value) => value.required(),
//           ),
//           rowWidget(
//             childOne: CustomTextFromField(
//               labelText: "Address",
//               hintText: 'Address',
//               // controller: address,
//               onSaved: (value) {
//                 _members = value;
//               },
//               onChanged: (value) {
//                 _formKey.currentState!.validate();
//               },
//               // validator: (value) => value.required(),
//             ),
//             childTwo: CustomTextFromField(
//               labelText: "City",
//               hintText: 'City',
//               // controller: city,
//               onSaved: (value) {
//                 _amount = value;
//               },
//               onChanged: (value) {
//                 _formKey.currentState!.validate();
//               },
//               // validator: (value) => value.required(),
//             ),
//           ),
//           const Text(
//             "Vehicle Type",
//             style: kTitleTextBold,
//             textAlign: TextAlign.left,
//           ),
//           MultiSelectDialogField<String>(
//             items: _dropdownItems,
//             title: const Text("Vehicle Type"),
//             selectedColor: kPrimaryColor,
//             decoration: ContainerDecoration.decoration(
//               color: kTextFormFieldColor,
//               borderRadius: BorderRadius.circular(15.0),
//             ),
//             buttonIcon: const Icon(Icons.arrow_drop_down_rounded),
//             buttonText: Text("Vehicle Type", style: kHintText),
//             chipDisplay: MultiSelectChipDisplay(
//               textStyle: kMenuTitleText.copyWith(fontSize: 11.0),
//               chipColor: kPrimaryColor.withOpacity(.2),
//             ),
//             onConfirm: (results) {
//               _vehicleTypes = results;
//               _formKey.currentState!.validate();
//             },
//             validator: (values) {
//               if (values == null || values.isEmpty) {
//                 return "* Required";
//               }
//               return null;
//             },
//             dialogHeight: context.screenHeight / 2,
//             dialogWidth: context.screenWidth * .8,
//           ),
//           CustomButton(
//             onTap: _onSignIn,
//             text: 'Sign In',
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _onSignIn() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       BlocProvider.of<CreateProjectBloc>(context).add(
//         ProjectCreateRequested(
//             name: '',
//             duration: '',
//             location: '',
//             members: '', amount: '',
//             status: []
//         ),
//       );
//     } else {
//       Fluttertoast.showToast(msg: "Validation ERROR");
//       debugPrint("Validation ERROR");
//     }
//   }
//
//   Widget rowWidget({required Widget childOne, required Widget childTwo}) {
//     return Row(children: [
//       Expanded(child: childOne),
//       10.pWidth,
//       Expanded(child: childTwo),
//     ]);
//   }
// }
//


// create_project_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:project_bloc/src/create_project/bloc/create_project_bloc.dart';
import '../../../core/core.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _name, _duration, _location, _members, _amount;
  List<String> _vehicleTypes = [];
  late List<MultiSelectItem<String>> _dropdownItems = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _clearForm();
    });
  }

  void _clearForm() {
    setState(() {
      _generateDropDownItems();
      _name = _duration = _location = _members = _amount = null;
      _vehicleTypes = [];
    });
  }

  void _generateDropDownItems() {
    final List<String> dropDownList = [
      "Passenger Car (PC)",
      "Multi utility Vehicle (MUV)",
      "Light Commercial Vehicle (LCV)",
      "Heavy Commercial Vehicle (HCV)",
    ];

    _dropdownItems = dropDownList
        .map((indexData) => MultiSelectItem<String>(indexData, indexData))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateProjectBloc, CreateProjectState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          state.message.successToast();
          _clearForm();
        }
        if (state is RegisterError) {
          state.message.errorToast();
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(title: const Text("Create Project")),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _buildForm(),
                ),
              ),
            ),
            if (state is RegisterLoading) const Center(child: CircularProgressIndicator(),),
          ],
        );
      },
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextFromField(
            labelText: "Project Name",
            hintText: "Enter project name",
            onSaved: (value) => _name = value,
            validator: (value) => value?.required(),
          ),
          const SizedBox(height: 16),
          CustomTextFromField(
            labelText: "Duration",
            hintText: "Enter project duration",
            onSaved: (value) => _duration = value,
            validator: (value) => value?.required(),
          ),
          const SizedBox(height: 16),
          CustomTextFromField(
            labelText: "Location",
            hintText: "Enter project location",
            onSaved: (value) => _location = value,
            validator: (value) => value?.required(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: CustomTextFromField(
                  labelText: "Members",
                  hintText: "Number of members",
                  onSaved: (value) => _members = value,
                  keyboardType: TextInputType.number,
                  validator: (value) => value?.required(),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomTextFromField(
                  labelText: "Amount",
                  hintText: "Project budget",
                  onSaved: (value) => _amount = value,
                  keyboardType: TextInputType.number,
                  validator: (value) => value?.required(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Vehicle Types",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          MultiSelectDialogField<String>(
            items: _dropdownItems,
            title: const Text("Select Vehicle Types"),
            selectedColor: Theme.of(context).primaryColor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            buttonText: const Text("Select Vehicle Types"),
            onConfirm: (values) {
              setState(() => _vehicleTypes = values);
            },
            validator: (values) =>
            (values?.isEmpty ?? true) ? "Please select vehicle types" : null,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text("Create Project"),
          ),
        ],
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
          status: _vehicleTypes,
        ),
      );
    } else {
      Fluttertoast.showToast(msg: "Please fill all required fields");
    }
  }
}