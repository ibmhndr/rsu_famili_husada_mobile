abstract class ApiPost {
  //POST data result future
  postData(Map<String, dynamic> data);
  //parse result into list of object
  parseResult(responseBody);
}