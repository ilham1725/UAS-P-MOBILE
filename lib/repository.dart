import 'package:uas_pmobile/posts.dart';

abstract class Repository {
  Future<List<Posts>> getData();

  Future<String?> patchData(Posts posts);

  Future<String?> putData(Posts posts);

  Future<String?> deleteData(Posts posts);

  Future<String?> postData(Posts posts);
}
