import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sri_tel/Screens/pw_reset.dart';
import 'package:sri_tel/Screens/signup.dart';
import 'package:sri_tel/app_state.dart';
import 'package:sri_tel/rail.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() async {
    if (await context.read<AppState>().login(emailController.text, passwordController.text)) {
      // emailController.clear();
      // passwordController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(context.read<AppState>().error ?? 'Error, Try again !'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<AppState>(builder: (context, appState, _) {
          if (appState.user == null) {
            return Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Sri Care',
                          style: TextStyle(color: Color.fromARGB(255, 243, 229, 33), fontWeight: FontWeight.w500, fontSize: 30),
                        )),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            height: 50,
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: ElevatedButton(
                              child: const Text('Login'),
                              onPressed: () => login(),
                            )),
                        Container(
                            height: 50,
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: ElevatedButton(
                              child: const Text('Sign up'),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Signup(),
                                  ),
                                );
                              },
                            )),
                        Container(
                            height: 50,
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: ElevatedButton(
                              child: const Text('Reset Password'),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PWDReset(),
                                  ),
                                );
                              },
                            )),
                      ],
                    ),
                  ],
                ));
          } else {
            return const Rail(0);
          }
        }),
      ),
    );
  }
}
