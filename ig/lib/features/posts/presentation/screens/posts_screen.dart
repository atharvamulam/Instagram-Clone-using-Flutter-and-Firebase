import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ig/core/screens/error_screen.dart';
import 'package:ig/core/screens/loader.dart';
import 'package:ig/features/posts/presentation/widgets/make_post_widget.dart';
import 'package:ig/features/posts/presentation/widgets/post_tile.dart';
import 'package:ig/features/providers/get_all_posts_provider.dart';

class PostssScreen extends StatelessWidget {
  const PostssScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        PostsList(),
      ],
    );
  }
}


class PostsList extends ConsumerWidget {
  const PostsList({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final posts = ref.watch(getAllPostsProvider);
    return posts.when(
      data: (postsList){
        return SliverList.separated(
          itemCount: postsList.length,
          separatorBuilder: (context,index)=> const SizedBox(height: 8,),
          itemBuilder: (context,index){
            final post = postsList.elementAt(index);
            return PostTile(post:post);
          }, 
          );
      }, 
    error: ((error, stackTrace){
      return SliverToBoxAdapter(
        child: ErrorScreen(error: error.toString(),),
      );
    }), 
    loading: (){
      return SliverToBoxAdapter(
        child: Loader(),
      );
    });
  }
}