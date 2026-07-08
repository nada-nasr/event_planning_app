import 'package:event_planning_app/ui/authentication/login/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../firebase_utils.dart';
import '../../../model/my_user.dart';

class LoginScreenViewModel extends ChangeNotifier {
  //todo: hold data, handle logic
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  late LoginNavigator navigator;

  void login() async {
    if (formKey.currentState!.validate() == true) {
      //todo: show loading
      /*DialogUtils.showLoading(
        context: context,
        message: 'Waiting...');*/
      navigator.showMyLoading(message: 'Waiting...');
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        MyUser? user = await FirebaseUtils.readUserFromFireStore(
          credential.user?.uid ?? '',
        );
        if (user == null) {
          return;
        }
        /*//todo: save user in provider
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.updateUser(user);
      var eventListProvider = Provider.of<EventListProvider>(
          context, listen: false);
      eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);*/
        navigator.saveUser(user: user);
        //todo: hide loading
        //DialogUtils.hideLoading(context);
        navigator.hideMyLoading();
        //todo: show message
        /*DialogUtils.showMessage(
          context: context,
          title: 'Success',
          message: 'Login successfully',
          posActionName: 'Ok',
          posAction: () {
            Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
          }
      );*/
        navigator.showMyMessage(
          title: 'Success',
          message: 'Login successfully',
        );
        print('login successfully');
        print(credential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          //todo: hide loading
          //todo: show message
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          //todo: hide loading
          //todo: show message
          print('Wrong password provided for that user.');
        } else if (e.code == 'invalid-credential') {
          //todo: hide loading
          //DialogUtils.hideLoading(context);
          navigator.hideMyLoading();
          //todo: show message
          /*DialogUtils.showMessage(
            context: context,
            message: 'The supplied auth credential is incorrect, malformed or has expired.',
            title: 'Error',
            posActionName: 'Ok');*/
          navigator.showMyMessage(
            title: 'Error',
            message:
                'The supplied auth credential is incorrect, malformed or has expired.',
          );
          print(
            'The supplied auth credential is incorrect, malformed or has expired.',
          );
        }
      } catch (e) {
        //todo: hide loading
        //DialogUtils.hideLoading(context);
        navigator.hideMyLoading();
        //todo: show message
        /*DialogUtils.showMessage(
          context: context,
          message: e.toString(),
          title: 'Error',
          posActionName: 'Ok');*/
        navigator.showMyMessage(title: 'Error', message: e.toString());
        print(e);
      }
    }
  }
}
