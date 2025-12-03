import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/desktop_provider.dart';
import '../utils/constants.dart';

class WindowWidget extends StatelessWidget {
  final WindowItem window;

  const WindowWidget({super.key, required this.window});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DesktopProvider>(context, listen: false);
    final isMaximized = window.isMaximized;

    if (window.isMinimized) {
      return const SizedBox.shrink();
    }

    return Positioned(
      left: isMaximized ? 0 : window.position.dx,
      top: isMaximized ? 0 : window.position.dy,
      width: isMaximized ? MediaQuery.of(context).size.width : window.size.width,
      height: isMaximized 
          ? MediaQuery.of(context).size.height - AppTheme.taskbarHeight 
          : window.size.height,
      child: GestureDetector(
        onTap: () => provider.activateWindow(window.id),
        onPanUpdate: isMaximized ? null : (details) {
          provider.updateWindowPosition(
            window.id,
            window.position + details.delta,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.windowColor,
            borderRadius: isMaximized ? BorderRadius.zero : BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
            border: Border.all(
              color: Colors.grey.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              // Title Bar
              Container(
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: isMaximized 
                      ? BorderRadius.zero 
                      : const BorderRadius.vertical(top: Radius.circular(8)),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    Icon(window.icon, size: 16, color: Colors.black54),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        window.title,
                        style: const TextStyle(fontSize: 12, color: Colors.black87),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Window Controls
                    _WindowControl(
                      icon: Icons.remove,
                      onTap: () => provider.minimizeWindow(window.id),
                    ),
                    _WindowControl(
                      icon: isMaximized ? Icons.filter_none : Icons.crop_square,
                      onTap: () => provider.maximizeWindow(window.id),
                    ),
                    _WindowControl(
                      icon: Icons.close,
                      hoverColor: Colors.red,
                      iconColor: Colors.black87,
                      hoverIconColor: Colors.white,
                      onTap: () => provider.closeWindow(window.id),
                    ),
                  ],
                ),
              ),
              // Content
              Expanded(
                child: ClipRRect(
                  borderRadius: isMaximized 
                      ? BorderRadius.zero 
                      : const BorderRadius.vertical(bottom: Radius.circular(8)),
                  child: window.content,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WindowControl extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? hoverColor;
  final Color? iconColor;
  final Color? hoverIconColor;

  const _WindowControl({
    required this.icon,
    required this.onTap,
    this.hoverColor,
    this.iconColor,
    this.hoverIconColor,
  });

  @override
  State<_WindowControl> createState() => _WindowControlState();
}

class _WindowControlState extends State<_WindowControl> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: 46,
          height: 32,
          color: _isHovered 
              ? (widget.hoverColor ?? Colors.grey[300]) 
              : Colors.transparent,
          child: Icon(
            widget.icon,
            size: 14,
            color: _isHovered 
                ? (widget.hoverIconColor ?? Colors.black87) 
                : (widget.iconColor ?? Colors.black87),
          ),
        ),
      ),
    );
  }
}
