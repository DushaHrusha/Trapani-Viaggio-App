import 'package:flutter/material.dart';
import 'package:test_task/car_catalog.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Stack(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/file/river.jpg', // Replace with your image path
                    height: 400,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 400),
                  child: ClipPath(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Back arrow icon
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 20),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CarCatalog(),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.arrow_back,
                                size: 24,
                                color: Color.fromARGB(255, 109, 109, 109),
                              ),
                            ),
                          ),
                          // "Sign Up" text
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 20),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Color.fromARGB(255, 109, 109, 109),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // Phone input field with region dropdown
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              top: 20,
                              right: 20,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 100,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 235, 241, 244),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                      ),
                                    ),
                                    child: DropdownButton<String>(
                                      value: '+1', // Default value
                                      style: TextStyle(
                                        fontFamily: 'San Francisco Pro Display',
                                        color: Color.fromARGB(
                                          255,
                                          109,
                                          109,
                                          109,
                                        ),
                                        fontWeight: FontWeight.w700,
                                      ),
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
                                      onChanged: (String? newValue) {},
                                      underline:
                                          Container(), // Remove default underline
                                      icon: Icon(Icons.arrow_drop_down_sharp),
                                    ),
                                  ),
                                  // Phone number input (white section)
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 60,
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
                                          hintStyle: TextStyle(
                                            fontFamily:
                                                'San Francisco Pro Display',
                                            color: Color.fromARGB(
                                              255,
                                              109,
                                              109,
                                              109,
                                            ),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        keyboardType: TextInputType.phone,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          // Divider with "or" text
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Color.fromARGB(255, 224, 224, 224),
                                  indent: 15,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'or',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 224, 224, 224),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Color.fromARGB(255, 224, 224, 224),
                                  endIndent: 15,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          // Social media icons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,

                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: Color.fromARGB(
                                  255,
                                  235,
                                  241,
                                  244,
                                ),
                                child: Image.asset('assets/file/apple.png'),
                              ),
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: Color.fromARGB(
                                  255,
                                  235,
                                  241,
                                  244,
                                ),
                                child: Image.asset('assets/file/google.png'),
                              ),
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: Color.fromARGB(
                                  255,
                                  235,
                                  241,
                                  244,
                                ),
                                child: Image.asset('assets/file/facebook.png'),
                              ),
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: Color.fromARGB(
                                  255,
                                  235,
                                  241,
                                  244,
                                ),
                                child: Image.asset('assets/file/at sign.png'),
                              ),
                            ],
                          ),
                          SizedBox(height: 50),
                          // Gradient "Sign Up" button
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 255, 127, 80),
                                    Color.fromARGB(255, 85, 97, 178),
                                  ],
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
                                    fontFamily: 'San Francisco Pro Display',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          // "Have an account? Log in" text
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Have an account? ',
                                style: TextStyle(
                                  fontFamily: 'San Francisco Pro Display',
                                  color: Color.fromARGB(255, 109, 109, 109),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Handle log in
                                },
                                child: Text(
                                  'Log in',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontFamily: 'San Francisco Pro Display',
                                    fontWeight: FontWeight.w400,
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
              ],
            ),
            // Top half: St. Petersburg image
          ],
        ),
      ),
    );
  }
}
