import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../components/my_button.dart';
import '../../components/my_square_tile.dart';
import '../../components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final VoidCallback onLoginTap;
  RegisterPage({super.key, required this.onLoginTap});

  // Text editing controllers
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Sign user up
  void signUserUp(BuildContext context) async {
    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    // Basic validation
    if (password == confirmPassword && username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      try {
        var response = await http.post(
          Uri.parse('http://192.168.137.7:8000/user/register'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: {
            'username': username,
            'email': email,
            'password': password,
          },
        );

        if (response.statusCode == 200) {
          // Registration successful
          print('User registered successfully');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful!')),
          );
        } else {
          // Error during registration
          print('Error during registration: ${response.body}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration failed: ${response.body}')),
          );
        }
      } catch (e) {
        print('Failed to register user: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to register user.')),
        );
      }
    } else {
      print('Please make sure all fields are filled and passwords match');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please make sure all fields are filled and passwords match')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // Logo
                const Icon(Icons.lock, size: 100),
                const SizedBox(height: 25),

                // Account creation prompt
                const Text("Let's create an account for you"),
                const SizedBox(height: 25),

                // Username text field
                MyTextField(
                  controller: usernameController,
                  hintText: "Username",
                  obscureText: false,
                ),
                const SizedBox(height: 10),

                // Email text field
                MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),
                const SizedBox(height: 10),

                // Password text field
                MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(height: 10),

                // Confirm password text field
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  obscureText: true,
                ),
                const SizedBox(height: 25),

                // Sign up button
                MyButton(
                  text: "Sign Up",
                  onTap: () => signUserUp(context),
                ),
                const SizedBox(height: 50),

                // Or continue with divider
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

                // Google + Apple sign-in buttons
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(imagePath: "lib/assets/images/google.png"),
                    SizedBox(width: 50),
                    SquareTile(imagePath: "lib/assets/images/apple.png"),
                  ],
                ),
                const SizedBox(height: 50),

                // Already have an account? Login now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?", style: TextStyle(color: Colors.grey[700])),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: onLoginTap,
                      child: const Text("Login now", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
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
