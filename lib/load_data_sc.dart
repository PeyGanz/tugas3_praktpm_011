import 'base_network.dart';
class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();
  //untuk list kategori
  Future<Map<String, dynamic>> loadCategories() {
    return BaseNetwork.get("categories.php");
  }

  //untuk list meal
  Future<Map<String, dynamic>> loadMeals(String category) {
    return BaseNetwork.get("filter.php?c=$category");
  }

  //untuk detail meal
    Future<Map<String, dynamic>> loadDetails(String idmeal){
      return BaseNetwork.get("lookup.php?i=$idmeal");
  }
}
