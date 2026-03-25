import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/kost_card.dart';
import '../widgets/add_kost_dialog.dart';
import '../widgets/edit_kost_dialog.dart';
import '../models/kost_model.dart';

class KostScreen extends StatefulWidget {
  const KostScreen({super.key});

  @override
  State<KostScreen> createState() => _KostScreenState();
}

class _KostScreenState extends State<KostScreen> {
  final List<Kost> kostList = [
    Kost(
      name: 'Green Valley Kost',
      address: 'Jl. Sudirman No. 123, Jakarta',
      rooms: 12,
    ),
    Kost(
      name: 'Sunrise Boarding House',
      address: 'Jl. Gatot Subroto No. 45, Jakarta',
      rooms: 8,
    ),
    Kost(
      name: 'Peaceful Haven Kost',
      address: 'Jl. Thamrin No. 67, Jakarta',
      rooms: 10,
    ),
    Kost(
      name: 'Urban Residence',
      address: 'Jl. HR Rasuna Said No. 89, Jakarta',
      rooms: 15,
    ),
  ];

  void _showAddKostDialog() async {
    final result = await showDialog(
      context: context,
      builder: (context) => const AddKostDialog(),
    );

    if (result != null) {
      setState(() {
        kostList.add(
          Kost(
            name: result['name'],
            address: result['address'],
            rooms: result['rooms'],
          ),
        );
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Boarding house added successfully'),
            backgroundColor: Color(0xFF6B9080),
          ),
        );
      }
    }
  }

  void _showEditKostDialog(int index) async {
    final result = await showDialog(
      context: context,
      builder: (context) => EditKostDialog(kost: kostList[index]),
    );

    if (result != null) {
      setState(() {
        kostList[index] = Kost(
          name: result['name'],
          address: result['address'],
          rooms: result['rooms'],
        );
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Boarding house updated successfully'),
            backgroundColor: Color(0xFF6B9080),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Set status bar to light content (white icons)
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Header
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF6B9080),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                // Status bar space
                SizedBox(height: MediaQuery.of(context).padding.top),
                // Content
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Boarding Houses',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Manage your properties',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
            
            // Kost List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: kostList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: KostCard(
                      kost: kostList[index],
                      onEdit: () => _showEditKostDialog(index),
                      onDelete: () {
                        setState(() {
                          kostList.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Boarding house deleted'),
                            backgroundColor: Color(0xFFE53E3E),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddKostDialog,
        backgroundColor: const Color(0xFFE8A87C),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
