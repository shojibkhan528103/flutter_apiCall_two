import 'dart:convert';

import 'package:flutterapicalltwo/app/data/comment_api_data.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  //TODO: Implement HomeController
  var dataList = <CommentApi>[].obs;
  var isLoading = false.obs;
  var errorMessages = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchComments();
  }

  Future<void> fetchComments() async {
    isLoading(true);
    errorMessages('');

    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        final List<dynamic> jsonData = jsonDecode(response.body);
        dataList.value =
            jsonData.map((data) => CommentApi.fromJson((data))).toList();
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        errorMessages('Failed to load album');
      }
    } catch (e) {
      errorMessages('An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }
}
