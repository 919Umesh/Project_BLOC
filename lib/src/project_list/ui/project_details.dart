import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/project_list_model.dart';

class ProjectDetailsPage extends StatefulWidget {
  final ProjectModel projectModel;
  const ProjectDetailsPage({super.key, required this.projectModel});

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final project = widget.projectModel;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(project),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildStatusCard(project),
                  const SizedBox(height: 16),
                  _buildDetailsCard(project),
                  const SizedBox(height: 16),
                  _buildTeamSection(project),
                  const SizedBox(height: 16),
                  _buildActionButtons(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(ProjectModel project) {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.blue[600],
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          project.name,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue[400]!, Colors.blue[800]!],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -50,
                top: -50,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard(ProjectModel project) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: project.status.toLowerCase() == 'completed'
                ? [Colors.green[100]!, Colors.green[50]!]
                : [Colors.orange[100]!, Colors.orange[50]!],
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Bootstrap.check2_circle,
                color: project.status.toLowerCase() == 'completed'
                    ? Colors.green
                    : Colors.orange,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Project Status',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    project.status,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: project.status.toLowerCase() == 'completed'
                          ? Colors.green[700]
                          : Colors.orange[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard(ProjectModel project) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Project Details',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildDetailRow(
              icon: Bootstrap.geo_alt,
              iconColor: Colors.blue[600]!,
              label: 'Location',
              value: project.location,
            ),
            const Divider(height: 24),
            _buildDetailRow(
              icon: Bootstrap.clock_history,
              iconColor: Colors.orange[600]!,
              label: 'Duration',
              value: project.duration,
            ),
            const Divider(height: 24),
            _buildDetailRow(
              icon: Bootstrap.currency_dollar,
              iconColor: Colors.green[600]!,
              label: 'Budget',
              value: '\$${project.amount}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTeamSection(ProjectModel project) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Team Members',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${project.members} members',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Add team members list or grid here
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => Fluttertoast.showToast(msg: "Project Updated"),
            icon: const Icon(Bootstrap.pencil_square),
            label: Text(
              "Edit Project",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () => Fluttertoast.showToast(msg: "Sharing project details..."),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[200],
            foregroundColor: Colors.grey[800],
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Icon(Bootstrap.share),
        ),
      ],
    );
  }
}