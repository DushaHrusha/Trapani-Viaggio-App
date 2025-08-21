import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _onItemTapped(int index) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.home,
              size: 20,
              color: Color.fromARGB(255, 109, 109, 109),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.home,
              size: 20,
              color: Color.fromARGB(255, 109, 109, 109),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.search,
              size: 20,
              color: Color.fromARGB(255, 109, 109, 109),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.person,
              size: 20,
              color: Color.fromARGB(255, 109, 109, 109),
            ),
          ),
        ],

        onTap: _onItemTapped,
      ),
    );
  }
}
