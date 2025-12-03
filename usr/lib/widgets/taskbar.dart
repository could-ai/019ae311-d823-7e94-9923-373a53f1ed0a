import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/desktop_provider.dart';
import '../utils/constants.dart';

class Taskbar extends StatelessWidget {
  const Taskbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppTheme.taskbarHeight,
      decoration: BoxDecoration(
        color: AppTheme.taskbarColor.withOpacity(0.85),
        border: const Border(top: BorderSide(color: Colors.white24, width: 1)),
      ),
      child: Row(
        children: [
          // Start Button and Pinned Apps (Centered)
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _TaskbarIcon(
                  icon: AppAssets.windowsLogo,
                  isStartButton: true,
                  onTap: () {
                    Provider.of<DesktopProvider>(context, listen: false).toggleStartMenu();
                  },
                ),
                const SizedBox(width: 4),
                _TaskbarIcon(
                  icon: AppAssets.edge,
                  onTap: () => _launchApp(context, 'edge', 'Microsoft Edge', AppAssets.edge, const Center(child: Text('Edge Browser Placeholder'))),
                ),
                const SizedBox(width: 4),
                _TaskbarIcon(
                  icon: AppAssets.explorer,
                  onTap: () => _launchApp(context, 'explorer', 'File Explorer', AppAssets.explorer, const Center(child: Text('File Explorer Placeholder'))),
                ),
                const SizedBox(width: 4),
                _TaskbarIcon(
                  icon: AppAssets.store,
                  onTap: () => _launchApp(context, 'store', 'Microsoft Store', AppAssets.store, const Center(child: Text('Store Placeholder'))),
                ),
                const SizedBox(width: 4),
                _TaskbarIcon(
                  icon: AppAssets.settings,
                  onTap: () => _launchApp(context, 'settings', 'Settings', AppAssets.settings, const Center(child: Text('Settings Placeholder'))),
                ),
              ],
            ),
          ),
          // System Tray (Right)
          const _SystemTray(),
        ],
      ),
    );
  }

  void _launchApp(BuildContext context, String id, String title, IconData icon, Widget content) {
    Provider.of<DesktopProvider>(context, listen: false).openWindow(id, title, icon, content);
  }
}

class _TaskbarIcon extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isStartButton;

  const _TaskbarIcon({
    required this.icon,
    required this.onTap,
    this.isStartButton = false,
  });

  @override
  State<_TaskbarIcon> createState() => _TaskbarIconState();
}

class _TaskbarIconState extends State<_TaskbarIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _isHovered ? Colors.white.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(
            widget.icon,
            color: widget.isStartButton ? Colors.blue : Colors.black87,
            size: 24,
          ),
        ),
      ),
    );
  }
}

class _SystemTray extends StatelessWidget {
  const _SystemTray();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          const Icon(Icons.keyboard_arrow_up, size: 20, color: Colors.black54),
          const SizedBox(width: 12),
          const Icon(Icons.wifi, size: 20, color: Colors.black87),
          const SizedBox(width: 12),
          const Icon(Icons.volume_up, size: 20, color: Colors.black87),
          const SizedBox(width: 12),
          const Icon(Icons.battery_full, size: 20, color: Colors.black87),
          const SizedBox(width: 12),
          _Clock(),
        ],
      ),
    );
  }
}

class _Clock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        final now = DateTime.now();
        final time = DateFormat('h:mm a').format(now);
        final date = DateFormat('M/d/yyyy').format(now);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(time, style: const TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w500)),
            Text(date, style: const TextStyle(fontSize: 12, color: Colors.black87)),
          ],
        );
      },
    );
  }
}
