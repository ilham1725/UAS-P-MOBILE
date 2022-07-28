import 'package:uas_pmobile/posts.dart';
import 'package:uas_pmobile/repository.dart';

class PostsController {
  final Repository _repository;

  PostsController(this._repository);

  Future<List<Posts>> fetchPostsList() async {
    return _repository.getData();
  }

  Future<String?> updatePatchCompleted(Posts posts) async {
    return _repository.patchData(posts);
  }

  Future<String?> updatePutCompleted(Posts posts) async {
    return _repository.putData(posts);
  }

  Future<String?> deletePosts(Posts posts) async {
    return _repository.deleteData(posts);
  }

  Future<String?> postPosts(Posts posts) async {
    return _repository.postData(posts);
  }
}
