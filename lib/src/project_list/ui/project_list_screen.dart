import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:project_bloc/src/project_list/ui/wrapper/complete_page.dart';
import 'package:project_bloc/src/project_list/ui/wrapper/in_progress.dart';
import 'package:project_bloc/src/project_list/ui/wrapper/pending_page.dart';
import '../../../app/routes/route_name.dart';
import '../../page_tabs/page_wrapper.dart';
import '../bloc/project_list_bloc.dart';
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
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    Fluttertoast.showToast(msg: 'Api');
    final status = _getStatusForIndex(_tabController.index);
    context.read<ProjectListBloc>().add(LoadProjectRequested(status: status));
    return Future.delayed(const Duration(seconds: 1));
  }

  String _getStatusForIndex(int index) {
    switch (index) {
      case 0:
        return 'pending';
      case 1:
        return 'in-progress';
      case 2:
        return 'complete';
      default:
        return 'pending';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: const DrawerSection(),
      appBar: _buildAppBar(),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        child: TabBarView(
          controller: _tabController,
          children: const [
            PendingProjectsScreen(),
            InProgressProjectsScreen(),
            CompletedProjectsScreen(),
          ],
        ),
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
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const PageWrapper()),
          ),
          icon: const Icon(Bootstrap.house),
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
//
// class ProjectListScreen extends StatefulWidget {
//   const ProjectListScreen({super.key});
//
//   @override
//   State<ProjectListScreen> createState() => _ProjectListScreenState();
// }
//
// class _ProjectListScreenState extends State<ProjectListScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
//       GlobalKey<RefreshIndicatorState>();
//
//   final Map<String, List<ProjectModel>> _projectCache = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//
//     _tabController.addListener(() {
//       if (!_tabController.indexIsChanging &&
//           _tabController.animation!.value == _tabController.index) {
//         _loadProjectsForCurrentTab();
//       }
//     });
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _loadProjectsForCurrentTab();
//     });
//   }
//
//   String _getStatusForIndex(int index) {
//     switch (index) {
//       case 0:
//         return 'pending';
//       case 1:
//         return 'in-progress';
//       case 2:
//         return 'complete';
//       default:
//         return 'pending';
//     }
//   }
//
//   Future<void> _loadProjectsForCurrentTab() async {
//     final status = _getStatusForIndex(_tabController.index);
//     if (!_projectCache.containsKey(status)) {
//       context.read<ProjectListBloc>().add(LoadProjectRequested(status: status));
//     }
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       drawer: const DrawerSection(),
//       appBar: _buildAppBar(),
//       body: RefreshIndicator(
//         key: _refreshIndicatorKey,
//         onRefresh: () async {
//           final status = _getStatusForIndex(_tabController.index);
//           _projectCache.remove(status);
//           return _loadProjectsForCurrentTab();
//         },
//         child: BlocConsumer<ProjectListBloc, ProjectListState>(
//           listener: (context, state) {
//             if (state is ProjectListLoadError) {
//               Fluttertoast.showToast(
//                 msg: state.errorMessage,
//                 backgroundColor: Colors.red,
//                 textColor: Colors.white,
//               );
//             } else if (state is ProjectListLoadSuccess) {
//               // Update cache with new data
//               final status = _getStatusForIndex(_tabController.index);
//               _projectCache[status] = state.projects;
//             }
//           },
//           builder: (context, state) {
//             if (state is ProjectListLoading) {
//               return const Center(
//                 child: CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//                 ),
//               );
//             }
//
//             if (state is ProjectListLoadSuccess || _projectCache.isNotEmpty) {
//               return TabBarView(
//                 controller: _tabController,
//                 children: [
//                   _buildProjectListView('pending'),
//                   _buildProjectListView('in-progress'),
//                   _buildProjectListView('complete'),
//                 ],
//               );
//             }
//
//             if (state is ProjectListLoadError) {
//               return ErrorView(
//                 message: state.errorMessage,
//                 onRetry: _loadProjectsForCurrentTab,
//               );
//             }
//
//             return const Center(child: Text("No data found"));
//           },
//         ),
//       ),
//       floatingActionButton: _buildFloatingActionButton(),
//     );
//   }
//
//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       elevation: 0,
//       title: Text(
//         "Projects",
//         style: GoogleFonts.poppins(
//           fontSize: 24,
//           fontWeight: FontWeight.w600,
//           color: Colors.black87,
//         ),
//       ),
//       actions: [
//         IconButton(
//           onPressed: () => Navigator.of(context).push(
//             MaterialPageRoute(builder: (context) => const PageWrapper()),
//           ),
//           icon: const Icon(Bootstrap.house),
//         ),
//         IconButton(
//           onPressed: () =>
//               Navigator.pushNamed(context, AppRoute.userListScreenPath),
//           icon: const Icon(Bootstrap.person),
//         ),
//         IconButton(
//           onPressed: () => Navigator.pushNamed(
//               context, AppRoute.searchProjectListScreenPath),
//           icon: const Icon(Bootstrap.search),
//         ),
//       ],
//       backgroundColor: Colors.white,
//       bottom: TabBar(
//         controller: _tabController,
//         indicatorColor: Colors.blue,
//         indicatorWeight: 3,
//         labelStyle: GoogleFonts.poppins(
//           fontWeight: FontWeight.w600,
//           fontSize: 14,
//         ),
//         unselectedLabelStyle: GoogleFonts.poppins(
//           fontWeight: FontWeight.w500,
//           fontSize: 14,
//         ),
//         labelColor: Colors.blue,
//         unselectedLabelColor: Colors.grey,
//         tabs: const [
//           Tab(text: 'Pending'),
//           Tab(text: 'In Progress'),
//           Tab(text: 'Complete'),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProjectListView(String status) {
//     final projects = _projectCache[status] ?? [];
//     return ProjectListView(projectList: projects);
//   }
//
//   Widget _buildFloatingActionButton() {
//     return FloatingActionButton.extended(
//       onPressed: () {
//         Navigator.pushNamed(context, AppRoute.createProjectScreenPath);
//       },
//       backgroundColor: Colors.blue,
//       icon: const Icon(Icons.add),
//       label: Text(
//         'New Project',
//         style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
//       ),
//     );
//   }
// }

