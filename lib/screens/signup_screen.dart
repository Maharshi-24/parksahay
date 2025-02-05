import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive sizing
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Authentication
import 'dart:async';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isEmailFocused = false;
  bool isPasswordFocused = false;
  bool isButtonPressed = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage = '';

  Future<void> signUp() async {
    setState(() => isButtonPressed = true);
    await Future.delayed(Duration(milliseconds: 100)); // Button press delay animation
    setState(() => isButtonPressed = false);

    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      _showPopup("Successfully signed up");
      // Navigate to login screen after successful sign-up
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      });
    } catch (e) {
      if (e.toString().contains("type 'List<Object?>' is not a subtype of type 'PigeonUserDetails?' in type cast")) {
        _showPopup("Successfully signed up");
      } else {
        setState(() {
          errorMessage = 'Error during sign-up: ${e.toString()}';
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            errorMessage = '';
          });
        });
      }
    }
  }

  void _showPopup(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          backgroundColor: Colors.grey.shade900,
          elevation: 6,
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 10,
                  offset: Offset(4, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );

    // Close the popup after 4 seconds
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // This will unfocus the text fields
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
                    'SIGN UP',
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

                  // Email Field with Depth Effect and Interaction
                  FocusScope(
                    child: Focus(
                      onFocusChange: (focused) {
                        setState(() => isEmailFocused = focused);
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isEmailFocused ? Colors.blue : Colors.white,
                            width: 3.w,
                          ),
                          boxShadow: isEmailFocused
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

                  // Sign Up Button with Sharp Borders and 3D Box Look
                  GestureDetector(
                    onTap: signUp,
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
                          'SIGN UP',
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

                  // Login Redirect Text
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Already have an account? Login here.",
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
