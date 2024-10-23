import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/my_button.dart';
import '../../components/my_square_tile.dart';
import '../../components/my_textfield.dart';
import '../home_page.dart';

class LoginPage extends StatelessWidget {
  final VoidCallback onRegisterTap;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  LoginPage({super.key, required this.onRegisterTap});

  void signUserIn(BuildContext context) async {
    print('Sign in function called.');

    final response = await http.post(
      Uri.parse('http://192.168.137.7:8000/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': usernameController.text,
        'password': passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final String accessToken = data['token']['access'];
      final String refreshToken = data['token']['refresh'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', accessToken);
      await prefs.setString('refresh_token', refreshToken);

      print('Access Token: $accessToken');
      print('Refresh Token: $refreshToken');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful!')),
      );

      // Navigate to the HomePage after login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      print('Login failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // logo
                const Icon(Icons.lock, size: 100),
                const SizedBox(height: 50),

                // welcome back
                const Text("Welcome back, you've been missed!"),

                const SizedBox(height: 25),

                // username textfield
                MyTextField(
                  controller: usernameController,
                  hintText: "Username",
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Forgot Password?", style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // sign in button
                MyButton(
                  onTap: () => signUserIn(context),
                  text: 'Sign In',
                ),

                const SizedBox(height: 50),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(child: Divider(thickness: 0.5, color: Colors.grey[400])),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text("Or continue with", style: TextStyle(color: Colors.grey[700])),
                      ),
                      Expanded(child: Divider(thickness: 0.5, color: Colors.grey[400])),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // google + apple sign in buttons
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(imagePath: "lib/assets/images/google.png"),
                    SizedBox(width: 50),
                    SquareTile(imagePath: "lib/assets/images/apple.png"),
                  ],
                ),

                const SizedBox(height: 50),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member?", style: TextStyle(color: Colors.grey[700])),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: onRegisterTap,
                      child: const Text(
                        "Register now",
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
