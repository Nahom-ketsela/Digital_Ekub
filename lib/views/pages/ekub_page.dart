import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

class EkubPage extends StatefulWidget {
  static String route = 'ekub-page';

  @override
  _EkubPageState createState() => _EkubPageState();
}

class _EkubPageState extends State<EkubPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _selectedAmount = '1,000 birr';
  String? _selectedEkubType = 'Personal';
  String? _selectedDuration = '1 Month';
  final _storage = GetStorage();
  late String currentUserEmail;

  DateTime? _announcementDate;
  String? _userTurnMessage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    currentUserEmail = _storage.read('email') ?? '';
  }

  // Map amount to announcement dates
  DateTime _getAnnouncementDateForAmount(String amount) {
    switch (amount) {
      case '500 birr':
        return DateTime.now()
            .add(Duration(days: 3)); // Custom date for 500 birr
      case '1,000 birr':
        return DateTime.now()
            .add(Duration(days: 7)); // Custom date for 1,000 birr
      case '1,500 birr':
        return DateTime.now()
            .add(Duration(days: 10)); // Custom date for 1,500 birr
      default:
        return DateTime.now().add(Duration(days: 7)); // Default date
    }
  }

  // Function to create a new Ekub group
  void _createGroup() async {
    String groupId = DateTime.now().millisecondsSinceEpoch.toString();

    // Get the appropriate announcement date based on selected amount
    DateTime announcementDate = _getAnnouncementDateForAmount(_selectedAmount!);

    await _firestore.collection('ekub_groups').doc(groupId).set({
      'type': _selectedEkubType,
      'amount': _selectedAmount,
      'duration': _selectedDuration,
      'announcementDate': announcementDate, // Use the determined date
      'participants': [currentUserEmail],
      'turns': [],
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Group Created Successfully!'),
    ));
  }

  // Function to join an existing group
  void _joinGroup(String groupId) async {
    DocumentReference groupRef =
        _firestore.collection('ekub_groups').doc(groupId);
    DocumentSnapshot groupSnapshot = await groupRef.get();

    List<dynamic> participants = groupSnapshot['participants'] ?? [];
    if (!participants.contains(currentUserEmail)) {
      participants.add(currentUserEmail);
      await groupRef.update({'participants': participants});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('You have joined the group!'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('You are already in this group!'),
      ));
    }
  }

  // Function to fetch group details and set announcement date and user turn status
  void _fetchGroupDetails(String groupId) async {
    DocumentSnapshot groupSnapshot =
        await _firestore.collection('ekub_groups').doc(groupId).get();
    Map<String, dynamic> groupData =
        groupSnapshot.data() as Map<String, dynamic>;

    setState(() {
      // Fetch the actual announcement date from the database
      _announcementDate = (groupData['announcementDate'] as Timestamp).toDate();
      List<dynamic> turns = groupData['turns'] ?? [];
      int userIndex = turns.indexOf(currentUserEmail);
      _userTurnMessage = userIndex == 0
          ? "It's your turn to take the money!"
          : userIndex > 0
              ? "Wait for your turn."
              : "You need to pay.";
    });
  }

  // Fetch all groups from Firestore
  Widget _buildGroupsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('ekub_groups').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> group =
                  docs[index].data() as Map<String, dynamic>;
              return Card(
                child: ListTile(
                  title: Text('${group['amount']} - ${group['type']}'),
                  subtitle: Text('${group['duration']}'),
                  trailing: ElevatedButton(
                    onPressed: () => _joinGroup(docs[index].id),
                    child: Text('Join'),
                  ),
                  onTap: () {
                    _fetchGroupDetails(docs[index].id);
                  },
                ),
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  // Build the group creation form
  Widget _buildCreateGroupForm() {
    return Column(
      children: [
        _buildDropdown<String>(
          value: _selectedEkubType,
          label: 'Ekub Type',
          items: ['Personal', 'Business', 'Property'],
          onChanged: (value) => setState(() => _selectedEkubType = value),
        ),
        _buildDropdown<String>(
          value: _selectedAmount,
          label: 'Amount',
          items: ['500 birr', '1,000 birr', '1,500 birr'],
          onChanged: (value) => setState(() => _selectedAmount = value),
        ),
        _buildDropdown<String>(
          value: _selectedDuration,
          label: 'Duration',
          items: ['1 Month', '3 Months', '6 Months'],
          onChanged: (value) => setState(() => _selectedDuration = value),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: _createGroup,
          child: Text('Create Group'),
        ),
      ],
    );
  }

  // Helper method to build dropdowns
  Widget _buildDropdown<T>({
    required T? value,
    required String label,
    required List<String> items,
    required Function(T?) onChanged,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items
          .map((item) => DropdownMenuItem<T>(
                value: item as T,
                child: Text(item),
              ))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(labelText: label),
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
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
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
        title: Text('Ekub'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Groups'),
            Tab(text: 'Create Group'),
            Tab(text: 'Details'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Groups Tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildGroupsList(),
          ),
          // Create Group Tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: _buildCreateGroupForm(),
            ),
          ),
          // Details Tab
          Column(
            children: [
              _buildDetailCard('Announcement Date',
                  _announcementDate?.toString() ?? '12-2-2025, 2:20:25'),
              _buildDetailCard('Your Turn Status', _userTurnMessage ?? '3'),
            ],
          ),
        ],
      ),
    );
  }
}
