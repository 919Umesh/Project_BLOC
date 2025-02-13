import 'package:project_bloc/app/constant/api_endpoints.dart';

import '../../../core/services/api/api_helper.dart';
import '../../project_list/model/project_list_model.dart';

class ProjectSearchRepository {
  static Future<List<ProjectModel>> searchProjects(
      {required String query}) async {
    try {
      var response = await apiProvider.getAPI(
          endPoint: ApiEndpoints.getSearchList, queryParams: {'name': query});
      ProjectResponseModel projectResponse =
      ProjectResponseModel.fromJson(response);
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
