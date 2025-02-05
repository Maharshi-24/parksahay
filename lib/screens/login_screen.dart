import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive sizing
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Authentication
import 'dart:async';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isUsernameFocused = false;
  bool isPasswordFocused = false;
  bool isButtonPressed = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage = '';

  // Create a FocusNode for managing the focus
  final FocusNode _focusNode = FocusNode();

  Future<void> _signIn() async {
    setState(() => isButtonPressed = true);
    await Future.delayed(Duration(milliseconds: 300)); // Button press delay animation
    setState(() => isButtonPressed = false);

    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Navigate to home screen after successful login
    } catch (e) {
      setState(() {
        errorMessage = 'Invalid email or password';
      });
      Future.delayed(Duration(seconds: 4), () {
        setState(() {
          errorMessage = '';
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Remove the focus when tapping outside of text fields
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(
          children: [
            // Background - Brutalist Style with More Depth Effect
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.grey.shade900],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),

            // Content with Interactive Animations
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title with Depth Effect
                  Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.grey.shade800,
                          offset: Offset(6, 6),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: 50.w,
                    height: 4.h,
                    color: Colors.white,
                  ),
                  SizedBox(height: 32.h),

                  // Username Field with Depth Effect and Interaction
                  FocusScope(
                    child: Focus(
                      onFocusChange: (focused) {
                        setState(() => isUsernameFocused = focused);
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isUsernameFocused ? Colors.blue : Colors.white,
                            width: 3.w,
                          ),
                          boxShadow: isUsernameFocused
                              ? [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.5),
                              offset: Offset(4, 4),
                              blurRadius: 8,
                            ),
                          ]
                              : [],
                          color: Colors.grey.shade900,
                        ),
                        child: TextField(
                          controller: _emailController,
                          focusNode: _focusNode, // Assign the FocusNode here
                          decoration: InputDecoration(
                            labelText: 'EMAIL',
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(12.w),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Password Field with Depth Effect and Interaction
                  FocusScope(
                    child: Focus(
                      onFocusChange: (focused) {
                        setState(() => isPasswordFocused = focused);
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isPasswordFocused ? Colors.red : Colors.white,
                            width: 3.w,
                          ),
                          boxShadow: isPasswordFocused
                              ? [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.5),
                              offset: Offset(4, 4),
                              blurRadius: 8,
                            ),
                          ]
                              : [],
                          color: Colors.grey.shade900,
                        ),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'PASSWORD',
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(12.w),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  if (errorMessage.isNotEmpty)
                    Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red, fontSize: 14.sp),
                    ),
                  SizedBox(height: 16.h),

                  // Login Button with Sharp Borders and 3D Box Look
                  GestureDetector(
                    onTap: _signIn,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 150),
                      height: isButtonPressed ? 45.h : 50.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black.withOpacity(0.6),
                          width: 2.w,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            offset: isButtonPressed ? Offset(2, 2) : Offset(4, 4),
                            blurRadius: isButtonPressed ? 4 : 8,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Signup Redirect Text
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Haven't logged in yet? Press here to sign up.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
