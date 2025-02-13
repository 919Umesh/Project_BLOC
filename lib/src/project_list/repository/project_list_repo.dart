import 'package:project_bloc/app/constant/api_endpoints.dart';
import 'package:project_bloc/src/project_list/model/project_list_model.dart';
import '../../../../core/core.dart';

class ProjectListRepository {
  static Future<List<ProjectModel>> getProjectList(
      {required String status}) async {
    try {
      var response = await apiProvider.getAPI(
          endPoint: ApiEndpoints.getProjectList,
          queryParams: {
            'status': status
          });
      ProjectResponseModel projectResponse = ProjectResponseModel.fromJson(
          response);
      if (projectResponse.status == 200) {
        return projectResponse.projects;
      } else {
        throw Exception(projectResponse.message);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

