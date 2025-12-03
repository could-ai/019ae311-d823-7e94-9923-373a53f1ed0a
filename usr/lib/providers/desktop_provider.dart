import 'package:flutter/material.dart';

class WindowItem {
  final String id;
  final String title;
  final IconData icon;
  final Widget content;
  Offset position;
  Size size;
  bool isMinimized;
  bool isMaximized;

  WindowItem({
    required this.id,
    required this.title,
    required this.icon,
    required this.content,
    this.position = const Offset(100, 100),
    this.size = const Size(600, 400),
    this.isMinimized = false,
    this.isMaximized = false,
  });
}

class DesktopProvider with ChangeNotifier {
  bool _isStartMenuOpen = false;
  final List<WindowItem> _openWindows = [];
  String? _activeWindowId;

  bool get isStartMenuOpen => _isStartMenuOpen;
  List<WindowItem> get openWindows => _openWindows;
  String? get activeWindowId => _activeWindowId;

  void toggleStartMenu() {
    _isStartMenuOpen = !_isStartMenuOpen;
    notifyListeners();
  }

  void closeStartMenu() {
    if (_isStartMenuOpen) {
      _isStartMenuOpen = false;
      notifyListeners();
    }
  }

  void openWindow(String id, String title, IconData icon, Widget content) {
    // Check if window already exists
    final existingIndex = _openWindows.indexWhere((w) => w.id == id);
    if (existingIndex != -1) {
      // If minimized, restore it
      _openWindows[existingIndex].isMinimized = false;
      _activeWindowId = id;
      // Move to end (bring to front)
      final window = _openWindows.removeAt(existingIndex);
      _openWindows.add(window);
    } else {
      // Create new window
      // Stagger position slightly for new windows
      double offset = 50.0 * (_openWindows.length % 5);
      
      _openWindows.add(WindowItem(
        id: id,
        title: title,
        icon: icon,
        content: content,
        position: Offset(100 + offset, 100 + offset),
      ));
      _activeWindowId = id;
    }
    _isStartMenuOpen = false; // Close start menu when opening app
    notifyListeners();
  }

  void closeWindow(String id) {
    _openWindows.removeWhere((w) => w.id == id);
    if (_activeWindowId == id) {
      _activeWindowId = _openWindows.isNotEmpty ? _openWindows.last.id : null;
    }
    notifyListeners();
  }

  void minimizeWindow(String id) {
    final index = _openWindows.indexWhere((w) => w.id == id);
    if (index != -1) {
      _openWindows[index].isMinimized = true;
      if (_activeWindowId == id) {
        _activeWindowId = null; // No active window if current is minimized
      }
      notifyListeners();
    }
  }

  void maximizeWindow(String id) {
     final index = _openWindows.indexWhere((w) => w.id == id);
    if (index != -1) {
      _openWindows[index].isMaximized = !_openWindows[index].isMaximized;
      notifyListeners();
    }
  }

  void activateWindow(String id) {
    if (_activeWindowId == id) return;
    
    final index = _openWindows.indexWhere((w) => w.id == id);
    if (index != -1) {
      final window = _openWindows.removeAt(index);
      window.isMinimized = false;
      _openWindows.add(window);
      _activeWindowId = id;
      notifyListeners();
    }
  }

  void updateWindowPosition(String id, Offset newPos) {
    final index = _openWindows.indexWhere((w) => w.id == id);
    if (index != -1) {
      _openWindows[index].position = newPos;
      notifyListeners();
    }
  }
  
  void updateWindowSize(String id, Size newSize) {
    final index = _openWindows.indexWhere((w) => w.id == id);
    if (index != -1) {
      _openWindows[index].size = newSize;
      notifyListeners();
    }
  }
}
