import 'package:flutter/material.dart';
import '../models/room_model.dart';
import '../widgets/add_tenant_dialog.dart';

class RoomDetailScreen extends StatelessWidget {
  final Room room;
  final String kostName;

  const RoomDetailScreen({
    super.key,
    required this.room,
    required this.kostName,
  });

  String _formatPrice(double price) {
    return 'Rp ${price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    )}';
  }

  @override
  Widget build(BuildContext context) {
    // Extract room number from name (e.g., "Room A-101" -> "A-101")
    final roomNumber = room.name.replaceFirst('Room ', '');

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F8),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF6B8E7A),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 15,
                    offset: Offset(0, 10),
                  ),
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(8),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kamar $roomNumber',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Color(0xFFA8D5BA),
                                    size: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    kostName,
                                    style: const TextStyle(
                                      color: Color(0xFFA8D5BA),
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
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: room.isOccupied 
                            ? const Color(0xFF00C950)
                            : const Color(0xFFFF6900),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        room.isOccupied ? 'Terisi' : 'Tersedia',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    // Room Information Card
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1A000000),
                            blurRadius: 6,
                            offset: Offset(0, 4),
                          ),
                          BoxShadow(
                            color: Color(0x1A000000),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Informasi Kamar',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2F2F2F),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow(
                            icon: Icons.meeting_room,
                            iconBgColor: const Color(0xFF6B8E7A).withValues(alpha: 0.1),
                            iconColor: const Color(0xFF6B8E7A),
                            label: 'Nomor Kamar',
                            value: roomNumber,
                          ),
                          const SizedBox(height: 12),
                          _buildInfoRow(
                            icon: Icons.attach_money,
                            iconBgColor: const Color(0xFFF2A65A).withValues(alpha: 0.1),
                            iconColor: const Color(0xFFF2A65A),
                            label: 'Harga per Bulan',
                            value: _formatPrice(room.price),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Tenant Information Card (Occupied) or Empty State (Available)
                    if (room.isOccupied && room.tenant != null)
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x1A000000),
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                            BoxShadow(
                              color: Color(0x1A000000),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Informasi Penghuni',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2F2F2F),
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildInfoRow(
                              icon: Icons.person_outline,
                              iconBgColor: const Color(0xFF6B8E7A).withValues(alpha: 0.1),
                              iconColor: const Color(0xFF6B8E7A),
                              label: 'Nama',
                              value: room.tenant!,
                            ),
                            const SizedBox(height: 12),
                            _buildInfoRow(
                              icon: Icons.phone_outlined,
                              iconBgColor: const Color(0xFF6B8E7A).withValues(alpha: 0.1),
                              iconColor: const Color(0xFF6B8E7A),
                              label: 'Telepon',
                              value: '081234567890',
                            ),
                            const SizedBox(height: 12),
                            _buildInfoRow(
                              icon: Icons.calendar_today_outlined,
                              iconBgColor: const Color(0xFF6B8E7A).withValues(alpha: 0.1),
                              iconColor: const Color(0xFF6B8E7A),
                              label: 'Tanggal Masuk',
                              value: '15 Januari 2024',
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x1A000000),
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                            BoxShadow(
                              color: Color(0x1A000000),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFEDD4),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.person_add_outlined,
                                color: Color(0xFFF2A65A),
                                size: 32,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Belum Ada Penghuni',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2F2F2F),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Kamar ini masih kosong dan tersedia untuk penghuni baru',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6B7280),
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  final result = await showDialog(
                                    context: context,
                                    builder: (context) => AddTenantDialog(
                                      room: room,
                                      kostName: kostName,
                                    ),
                                  );

                                  if (result != null && context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Penghuni ${result['name']} berhasil ditambahkan',
                                        ),
                                        backgroundColor: const Color(0xFF6B8E7A),
                                      ),
                                    );
                                    // Navigate back to refresh the room list
                                    Navigator.pop(context);
                                  }
                                },
                                icon: const Icon(
                                  Icons.person_add,
                                  size: 20,
                                ),
                                label: const Text(
                                  'Tambah Penghuni',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF6B8E7A),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 2,
                                  shadowColor: Colors.black.withValues(alpha: 0.1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2F2F2F),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
