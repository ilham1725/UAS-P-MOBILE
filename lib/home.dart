import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uas_pmobile/posts.dart';
import 'package:uas_pmobile/posts_controller.dart';
import 'package:uas_pmobile/posts_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var postsController = PostsController(PostsRepository());

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Uas P Mobile")),
      ),
      body: FutureBuilder<List<Posts>>(
        future: postsController.fetchPostsList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("error"),
            );
          }

          return buildBodyContent(snapshot, postsController);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Posts posts = Posts(
              userId: 1,
              id: 1,
              title:
                  'sunt aut facere repellat provident occaecati excepturi optio reprehenderit',
              body: 'tambahan');
          postsController.postPosts(posts);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  SafeArea buildBodyContent(
      AsyncSnapshot<List<Posts>> snapshot, PostsController postsController) {
    return SafeArea(
      child: ListView.separated(
          itemBuilder: (context, index) {
            var posts = snapshot.data?[index];

            return Container(
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(children: [
                Expanded(flex: 1, child: Text('${posts?.title}')),
                Expanded(flex: 1, child: Text('${posts?.body}')),
                Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                            onTap: () {
                              postsController
                                  .updatePatchCompleted(posts!)
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        duration: Duration(milliseconds: 500),
                                        content: Text('$value')));
                              });
                            },
                            child: buildCallContainer(
                                'patch', Colors.amberAccent)),
                        InkWell(
                            onTap: () {
                              postsController.updatePutCompleted(posts!);
                            },
                            child:
                                buildCallContainer('put', Colors.orangeAccent)),
                        InkWell(
                            onTap: () {
                              postsController.deletePosts(posts!).then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        duration: Duration(milliseconds: 500),
                                        content: Text('$value')));
                              });
                            },
                            child: buildCallContainer('del', Colors.redAccent))
                      ],
                    )),
              ]),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 0.6,
              height: 5,
            );
          },
          itemCount: snapshot.data?.length ?? 0),
    );
  }

  Container buildCallContainer(String title, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Center(child: Text('$title')),
    );
  }
}
