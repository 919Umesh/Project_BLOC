import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:project_bloc/src/project_list/ui/wrapper/complete_page.dart';
import 'package:project_bloc/src/project_list/ui/wrapper/in_progress.dart';
import 'package:project_bloc/src/project_list/ui/wrapper/pending_page.dart';
import '../../../app/routes/route_name.dart';
import '../../../core/widgets/showAlert.dart';
import '../../datetime_picker/bloc/datetime_bloc.dart';
import '../../datetime_picker/ui/datetime_screen.dart';
import 'drawer_section.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<DatePickerBloc>().add(InitializeDatePicker());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: const DrawerSection(),
      appBar: _buildAppBar(),
      body: TabBarView(
        controller: _tabController,
        children: const [
          PendingProjectsScreen(),
          InProgressProjectsScreen(),
          CompletedProjectsScreen(),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Text(
        "Projects",
        style: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            ShowAlert(context).alert(
              child: DatePickerWidget(
                onConfirm: () async {
                  InitializeDatePicker();
                  final bloc = context.read<DatePickerBloc>();
                  await bloc.onDatePickerConfirm(context);
                },
              ),
            );
          },
          icon: const Icon(Bootstrap.house_add),
        ),
        IconButton(
          onPressed: () =>
              Navigator.pushNamed(context, AppRoute.userListScreenPath),
          icon: const Icon(Bootstrap.person),
        ),
        IconButton(
          onPressed: () => Navigator.pushNamed(
              context, AppRoute.searchProjectListScreenPath),
          icon: const Icon(Bootstrap.search),
        ),
      ],
      backgroundColor: Colors.white,
      bottom: TabBar(
        controller: _tabController,
        indicatorColor: Colors.blue,
        indicatorWeight: 3,
        labelStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.grey,
        tabs: const [
          Tab(text: 'Pending'),
          Tab(text: 'In Progress'),
          Tab(text: 'Complete'),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.pushNamed(context, AppRoute.createProjectScreenPath);
      },
      backgroundColor: Colors.blue,
      icon: const Icon(Icons.add),
      label: Text(
        'New Project',
        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
      ),
    );
  }
}
