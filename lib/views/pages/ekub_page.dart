import 'package:flutter/material.dart';

class EkubPage extends StatefulWidget {
  static String route = 'ekub-page';
  @override
  _EkubPageState createState() => _EkubPageState();
}

class _EkubPageState extends State<EkubPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  String? _selectedAmount = '1,000 birr';
  String? _selectedEkubType = 'Personal';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  // Modal for editing Ekub Type
  void _editEkubType() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Ekub Type',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              RadioListTile<String>(
                title: Text('Personal'),
                value: 'Personal',
                groupValue: _selectedEkubType,
                onChanged: (value) {
                  setState(() {
                    _selectedEkubType = value;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: Text('Business'),
                value: 'Business',
                groupValue: _selectedEkubType,
                onChanged: (value) {
                  setState(() {
                    _selectedEkubType = value;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: Text('Property'),
                value: 'Property',
                groupValue: _selectedEkubType,
                onChanged: (value) {
                  setState(() {
                    _selectedEkubType = value;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Modal for editing Ekub Amount
  void _editAmount() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Ekub Amount',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                value: _selectedAmount,
                items: ['500 birr', '1,000 birr', '1,500 birr']
                    .map((amount) => DropdownMenuItem<String>(
                        value: amount, child: Text(amount)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedAmount = value;
                  });
                  Navigator.pop(context);
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailCard(String title, String subtitle,
      {bool hasEditIcon = false, VoidCallback? onEdit}) {
    return Card(
      color: Colors.white,
      elevation: 5,
      shadowColor: Colors.black12,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: hasEditIcon
            ? IconButton(
                icon: Icon(Icons.edit, color: Colors.black54),
                onPressed: onEdit,
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ekub',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            )),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.black,
          tabs: [
            Tab(text: 'Details'),
            Tab(text: 'Connections'),
            Tab(text: 'Options'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Details Tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildDetailCard('Ekub Type', _selectedEkubType!,
                    hasEditIcon: true, onEdit: _editEkubType),
                _buildDetailCard('Ekub Amount', _selectedAmount!,
                    hasEditIcon: true, onEdit: _editAmount),
                _buildDetailCard('Announcement Date', 'Jan 14, 2024'),
                _buildDetailCard('Current Users', '300 Users'),
              ],
            ),
          ),

          // Connections Tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  color: Colors.white,
                  elevation: 5,
                  shadowColor: Colors.black12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text('Groups'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Navigate to Groups page
                    },
                  ),
                ),
                Divider(),
                Card(
                  color: Colors.white,
                  elevation: 5,
                  shadowColor: Colors.black12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text('Participants'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Navigate to Participants page
                    },
                  ),
                ),
              ],
            ),
          ),

          // Options Tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Choose contribution amount',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedAmount,
                    items: ['500 birr', '1,000 birr', '1,500 birr']
                        .map((amount) => DropdownMenuItem<String>(
                            value: amount, child: Text(amount)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedAmount = value;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('Select Ekub Type',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Column(
                    children: [
                      RadioListTile<String>(
                        title: Text('Business'),
                        value: 'Business',
                        groupValue: _selectedEkubType,
                        onChanged: (value) {
                          setState(() {
                            _selectedEkubType = value;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: Text('Personal'),
                        value: 'Personal',
                        groupValue: _selectedEkubType,
                        onChanged: (value) {
                          setState(() {
                            _selectedEkubType = value;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: Text('Property'),
                        value: 'Property',
                        groupValue: _selectedEkubType,
                        onChanged: (value) {
                          setState(() {
                            _selectedEkubType = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
