import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sri_tel/app_state.dart';

class PWDReset extends StatefulWidget {
  const PWDReset({super.key});

  @override
  State<PWDReset> createState() => _PWDResetState();
}

class _PWDResetState extends State<PWDReset> {
  TextEditingController emailController = TextEditingController();

  void pwdReset() async {
    if (await context.read<AppState>().pwdReset(emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Check your Email'),
        backgroundColor: Colors.green,
      ));
      Navigator.of(context).pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Inavalid email'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<AppState>(builder: (context, appState, _) {
          return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Reset Password',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: TextButton(
                        child: const Text('Send Password Reset Link'),
                        onPressed: () => pwdReset(),
                      )),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(context);
                    },
                    child: const Text(
                      'Back',
                    ),
                  ),
                ],
              ));
        }),
      ),
    );
  }
}
