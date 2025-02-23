import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../project_list.dart';
import '../reuseable_widget.dart';

class CompletedProjectsScreen extends StatefulWidget {
  const CompletedProjectsScreen({super.key});

  @override
  State<CompletedProjectsScreen> createState() => _CompletedProjectsScreenState();
}

class _CompletedProjectsScreenState extends State<CompletedProjectsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProjectListBloc>().add(LoadProjectRequested(status: 'complete'),);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectListBloc, ProjectListState>(
      builder: (context, state) {
        if (state is ProjectListLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProjectListLoadSuccess) {
          //The reuseable widget is use to show the project list
          return ProjectListView(projectList: state.projects);
        }

        if (state is ProjectListLoadError) {
          return ErrorView(
            message: state.errorMessage,
            onRetry: () => context.read<ProjectListBloc>().add(
               LoadProjectRequested(status: 'complete'),
            ),
          );
        }

        return const Center(child: Text("No data found"));
      },
    );
  }
}
