import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../project_list.dart';
import '../reuseable_widget.dart';

class InProgressProjectsScreen extends StatefulWidget {
  const InProgressProjectsScreen({super.key});

  @override
  State<InProgressProjectsScreen> createState() => _InProgressProjectsScreenState();
}

class _InProgressProjectsScreenState extends State<InProgressProjectsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProjectListBloc>().add(LoadProjectRequested(status: 'in-progress'),);
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
              LoadProjectRequested(status: 'in-progress'),
            ),
          );
        }

        return const Center(child: Text("No data found"));
      },
    );
  }
}