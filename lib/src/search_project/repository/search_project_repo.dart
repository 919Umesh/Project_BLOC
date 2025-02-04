import '../../../core/services/api/api_helper.dart';
import '../../project_list/model/project_list_model.dart';

class ProjectSearchRepository {

  static Future<List<ProjectModel>> searchProjects({required String query}) async {
    try {
      String api = "/project/search?name=$query";
      var response = await apiProvider.getAPI(endPoint: api);
      ProjectResponseModel projectResponse = ProjectResponseModel.fromJson(response);
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