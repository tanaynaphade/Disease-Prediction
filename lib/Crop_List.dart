import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Graph_price.dart';

class CommodityListPage extends StatelessWidget {
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref('market_prices/Maharashtra');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Commodity List')),
      body: FutureBuilder<DatabaseEvent>(
        future: dbRef.once(),  // Fix for the newer version of firebase_database
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          }

          if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
            Map<dynamic, dynamic> commoditiesData = snapshot.data!.snapshot.value as Map;
            List<String> commodityList = commoditiesData.values
                .map((entry) => entry['Commodity'].toString())
                .toSet()
                .toList();  // Avoid duplicates

            return ListView.builder(
              itemCount: commodityList.length,
              itemBuilder: (context, index) {
                String commodity = commodityList[index];
                return ListTile(
                  title: Text(commodity),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LineGraphPage(commodity: commodity),
                      ),
                    );
                  },
                );
              },
            );
          }

          return Center(child: Text('No commodities available'));
        },
      ),
    );
  }
}
