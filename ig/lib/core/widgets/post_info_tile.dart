import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ig/core/constants/extensions.dart';
import 'package:ig/core/screens/loader.dart';
import 'package:ig/features/providers/get_user_info_by_id_provider.dart';

class PostInfoTile extends ConsumerWidget {
  const PostInfoTile({Key ? key,required this.datePublished,required this.userId}): super(key: key);
  
  final DateTime datePublished;
  final String userId;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final userInfo = ref.watch(getUserInfoByIdProvider(userId));
    return userInfo.when(
      data: (user){
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(user.profilePicUrl),
                ),
              ),
              const SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      ),
                      ),
                      Text(
                        datePublished.fromNow(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      )
                ],
              ),
              const Spacer(),
              const Icon(Icons.more_horiz),
            ],
          ),);
      }, 
      error: ((error, stackTrace) {
        return Text(error.toString());
      }), 
      loading: (){
        return const Loader();
      });

  }
}