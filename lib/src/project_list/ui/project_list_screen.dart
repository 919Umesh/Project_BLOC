import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../app/routes/route_name.dart';
import '../bloc/project_list_bloc.dart';
import '../model/project_list_model.dart';
import 'drawer_section.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProjectsForCurrentTab();
    });
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      _loadProjectsForCurrentTab();
    }
  }

  Future<void> _loadProjectsForCurrentTab() async {
    String status;
    switch (_tabController.index) {
      case 0:
        status = 'pending';
        break;
      case 1:
        status = 'in-progress';
        break;
      case 2:
        status = 'complete';
        break;
      default:
        status = 'pending';
    }
    context.read<ProjectListBloc>().add(LoadProjectRequested(status: status));
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: const DrawerSection(),
      appBar: AppBar(
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
          IconButton(onPressed: (){
            Navigator.pushNamed(context, AppRoute.userListScreenPath);
          }, icon: const Icon(Bootstrap.person)),
          IconButton(onPressed: (){
            Navigator.pushNamed(context, AppRoute.searchProjectListScreenPath);
          }, icon: const Icon(Bootstrap.search)),
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
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _loadProjectsForCurrentTab,
        child: BlocConsumer<ProjectListBloc, ProjectListState>(
          listener: (context, state) {
            if (state is ProjectListLoadError) {
              Fluttertoast.showToast(
                msg: state.errorMessage,
                backgroundColor: Colors.red,
                textColor: Colors.white,
              );
            }
          },
          builder: (context, state) {
            if (state is ProjectListLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              );
            }

            if (state is ProjectListLoadSuccess) {
              return TabBarView(
                controller: _tabController,
                children: [
                  _ProjectListView(
                    projectList: state.projects
                        .where((p) => p.status.toLowerCase() == 'pending')
                        .toList(),
                  ),
                  _ProjectListView(
                    projectList: state.projects
                        .where((p) => p.status.toLowerCase() == 'in-progress')
                        .toList(),
                  ),
                  _ProjectListView(
                    projectList: state.projects
                        .where((p) => p.status.toLowerCase() == 'complete')
                        .toList(),
                  ),
                ],
              );
            }

            if (state is ProjectListLoadError) {
              return _ErrorView(
                message: state.errorMessage,
                onRetry: _loadProjectsForCurrentTab,
              );
            }
            return const Center(child: Text("No data found"));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, AppRoute.createProjectScreenPath);
        },
        backgroundColor: Colors.blue,
        icon: const Icon(Icons.add),
        label: Text(
          'New Project',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class _ProjectListView extends StatelessWidget {
  final List<ProjectModel> projectList;

  const _ProjectListView({required this.projectList});

  @override
  Widget build(BuildContext context) {
    if (projectList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/empty_state.png', // Add this image to your assets
              height: 120,
              width: 120,
            ),
            const SizedBox(height: 16),
            Text(
              'No projects found',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: projectList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final project = projectList[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Fluttertoast.showToast(
                msg: "Selected: ${project.name}",
                backgroundColor: Colors.blue,
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          project.name,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      _StatusChip(status: project.status),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _ProjectInfoRow(
                    icon: Icons.access_time,
                    label: 'Duration',
                    value: project.duration,
                  ),
                  const SizedBox(height: 8),
                  _ProjectInfoRow(
                    icon: Icons.location_on,
                    label: 'Location',
                    value: project.location,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ProjectInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ProjectInfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: GoogleFonts.poppins(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'pending':
        backgroundColor = Colors.orange[100]!;
        textColor = Colors.orange[800]!;
        break;
      case 'in-progress':
        backgroundColor = Colors.blue[100]!;
        textColor = Colors.blue[800]!;
        break;
      case 'complete':
        backgroundColor = Colors.green[100]!;
        textColor = Colors.green[800]!;
        break;
      default:
        backgroundColor = Colors.grey[100]!;
        textColor = Colors.grey[800]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: GoogleFonts.poppins(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Retry',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}