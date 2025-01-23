import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DonatePage extends StatelessWidget {
  static String route = 'donate-page';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Donate",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            tabs: [
              Tab(text: "Individuals"),
              Tab(text: "Organizations"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            IndividualsList(),
            OrganizationsList(),
          ],
        ),
      ),
    );
  }
}

class IndividualsList extends StatelessWidget {
  final List<Map<String, dynamic>> individuals = [
    {"name": " Abebe Kebede", "amount": 500},
    {"name": "Jane blue", "amount": 300},
    {"name": "Saad musema", "amount": 700},
    {"name": "chris Brown", "amount": 150},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: individuals.length,
        itemBuilder: (context, index) {
          final individual = individuals[index];
          return Card(
            color: Colors.white,
            elevation: 5,
            shadowColor: Colors.black12,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: Text(
                  individual['name'].substring(0, 1),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: Text(individual['name']),
              subtitle: Text('Needs \$${individual['amount']} for support'),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEEEFF0),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ).copyWith(
                  side: MaterialStateProperty.all(
                    BorderSide(color: Colors.grey[300]!, width: 1),
                  ),
                ),
                onPressed: () {
                  Get.snackbar(
                    'Thank You',
                    'You chose to support ${individual['name']}',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.greenAccent,
                    colorText: Colors.white,
                  );
                },
                child: Text('Donate'),
              ),
            ),
          );
        },
      ),
    );
  }
}

class OrganizationsList extends StatelessWidget {
  final List<Map<String, dynamic>> organizations = [
    {"name": "Red Cross", "impact": "Emergency Relief"},
    {"name": "UNICEF", "impact": "Child Welfare"},
    {"name": "Doctors Without Borders", "impact": "Healthcare"},
    {"name": "World Food Program", "impact": "Hunger Relief"},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: organizations.length,
        itemBuilder: (context, index) {
          final organization = organizations[index];
          return Card(
            color: Colors.white,
            elevation: 5,
            shadowColor: Colors.black12,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: Icon(
                Icons.favorite,
                color: Colors.redAccent,
              ),
              title: Text(organization['name']),
              subtitle: Text('${organization['impact']} Initiative'),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEEEFF0),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ).copyWith(
                  side: MaterialStateProperty.all(
                    BorderSide(color: Colors.grey[300]!, width: 1),
                  ),
                ),
                onPressed: () {
                  Get.snackbar(
                    'Thank You',
                    'You chose to support ${organization['name']}',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.blueAccent,
                    colorText: Colors.white,
                  );
                },
                child: Text('Donate'),
              ),
            ),
          );
        },
      ),
    );
  }
}
