import 'package:flutter/material.dart';
import '../models/tenant_model.dart';
import '../widgets/tenant_card.dart';
import '../widgets/tenant_detail_dialog.dart';

class PenghuniScreen extends StatefulWidget {
  const PenghuniScreen({super.key});

  @override
  State<PenghuniScreen> createState() => _PenghuniScreenState();
}

class _PenghuniScreenState extends State<PenghuniScreen> {
  String _searchQuery = '';
  String _selectedFilter = 'Semua Kost';
  
  final List<Tenant> _tenants = [
    Tenant(
      id: '1',
      name: 'Ahmad Fauzi',
      phone: '081234567890',
      email: 'ahmad.fauzi@email.com',
      roomNumber: '101',
      kostName: 'Green Valley Kost',
      kostLocation: 'Jl. Sudirman No. 123, Jakarta',
      moveInDate: DateTime(2024, 1, 15),
      monthlyRent: 1500000,
    ),
    Tenant(
      id: '2',
      name: 'Siti Nurhaliza',
      phone: '082345678901',
      email: 'siti.nurhaliza@email.com',
      roomNumber: '102',
      kostName: 'Green Valley Kost',
      kostLocation: 'Jl. Sudirman No. 123, Jakarta',
      moveInDate: DateTime(2024, 2, 1),
      monthlyRent: 1500000,
    ),
    Tenant(
      id: '3',
      name: 'Budi Santoso',
      phone: '083456789012',
      email: 'budi.santoso@email.com',
      roomNumber: '201',
      kostName: 'Sunrise Boarding House',
      kostLocation: 'Jl. Gatot Subroto No. 45, Jakarta',
      moveInDate: DateTime(2024, 1, 20),
      monthlyRent: 1200000,
    ),
    Tenant(
      id: '4',
      name: 'Dewi Lestari',
      phone: '084567890123',
      email: 'dewi.lestari@email.com',
      roomNumber: '301',
      kostName: 'Peaceful Haven Kost',
      kostLocation: 'Jl. Thamrin No. 67, Jakarta',
      moveInDate: DateTime(2024, 3, 10),
      monthlyRent: 1800000,
    ),
    Tenant(
      id: '5',
      name: 'Eko Prasetyo',
      phone: '085678901234',
      email: 'eko.prasetyo@email.com',
      roomNumber: '103',
      kostName: 'Green Valley Kost',
      kostLocation: 'Jl. Sudirman No. 123, Jakarta',
      moveInDate: DateTime(2024, 2, 15),
      monthlyRent: 1500000,
    ),
  ];

  List<String> get _filterOptions {
    final kostNames = _tenants.map((t) => t.kostName).toSet().toList();
    return ['Semua Kost', ...kostNames];
  }

  List<Tenant> get _filteredTenants {
    return _tenants.where((tenant) {
      final matchesSearch = tenant.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          tenant.phone.contains(_searchQuery) ||
          tenant.kostName.toLowerCase().contains(_searchQuery.toLowerCase());
      
      final matchesFilter = _selectedFilter == 'Semua Kost' || tenant.kostName == _selectedFilter;
      
      return matchesSearch && matchesFilter;
    }).toList();
  }

  int _getKostCount(String kostName) {
    if (kostName == 'Semua Kost') {
      return _tenants.length;
    }
    return _tenants.where((t) => t.kostName == kostName).length;
  }

  void _showTenantDetail(Tenant tenant) {
    showDialog(
      context: context,
      builder: (context) => TenantDetailDialog(
        tenant: tenant,
        onDelete: () {
          setState(() {
            _tenants.removeWhere((t) => t.id == tenant.id);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Penghuni berhasil dihapus'),
              backgroundColor: Color(0xFFE53E3E),
            ),
          );
        },
        onUpdate: (updatedTenant) {
          setState(() {
            final index = _tenants.indexWhere((t) => t.id == updatedTenant.id);
            if (index != -1) {
              _tenants[index] = updatedTenant;
            }
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Data penghuni berhasil diperbarui'),
              backgroundColor: Color(0xFF6B9080),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF6B9080), Color(0xFF5A7A6A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kelola Penghuni',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Kelola data penghuni kost',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${_tenants.length} Penghuni',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Search Bar
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Cari penghuni...',
                          hintStyle: const TextStyle(color: Color(0xFF718096)),
                          prefixIcon: const Icon(Icons.search, color: Color(0xFF718096)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Filter Tabs
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _filterOptions.length,
                itemBuilder: (context, index) {
                  final option = _filterOptions[index];
                  final isSelected = _selectedFilter == option;
                  final count = _getKostCount(option);
                  
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            option,
                            style: TextStyle(
                              color: isSelected ? Colors.white : const Color(0xFF4A5568),
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: isSelected 
                                  ? Colors.white.withOpacity(0.3)
                                  : const Color(0xFFE2E8F0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              count.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                color: isSelected ? Colors.white : const Color(0xFF4A5568),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedFilter = option;
                        });
                      },
                      backgroundColor: Colors.white,
                      selectedColor: const Color(0xFF6B9080),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected ? const Color(0xFF6B9080) : const Color(0xFFE2E8F0),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  );
                },
              ),
            ),

            // Tenant List
            Expanded(
              child: _filteredTenants.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.people_outline,
                            size: 64,
                            color: Color(0xFFCBD5E0),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Tidak ada penghuni',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF718096),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _filteredTenants.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: TenantCard(
                            tenant: _filteredTenants[index],
                            onTap: () => _showTenantDetail(_filteredTenants[index]),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
