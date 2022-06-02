import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({ Key? key }) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
 late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _email;
    _password;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),

      body: 
      FutureBuilder(
        future: Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform,
                ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
          
            case ConnectionState.done:
             return Column(
          children: [
            TextField(
              controller: _email,
              autocorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Enter your email here'
              ),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              autocorrect: false,
              enableSuggestions: false,
              decoration: const InputDecoration(
                hintText: 'Enter your password here'),
            ),
            TextButton(
              onPressed: () async {
      
                final email = _email.text;
                final password = _password.text;
                try {
                  final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                } on FirebaseAuthException
                catch (e) {
                  if (e.code == 'user-not-found') {
                    print('User not found');
                  } else if (e.code == 'worng-password') {
                    print('Wrong Password');
                    print(e.code);
                  }
                }
              }, 
              child: const Text('Login'),),
          ],
        );

        default: return const Text('Loading...');

          }
          
        },
        
      ),
    );
  }

  

}