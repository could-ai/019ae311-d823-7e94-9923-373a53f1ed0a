import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/desktop_provider.dart';
import '../utils/constants.dart';

class StartMenu extends StatelessWidget {
  const StartMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DesktopProvider>(
      builder: (context, provider, child) {
        if (!provider.isStartMenuOpen) return const SizedBox.shrink();

        return Positioned(
          bottom: AppTheme.taskbarHeight + 12,
          left: (MediaQuery.of(context).size.width - AppTheme.startMenuWidth) / 2,
          child: Container(
            width: AppTheme.startMenuWidth,
            height: AppTheme.startMenuHeight,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F3F9).withOpacity(0.95),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
              border: Border.all(color: Colors.white.withOpacity(0.5)),
            ),
            child: Column(
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: const [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 8),
                        Text('Type here to search', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
                
                // Pinned Apps Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Pinned', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('All apps >', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Grid of Apps
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 6,
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 8,
                    children: [
                      _StartMenuIcon(icon: AppAssets.edge, label: 'Edge'),
                      _StartMenuIcon(icon: Icons.mail, label: 'Mail'),
                      _StartMenuIcon(icon: Icons.calendar_today, label: 'Calendar'),
                      _StartMenuIcon(icon: AppAssets.store, label: 'Store'),
                      _StartMenuIcon(icon: Icons.photo, label: 'Photos'),
                      _StartMenuIcon(icon: AppAssets.settings, label: 'Settings'),
                      _StartMenuIcon(icon: Icons.calculate, label: 'Calculator'),
                      _StartMenuIcon(icon: Icons.alarm, label: 'Clock'),
                      _StartMenuIcon(icon: Icons.note, label: 'Notepad'),
                      _StartMenuIcon(icon: Icons.map, label: 'Maps'),
                      _StartMenuIcon(icon: Icons.movie, label: 'Movies'),
                      _StartMenuIcon(icon: Icons.camera_alt, label: 'Camera'),
                    ],
                  ),
                ),
                
                // Recommended Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Recommended', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _RecommendedItem(icon: Icons.description, title: 'Project Proposal.docx', subtitle: '2h ago'),
                          const SizedBox(width: 32),
                          _RecommendedItem(icon: Icons.image, title: 'Design_Mockup.png', subtitle: 'Yesterday'),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // User Profile Footer
                Container(
                  height: 64,
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.05),
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.blueGrey,
                            child: Icon(Icons.person, size: 20, color: Colors.white),
                          ),
                          const SizedBox(width: 12),
                          const Text('User', style: TextStyle(fontWeight: FontWeight.w500)),
                        ],
                      ),
                      const Icon(Icons.power_settings_new, color: Colors.black87),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StartMenuIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _StartMenuIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 2, spreadRadius: 1),
            ],
          ),
          child: Icon(icon, size: 28, color: Colors.blue),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 11), overflow: TextOverflow.ellipsis),
      ],
    );
  }
}

class _RecommendedItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _RecommendedItem({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueGrey, size: 32),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}
