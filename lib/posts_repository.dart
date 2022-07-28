import 'dart:convert';

import 'package:uas_pmobile/posts.dart';
import 'package:uas_pmobile/repository.dart';
import 'package:http/http.dart' as http;

class PostsRepository implements Repository {
  String dataURL = 'https://jsonplaceholder.typicode.com';

  @override
  Future<String?> deleteData(Posts posts) async {
    var url = Uri.parse('$dataURL/posts/${posts.id}');
    var result = '';
    await http.delete(url).then((value) {
      print(value.statusCode);
      return value.body;
      // Done
    });
  }

  @override
  Future<List<Posts>> getData() async {
    List<Posts> postsList = [];
    var url = Uri.parse('$dataURL/posts');
    var response = await http.get(url);
    print('status code : ${response.statusCode}');
    var body = json.decode(response.body);
    for (var i = 0; i < body.length; i++) {
      postsList.add(Posts.fromJson(body[i]));
    }
    return postsList;
  }

  @override
  Future<String?> patchData(Posts posts) async {
    var url = Uri.parse('$dataURL/posts/${posts.id}');
    String? result = '';
    await http.patch(
      url,
      body: {'title': posts.title},
      headers: {
        'Authorization': 'your_token',
      },
    ).then((response) {
      Map<String, dynamic> result = json.decode(response.body);
      print(response.statusCode);
      return result['title'];
      // done
    });
  }

  @override
  Future<String?> putData(Posts posts) async {
    var url = Uri.parse('$dataURL/posts/${posts.id}');
    String? resData = '';
    await http.put(
      url,
      body: {'title': posts.title},
      headers: {
        'Authorization': 'your_token',
      },
    ).then((response) {
      Map<String, dynamic> result = json.decode(response.body);
      print(response.statusCode);
      return result['title'];
      // done
    });
  }

  @override
  Future<String?> postData(Posts posts) async {
    // print('${posts.toJson()}');
    var url = Uri.parse('$dataURL/posts/');
    var result = '';
    var response = await http.post(url, body: posts.title);
    print(response.statusCode);
    // done
  }
}
