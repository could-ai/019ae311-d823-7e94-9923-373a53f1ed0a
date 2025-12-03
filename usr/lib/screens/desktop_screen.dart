import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/desktop_provider.dart';
import '../widgets/taskbar.dart';
import '../widgets/start_menu.dart';
import '../widgets/window_widget.dart';
import '../utils/constants.dart';

class DesktopScreen extends StatelessWidget {
  const DesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Desktop Background
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFE3F2FD), // Very light blue
                    Color(0xFF90CAF9), // Light blue
                    Color(0xFF42A5F5), // Blue
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
              child: Stack(
                children: [
                  // Abstract shapes to mimic the "Bloom" wallpaper
                  Positioned(
                    top: -100,
                    left: -100,
                    child: Container(
                      width: 600,
                      height: 600,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue.withOpacity(0.3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.5),
                            blurRadius: 100,
                            spreadRadius: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 400,
                      height: 400,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.2),
                            blurRadius: 150,
                            spreadRadius: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. Desktop Icons
          Positioned.fill(
            bottom: AppTheme.taskbarHeight,
            child: GridView.count(
              crossAxisCount: 1, // Vertical list effectively for the first column
              childAspectRatio: 1.0,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              padding: const EdgeInsets.all(16),
              scrollDirection: Axis.vertical,
              // This is a hacky way to get a column of icons on the left
              // A real desktop grid is more complex
              children: [
                _DesktopIcon(
                  icon: Icons.computer,
                  label: 'This PC',
                  onTap: () => Provider.of<DesktopProvider>(context, listen: false)
                      .openWindow('pc', 'This PC', Icons.computer, const Center(child: Text('This PC Content'))),
                ),
                _DesktopIcon(
                  icon: Icons.delete_outline,
                  label: 'Recycle Bin',
                  onTap: () {},
                ),
                _DesktopIcon(
                  icon: AppAssets.edge,
                  label: 'Microsoft Edge',
                  onTap: () => Provider.of<DesktopProvider>(context, listen: false)
                      .openWindow('edge', 'Microsoft Edge', AppAssets.edge, const Center(child: Text('Edge Browser'))),
                ),
              ],
            ),
          ),
          
          // Limit the grid width so it doesn't take up the whole screen
          Positioned(
            left: 0,
            top: 0,
            bottom: AppTheme.taskbarHeight,
            width: 100,
            child: Column(
              children: [
                const SizedBox(height: 16),
                _DesktopIcon(
                  icon: Icons.computer,
                  label: 'This PC',
                  onTap: () => Provider.of<DesktopProvider>(context, listen: false)
                      .openWindow('pc', 'This PC', Icons.computer, const Center(child: Text('This PC Content'))),
                ),
                const SizedBox(height: 16),
                _DesktopIcon(
                  icon: Icons.delete_outline,
                  label: 'Recycle Bin',
                  onTap: () {},
                ),
                const SizedBox(height: 16),
                _DesktopIcon(
                  icon: AppAssets.edge,
                  label: 'Microsoft Edge',
                  onTap: () => Provider.of<DesktopProvider>(context, listen: false)
                      .openWindow('edge', 'Microsoft Edge', AppAssets.edge, const Center(child: Text('Edge Browser'))),
                ),
              ],
            ),
          ),

          // 3. Windows Layer
          Consumer<DesktopProvider>(
            builder: (context, provider, child) {
              return Stack(
                children: provider.openWindows.map((window) {
                  return WindowWidget(key: ValueKey(window.id), window: window);
                }).toList(),
              );
            },
          ),

          // 4. Start Menu (Overlay)
          const StartMenu(),

          // 5. Taskbar (Bottom)
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Taskbar(),
          ),
        ],
      ),
    );
  }
}

class _DesktopIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DesktopIcon({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_DesktopIcon> createState() => _DesktopIconState();
}

class _DesktopIconState extends State<_DesktopIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: 80,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _isHovered ? Colors.white.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: _isHovered 
                ? Border.all(color: Colors.white.withOpacity(0.2)) 
                : Border.all(color: Colors.transparent),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 32, color: Colors.white),
              const SizedBox(height: 4),
              Text(
                widget.label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 2,
                      color: Colors.black54,
                    ),
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
