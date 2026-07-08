import 'package:event_planning_app/ui/authentication/register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../firebase_utils.dart';
import '../../../model/my_user.dart';

class RegisterScreenViewModel extends ChangeNotifier {
  //todo: hold data, handle logic
  var nameController = TextEditingController();
  late RegisterNavigator navigator;

  void register(String email, String password) async {
    //todo: show loading
    /*DialogUtils.showLoading(
        context: context,
        message: 'Loading...');*/
    navigator.showMyLoading(message: 'Loading...');
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      //todo: save user to fireStore
      MyUser myUser = MyUser(
        id: credential.user?.uid ?? '',
        name: nameController.text,
        email: email,
      );
      await FirebaseUtils.addUserToFireStore(myUser);
      /*//todo: save user in provider
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.updateUser(myUser);
      var eventListProvider = Provider.of<EventListProvider>(
          context, listen: false);
      eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);*/
      navigator.saveUser(myUser: myUser);

      //todo: hide loading
      //DialogUtils.hideLoading(context);
      navigator.hideMyLoading();
      //todo: show message
      /*DialogUtils.showMessage(
          context: context,
          title: 'Success',
          message: 'Register successfully',
          posActionName: 'Ok',
          posAction: () {
            Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
          }
      );*/
      navigator.showMyMessage(
        title: 'Success',
        message: 'Register successfully',
      );

      print('register successfully');
      print(credential.user?.uid ?? '');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        //todo: hide loading
        //DialogUtils.hideLoading(context);
        navigator.hideMyLoading();
        //todo: show message
        /*DialogUtils.showMessage(
            context: context,
            message: 'The password provided is too weak.',
            title: 'Error',
            posActionName: 'Ok');*/
        navigator.showMyMessage(
          title: 'Error',
          message: 'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        //todo: hide loading
        //DialogUtils.hideLoading(context);
        navigator.hideMyLoading();
        //todo: show message
        /*DialogUtils.showMessage(
            context: context,
            message: 'The account already exists for that email.',
            title: 'Error',
            posActionName: 'Ok');*/
        navigator.showMyMessage(
          title: 'Error',
          message: 'The account already exists for that email.',
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
      print(e.toString());
      print(e);
    }
  }
}
