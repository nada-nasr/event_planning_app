import '../../../model/my_user.dart';

abstract class RegisterNavigator {
  void showMyLoading({required String message});

  void hideMyLoading();

  void showMyMessage({required String title, required String message});

  void saveUser({required MyUser myUser}) {}

  void navigateToHome();
}
