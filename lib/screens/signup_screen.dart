import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive sizing

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isUsernameFocused = false;
  bool isPasswordFocused = false;
  bool isButtonPressed = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage = '';
  bool _isLoading = false;

  Future<void> _signup() async {
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      setState(() => isButtonPressed = true);
      await Future.delayed(Duration(milliseconds: 300)); // Button press delay animation
      setState(() => isButtonPressed = false);

      setState(() => _isLoading = true);
      try {
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        Navigator.pop(context); // Go back to login after successful signup
      } on FirebaseAuthException catch (e) {
        // Handling specific Firebase error messages
        setState(() {
          if (e.code == 'email-already-in-use') {
            errorMessage = 'The email is already in use. Please try another one.';
          } else if (e.code == 'weak-password') {
            errorMessage = 'Password is too weak. Please choose a stronger one.';
          } else {
            errorMessage = 'Signup failed: ${e.message}';
          }
        });
        // Hide the error message after 4 seconds
        Future.delayed(Duration(seconds: 4), () {
          setState(() {
            errorMessage = '';
          });
        });
      } catch (e) {
        setState(() {
          errorMessage = 'Signup failed: Please check your credentials.';
        });
        // Hide the error message after 4 seconds
        Future.delayed(Duration(seconds: 4), () {
          setState(() {
            errorMessage = '';
          });
        });
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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

                // Error Message Display
                if (errorMessage.isNotEmpty)
                  Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red, fontSize: 14.sp),
                  ),
                SizedBox(height: 16.h),

                // Signup Button with Animation and Delay
                GestureDetector(
                  onTap: _isLoading ? null : _signup,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 150),
                    height: isButtonPressed ? 45.h : 50.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.6),
                          offset: isButtonPressed ? Offset(2, 2) : Offset(4, 4),
                          blurRadius: isButtonPressed ? 4 : 8,
                        ),
                      ],
                    ),
                    child: Center(
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : Text(
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

                // Already have an account? Redirect to Login
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Go back to login screen
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
    );
  }
}
