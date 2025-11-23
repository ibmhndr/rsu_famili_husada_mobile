abstract class ApiGet {
  //Get data result future
  getData(Map<String, dynamic> data);
  //parse result into list of object
  parseResult(responseBody);
}