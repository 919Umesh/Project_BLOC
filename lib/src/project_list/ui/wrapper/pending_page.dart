import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../project_list.dart';
import '../reuseable_widget.dart';

class PendingProjectsScreen extends StatefulWidget {
  const PendingProjectsScreen({super.key});

  @override
  State<PendingProjectsScreen> createState() => _PendingProjectsScreenState();
}

class _PendingProjectsScreenState extends State<PendingProjectsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProjectListBloc>().add(LoadProjectRequested(status: 'pending'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectListBloc, ProjectListState>(
      builder: (context, state) {
        if (state is ProjectListLoading) {
          return  const SizedBox(
            height: 80,
            width: 80,
            child: LoadingIndicator(
              indicatorType: Indicator.ballTrianglePathColored,
              colors: [Colors.blue, Colors.red, Colors.green],
              strokeWidth: 4,
            ),
          );
        }

        if (state is ProjectListLoadSuccess) {
          return ProjectListView(projectList: state.projects);
        }

        if (state is ProjectListLoadError) {
          return ErrorView(
            message: state.errorMessage,
            onRetry: () => context.read<ProjectListBloc>().add(
               LoadProjectRequested(status: 'pending'),
            ),
          );
        }

        return const Center(child: Text("No data found"));
      },
    );
  }
}