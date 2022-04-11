import 'package:flutter/material.dart';
import 'package:noteapp/screen/notes_list.dart';
import 'package:noteapp/widgets/custom_text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static const String routeName = 'signup';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  FocusNode nameFocus = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _login() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
              errorText: 'enter your name',
              textEditingController: nameController,
              focusNode: nameFocus,
              handleOnTap: handleOnTap,
              requestFocusNode: emailFocusNode,
              hintText: 'enter your name',
              labelText: 'Name'),
          CustomTextField(
              errorText: 'enter your email',
              textEditingController: emailController,
              focusNode: emailFocusNode,
              handleOnTap: handleOnTap,
              requestFocusNode: passFocusNode,
              hintText: 'Enter your E-mail',
              labelText: 'E-Mail'),
          CustomTextField(
              isPasswordField: true,
              obSecureText: true,
              isLastField: true,
              errorText: 'enter your password',
              textEditingController: passController,
              focusNode: passFocusNode,
              handleOnTap: handleOnTap,
              requestFocusNode: passFocusNode,
              hintText: 'Enter your password',
              labelText: 'Password')
        ],
      ),
    );
  }

  void handleOnTap() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, NotesList.routeName);
    }
  }
  Widget customButton() {
    return OutlinedButton(onPressed: handleOnTap, child: const Padding(
      padding:  EdgeInsets.symmetric(vertical: 5,horizontal: 20),
      child:  Text("SUBMIT"),
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameFocus.dispose();
    emailFocusNode.dispose();
    passFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_login(), customButton()],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('already have an account ? '),
            InkWell(
                onTap: () => Navigator.pop(context),
                child: const Text(
                  'login',
                  style: TextStyle(color: Colors.blue),
                ))
          ],
        ),
      ),
    );
  }
}
