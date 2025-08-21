import 'package:flutter/material.dart';
import 'package:test_task/rounded_top_clipper.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/file/city_header.jpg', // Replace with your image path
                    height: 450,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Bottom half: White background with UI elements
                Padding(
                  padding: const EdgeInsets.only(top: 400),
                  child: Expanded(
                    flex: 1,
                    child: ClipPath(
                      clipper: RoundedTopClipper(),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Back arrow icon
                            Icon(Icons.arrow_back, size: 24),
                            SizedBox(height: 10),
                            // "Sign Up" text
                            Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            // Phone input field with region dropdown
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Row(
                                children: [
                                  // Region dropdown (gray section)
                                  Container(
                                    width: 80,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                      ),
                                    ),
                                    child: DropdownButton<String>(
                                      value: '+1', // Default value
                                      items:
                                          <String>[
                                            '+1',
                                            '+7',
                                            '+44',
                                            '+91',
                                          ].map<DropdownMenuItem<String>>((
                                            String value,
                                          ) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                      onChanged: (String? newValue) {
                                        // Handle region change
                                      },
                                      underline:
                                          Container(), // Remove default underline
                                      icon: Icon(Icons.arrow_drop_down),
                                    ),
                                  ),
                                  // Phone number input (white section)
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(30),
                                          bottomRight: Radius.circular(30),
                                        ),
                                      ),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: '(000) 000-00-00',
                                          border: InputBorder.none,
                                        ),
                                        keyboardType: TextInputType.phone,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            // Divider with "or" text
                            Row(
                              children: [
                                Expanded(child: Divider(color: Colors.grey)),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text('or'),
                                ),
                                Expanded(child: Divider(color: Colors.grey)),
                              ],
                            ),
                            SizedBox(height: 20),
                            // Social media icons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                  child: Icon(Icons.apple, color: Colors.black),
                                ),
                                SizedBox(width: 10),
                                CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                  child: Icon(
                                    Icons.g_mobiledata,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(width: 10),
                                CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                  child: Icon(
                                    Icons.facebook,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(width: 10),
                                CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                  child: Icon(Icons.email, color: Colors.red),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            // Gradient "Sign Up" button
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.blue, Colors.purple],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle sign up
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            // "Have an account? Log in" text
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Have an account? '),
                                GestureDetector(
                                  onTap: () {
                                    // Handle log in
                                  },
                                  child: Text(
                                    'Log in',
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Top half: St. Petersburg image
          ],
        ),
      ),
    );
  }
}
