import 'package:learn_flutter/data/models/user.dart';
import 'package:learn_flutter/data/services/user_api_service.dart';

class UserRepository {
  final UserApiService apiService;

  UserRepository({required this.apiService});

  Future<List<User>> getUsers() async {
    return await apiService.fetchUsers();
  }
  
}