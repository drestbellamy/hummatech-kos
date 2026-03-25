import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/announcement_model.dart';
import '../models/rule_category_model.dart';
import '../widgets/announcement_card.dart';
import '../widgets/rule_category_card.dart';
import '../widgets/add_announcement_dialog.dart';
import '../widgets/edit_announcement_dialog.dart';
import '../widgets/add_rule_category_dialog.dart';
import '../widgets/edit_rule_category_dialog.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  int _selectedTab = 0; // 0 = Pengumuman, 1 = Peraturan

  final List<Announcement> _announcements = [
    Announcement(
      id: '1',
      title: 'Pemeliharaan Air',
      description: 'Air akan dimatikan sementara pada tanggal 22 Maret 2026 pukul 08:00 - 12:00 untuk pemeliharaan rutin sistem water heater di semua kamar.',
      kostName: 'Green Valley Kost',
      date: DateTime(2026, 3, 18),
      category: 'Pemeliharaan',
      categoryColor: 'blue',
    ),
    Announcement(
      id: '2',
      title: 'Libur Lebaran 2026',
      description: 'Kantor pengelola kost akan tutup pada tanggal 30 Maret - 3 April 2026. Untuk keadaan darurat, hubungi nomor emergency.',
      kostName: 'Green Valley Kost',
      date: DateTime(2026, 3, 15),
      category: 'Libur',
      categoryColor: 'green',
    ),
    Announcement(
      id: '3',
      title: 'Perbaikan WiFi Selesai',
      description: 'Perbaikan jaringan WiFi di lantai 2 dan 3 telah selesai. Kecepatan internet sekarang sudah kembali normal.',
      kostName: 'Sunrise Boarding House',
      date: DateTime(2026, 3, 12),
      category: 'Fasilitas',
      categoryColor: 'gray',
    ),
  ];

  final List<RuleCategory> _ruleCategories = [
    RuleCategory(
      id: '1',
      title: 'Jam Malam & Keamanan',
      rules: [
        'Jam malam pukul 22:00 WIB untuk tamu',
        'Pintu utama ditutup pukul 23:00 WIB (gunakan kunci kamar untuk akses)',
        'CCTV aktif 24 jam di area umum',
        'Wajib mengisi buku tamu untuk tamu yang menginap',
      ],
    ),
    RuleCategory(
      id: '2',
      title: 'Kebersihan & Kerapihan',
      rules: [
        'Buang sampah di tempat yang telah disediakan',
        'Jaga kebersihan kamar mandi bersama',
        'Tidak boleh menjemur pakaian di balkon depan',
        'Area jemuran tersedia di lantai atas',
      ],
    ),
    RuleCategory(
      id: '3',
      title: 'Larangan',
      rules: [
        'Dilarang membawa senjata tajam, narkoba, atau minuman keras',
        'Dilarang berjudi atau melakukan kegiatan ilegal',
        'Dilarang membuat keributan setelah pukul 22:00',
        'Dilarang memelihara binatang peliharaan',
      ],
    ),
  ];

  void _showAddDialog() async {
    if (_selectedTab == 0) {
      // Add Announcement
      final result = await showDialog<Announcement>(
        context: context,
        builder: (context) => const AddAnnouncementDialog(),
      );

      if (result != null) {
        setState(() {
          _announcements.insert(0, result);
        });
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Pengumuman berhasil ditambahkan'),
              backgroundColor: Color(0xFF6B9080),
            ),
          );
        }
      }
    } else {
      // Add Rule Category
      final result = await showDialog<RuleCategory>(
        context: context,
        builder: (context) => const AddRuleCategoryDialog(),
      );

      if (result != null) {
        setState(() {
          _ruleCategories.insert(0, result);
        });
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Kategori peraturan berhasil ditambahkan'),
              backgroundColor: Color(0xFF6B9080),
            ),
          );
        }
      }
    }
  }

  void _editAnnouncement(Announcement announcement) async {
    final result = await showDialog<Announcement>(
      context: context,
      builder: (context) => EditAnnouncementDialog(announcement: announcement),
    );

    if (result != null) {
      setState(() {
        final index = _announcements.indexWhere((a) => a.id == announcement.id);
        if (index != -1) {
          _announcements[index] = result;
        }
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pengumuman berhasil diperbarui'),
            backgroundColor: Color(0xFF6B9080),
          ),
        );
      }
    }
  }

  void _deleteAnnouncement(Announcement announcement) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                children: [
                  const Text(
                    'Hapus Pengumuman',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2F2F2F),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      color: const Color(0xFF6B7280),
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Message
              const Text(
                'Are you sure you want to delete this Pengumuman? This action cannot be undone.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF3F4F6),
                        foregroundColor: const Color(0xFF6B7280),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _announcements.removeWhere((a) => a.id == announcement.id);
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Pengumuman berhasil dihapus'),
                            backgroundColor: Color(0xFFE53E3E),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFB2C36),
                        foregroundColor: Colors.white,
                        elevation: 4,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        shadowColor: Colors.black.withValues(alpha: 0.1),
                      ),
                      child: const Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editRuleCategory(RuleCategory category) async {
    final result = await showDialog<RuleCategory>(
      context: context,
      builder: (context) => EditRuleCategoryDialog(category: category),
    );

    if (result != null) {
      setState(() {
        final index = _ruleCategories.indexWhere((c) => c.id == category.id);
        if (index != -1) {
          _ruleCategories[index] = result;
        }
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kategori peraturan berhasil diperbarui'),
            backgroundColor: Color(0xFF6B9080),
          ),
        );
      }
    }
  }

  void _deleteRuleCategory(RuleCategory category) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Hapus Kategori Peraturan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2F2F2F),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      color: const Color(0xFF6B7280),
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Message
              const Text(
                'Are you sure you want to delete this rule category? This action cannot be undone.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF3F4F6),
                        foregroundColor: const Color(0xFF6B7280),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _ruleCategories.removeWhere((c) => c.id == category.id);
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Kategori peraturan berhasil dihapus'),
                            backgroundColor: Color(0xFFE53E3E),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFB2C36),
                        foregroundColor: Colors.white,
                        elevation: 4,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        shadowColor: Colors.black.withValues(alpha: 0.1),
                      ),
                      child: const Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
          // Header with gradient - Full width edge-to-edge with status bar
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6B9080), Color(0xFF4F6F5F)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                // Status bar space
                SizedBox(height: MediaQuery.of(context).padding.top),
                // Content
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Informasi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Kelola informasi pengumuman & peraturan kost',
                        style: TextStyle(
                          color: Color(0xFFA8D5BA),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

            // Tab Selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedTab = 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedTab == 0
                                  ? const Color(0xFF6B9080)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: _selectedTab == 0
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.1),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.campaign,
                                  size: 16,
                                  color: _selectedTab == 0
                                      ? Colors.white
                                      : const Color(0xFF6B7280),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Pengumuman',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: _selectedTab == 0
                                        ? Colors.white
                                        : const Color(0xFF6B7280),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedTab = 1),
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedTab == 1
                                  ? const Color(0xFF6B9080)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: _selectedTab == 1
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.1),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.description,
                                  size: 16,
                                  color: _selectedTab == 1
                                      ? Colors.white
                                      : const Color(0xFF6B7280),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Peraturan',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: _selectedTab == 1
                                        ? Colors.white
                                        : const Color(0xFF6B7280),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Add Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _showAddDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B9080),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        _selectedTab == 0
                            ? 'Tambah Pengumuman'
                            : 'Tambah Kategori Peraturan',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // List
            Expanded(
              child: _selectedTab == 0
                  ? _announcements.isEmpty
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 64,
                                color: Color(0xFFCBD5E0),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Belum ada data',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF718096),
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          itemCount: _announcements.length,
                          itemBuilder: (context, index) {
                            return AnnouncementCard(
                              announcement: _announcements[index],
                              onEdit: () => _editAnnouncement(_announcements[index]),
                              onDelete: () => _deleteAnnouncement(_announcements[index]),
                            );
                          },
                        )
                  : ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      children: [
                        // Blue info banner
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            border: Border.all(color: const Color(0xFFBEDBFF)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.info_outline,
                                color: Color(0xFF1447E6),
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Peraturan berlaku untuk semua kost',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF1447E6),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Semua perubahan akan diterapkan ke seluruh penghuni di semua kost.',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF1447E6),
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Rule categories
                        ..._ruleCategories.map((category) => RuleCategoryCard(
                          category: category,
                          onEdit: () => _editRuleCategory(category),
                          onDelete: () => _deleteRuleCategory(category),
                        )),
                      ],
                    ),
            ),
          ],
        ),
    );
  }
}
