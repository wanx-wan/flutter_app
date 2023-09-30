import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:ubuapp/pages/myhomepage.dart';

class AnimateLoginPage extends StatelessWidget {
  final _formLogin = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final pb = PocketBase('http://127.0.0.1:8090');

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _login(BuildContext context) async {
    if (_formLogin.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;

      if (email == "wancharoen.up.63@ubu.ac.th" && password == "adminubu1234") {
        try {
          final authData = await pb.admins.authWithPassword(email, password);

          if (authData != null) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => MyHomePage(
                  title: email,
                  email: email, 
                ),
              ),
            );
            return;
          }
        } catch (e) {
          _showSnackBar(context, 'Error: $e');
        }
      } else {
        _showSnackBar(context, 'Invalid');
      }
    } else {
      _showSnackBar(context, 'Please fill');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Please Login")),
      body: Form(
        key: _formLogin,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _login(context),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
