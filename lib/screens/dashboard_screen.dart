import 'package:flutter/material.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/stats_card.dart';
import '../widgets/room_occupancy_chart.dart';
import '../widgets/quick_action_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DashboardHeader(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stats Grid
                    Row(
                      children: [
                        Expanded(
                          child: StatsCard(
                            icon: Icons.apartment,
                            value: '8',
                            label: 'Total Kost',
                            iconColor: const Color(0xFF6B9080),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatsCard(
                            icon: Icons.meeting_room,
                            value: '64',
                            label: 'Total Kamar',
                            iconColor: const Color(0xFF6B9080),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: StatsCard(
                            icon: Icons.home,
                            value: '12',
                            label: 'Kamar Kosong',
                            iconColor: const Color(0xFFE8A87C),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatsCard(
                            icon: Icons.people,
                            value: '52',
                            label: 'Total Penghuni',
                            iconColor: const Color(0xFF6B9080),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: StatsCard(
                            icon: Icons.access_time,
                            value: '8',
                            label: 'Tagihan Belum Bayar',
                            iconColor: const Color(0xFFE8A87C),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatsCard(
                            icon: Icons.check_circle,
                            value: '3',
                            label: 'Menunggu Verifikasi',
                            iconColor: const Color(0xFF6B9080),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Room Occupancy Chart
                    const RoomOccupancyChart(),
                    const SizedBox(height: 24),
                    
                    // Quick Actions
                    const Text(
                      'Aksi Cepat',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    const SizedBox(height: 12),
                    QuickActionCard(
                      icon: Icons.apartment,
                      title: 'Kelola Rumah Kost',
                      iconColor: const Color(0xFF6B9080),
                      onTap: () {},
                    ),
                    const SizedBox(height: 12),
                    QuickActionCard(
                      icon: Icons.people,
                      title: 'Kelola Penghuni',
                      iconColor: const Color(0xFF6B9080),
                      onTap: () {},
                    ),
                    const SizedBox(height: 12),
                    QuickActionCard(
                      icon: Icons.receipt_long,
                      title: 'Kelola Tagihan',
                      iconColor: const Color(0xFFE8A87C),
                      onTap: () {},
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
