import '../../../model/my_user.dart';

abstract class LoginNavigator {
  void showMyLoading({required String message});

  void hideMyLoading();

  void showMyMessage({required String title, required String message});

  void saveUser({required MyUser? user}) {}

  void navigateToHome();
}
