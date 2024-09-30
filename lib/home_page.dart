import 'package:flutter/material.dart';
import 'package:new_app/plants_screen.dart';
import 'Crop_List.dart';
import 'Welcome.dart';
import 'animal_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(223, 240, 227, 1),
        title: const Center(
            child: Text(
              'Home Page',
              style: TextStyle(
                  fontFamily: 'SourceSans3',
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            )),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(223, 240, 227, 1),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40,horizontal: 20),
                child: Text(
                  'Navigation Menu',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SourceSans3',
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.local_florist, color: Colors.green),
              title: Text('Plants', style: TextStyle(color: Colors.green)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlantsScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.pets, color: Colors.green),
              title: Text('Animals', style: TextStyle(color: Colors.green)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnimalScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.monetization_on_outlined, color: Colors.green),
              title: Text('Prices', style: TextStyle(color: Colors.green)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommodityListPage()),
                );
              },
            ),
            Divider(), // Divider for separation
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.green),
                  title: Text('Logout', style: TextStyle(color: Colors.green)),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        color: const Color.fromRGBO(223, 240, 227, 1), // Background color set here
        child: const Center(
          child: Text(
            'Welcome to the Home Page',
            style: TextStyle(fontSize: 24, color: Colors.green),
          ),
        ),
      ),
    );
  }
}
