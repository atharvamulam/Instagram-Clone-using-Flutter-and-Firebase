import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ig/features/friends/repository/friends_repository.dart';

final friendProvider = Provider((ref) {
  return FriendRepository();
});