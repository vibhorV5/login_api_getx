import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_login_api/Screens/Login/Controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(mediaQuery.width * 0.05),
          height: mediaQuery.height * 0.9,
          width: mediaQuery.width,
          color: Colors.grey.shade300,
          child: Form(
            key: loginController.loginFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Fields(
                  fieldInfo: loginController.emailController,
                  hintText: 'Registered Email Id',
                  labelText: 'Registered Email Id',
                  validator: (String? value) {
                    loginController.emailValidate(value!.trim());
                  },
                  onSaved: (value) {
                    loginController.email = value!;
                  },
                ),
                SizedBox(
                  height: mediaQuery.height * 0.02,
                ),
                Fields(
                  onSaved: (value) {
                    loginController.password = value!;
                  },
                  obsText: true,
                  fieldInfo: loginController.passwordController,
                  hintText: 'Password',
                  labelText: 'Password',
                  validator: (String? value) {
                    loginController.passwordValidate(value!);
                  },
                ),
                SizedBox(
                  height: mediaQuery.height * 0.04,
                ),
                SaveButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    // loginController.loginFormKey.validate;
                    // loginController.loginUser();
                    if (loginController.loginFormKey.currentState!.validate()) {
                      loginController.loginUser();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Fields extends StatelessWidget {
  const Fields({
    super.key,
    required this.fieldInfo,
    required this.hintText,
    required this.labelText,
    required this.validator,
    required this.onSaved,
    this.obsText = false,
    this.txtInputType = TextInputType.emailAddress,
  });

  final TextEditingController fieldInfo;
  final String hintText;
  final String labelText;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;
  final bool obsText;
  final TextInputType txtInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      keyboardType: txtInputType,
      obscureText: obsText,
      controller: fieldInfo,
      autofocus: false,
      validator: validator,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.black,
            // width: 2.0,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.black,
            // width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.red,
            // width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.grey,
            // width: 2.0,
          ),
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 13,
          color: Colors.black.withOpacity(0.3),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 13,
          color: Colors.black.withOpacity(0.3),
        ),
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: onPressed,
        child: const Text(
          "Save",
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
