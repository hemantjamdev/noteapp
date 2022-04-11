import 'package:flutter/material.dart';
import 'package:noteapp/screen/notes_list.dart';
import 'package:noteapp/screen/sign_up.dart';
import 'package:noteapp/widgets/custom_text_field.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);
  static const String routeName = 'login';

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obSecureText = false;

  Widget _login() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
              textEditingController: emailController,
              focusNode: emailFocusNode,
              handleOnTap: handleOnTap,
              requestFocusNode: passFocusNode,
              errorText: 'enter your email',
              hintText: 'Enter your E-mail',
              labelText: 'E-mail'),
          CustomTextField(
            obSecureText: true,
            isPasswordField: true,
            isLastField: true,
            textEditingController: passController,
            focusNode: passFocusNode,
            handleOnTap: handleOnTap,
            requestFocusNode: passFocusNode,
            hintText: 'Enter your password',
            labelText: 'password',
            errorText: 'enter your password',
          ),
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
      child:  Text("LOG IN"),
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
          children: [
            _login(),
            customButton(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('''don't have an account ? '''),
            InkWell(
                onTap: () => Navigator.pushNamed(context, SignUp.routeName),
                child: const Text(
                  'sign up',
                  style: TextStyle(color: Colors.blue),
                ))
          ],
        ),
      ),
    );
  }
}
