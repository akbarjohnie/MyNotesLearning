import 'package:flutter/material.dart';
import 'package:mynotesapp/constants/routes.dart';
import 'package:mynotesapp/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  _VerifyEmailViewState createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Verify email'),
          centerTitle: true,
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                    "We've sent you email verification. Please open it \n to verify your email."),
                const Text(
                    'If you have not received a verification email yet, press \n the buttom below:'),
                TextButton(
                  onPressed: () async {
                    await AuthService.firebase().sentEmailVerification();
                  },
                  child: const Text('Send email verification.'),
                ),
                TextButton(
                  onPressed: () async {
                    await AuthService.firebase().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      registerRoute,
                      (route) => false,
                    );
                  },
                  child: const Text('Restart'),
                ),
              ],
            ),
          ],
        ));
  }
}
