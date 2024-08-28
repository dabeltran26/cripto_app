import 'package:cripto_app/profile/data/datasource/firebase_profile_service.dart';
import 'package:cripto_app/profile/domain/respositories/profile_repository.dart';
import 'package:cripto_app/resources/base_api_repository.dart';
import 'package:cripto_app/resources/models/user_model.dart';

class ProfileRepositoryImpl extends BaseApiRepository implements ProfileApiRepository {
  final FirebaseProfileService firebaseProfileService;

  ProfileRepositoryImpl(this.firebaseProfileService);

  @override
  Future<bool> updatePassword(String password) async {
    return await firebaseProfileService.updatePassword(password);
  }

  @override
  Future<bool> updateUser(UserModel user) async {
    return await firebaseProfileService.updateUser(user);
  }
}
