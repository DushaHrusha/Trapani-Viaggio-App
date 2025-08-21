import 'package:flutter/material.dart';

class CityInfoScreen extends StatelessWidget {
  const CityInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trapani'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/file/city_header.jpg', // Replace with your image
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    style: TextStyle(
                      fontSize: 36,
                      fontFamily: 'Berlin Sans FB',
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 137, 137, 137),
                    ),
                    'Hello. Welcome to Trapani!',
                  ),

                  Text(
                    'A lively city with rich maritime heritage and vibrant economic activities.',
                    style: TextStyle(
                      fontFamily: 'Berlin Sans FB',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 137, 137, 137),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextButton(
                  onPressed: () {
                    print('Service button pressed');
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, // Убирает внутренние отступы
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Service',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            GridView.count(
              crossAxisCount: 2, // Количество кнопок в строке
              crossAxisSpacing: 16.0, // Отступ между кнопками по горизонтали
              mainAxisSpacing: 16.0, // Отступ между кнопками по вертикали
              children: List.generate(4, (index) {
                return _buildGridButton(
                  context,
                  icon: Icons.email,
                  label: 'Почта',
                  color: Colors.blue,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.1),
        foregroundColor: color,
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: color, width: 1),
        ),
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, size: 28),
          const SizedBox(width: 12),
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(String title, IconData icon) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero, // Убирает внутренние отступы
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(title),
    );
  }
}
