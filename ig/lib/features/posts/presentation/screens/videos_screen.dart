import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ig/core/screens/error_screen.dart';
import 'package:ig/core/screens/loader.dart';
import 'package:ig/features/posts/presentation/widgets/post_tile.dart';
import 'package:ig/features/providers/get_all_posts_provider.dart';
import 'package:ig/features/providers/get_all_videos_provider.dart';

class VideosScreen extends ConsumerWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final posts = ref.watch(getAllVideosProvider);
    return posts.when(
      data: (postsList){
        return ListView.separated(
          itemCount: postsList.length,
          separatorBuilder: (context,index)=> const SizedBox(height: 8,),
          itemBuilder: (context,index){
            final post = postsList.elementAt(index);
            return PostTile(post:post);
          }, 
          );
      }, 
    error: ((error, stackTrace){
      return ErrorScreen(error: error.toString(),);
    }), 
    loading: (){
      return const Loader();
    });
  }
}
