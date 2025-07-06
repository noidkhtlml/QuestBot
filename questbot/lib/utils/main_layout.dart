import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final int selectedIndex;
  final Color backgroundColor;

  const MainLayout({
    required this.child,
    required this.selectedIndex,
    super.key,
    this.backgroundColor = Colors.white,
  });

  void _onDestinationSelected(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/chatbot');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/statistici');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/neuro');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/astro');
        break;
      case 5:
        Navigator.pushReplacementNamed(context, '/electronica');
        break;
      case 6:
        Navigator.pushReplacementNamed(context, '/ai');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: (int index) {
              _onDestinationSelected(context, index);
            },
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Acasă'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.chat),
                label: Text('Chat AI'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bar_chart),
                label: Text('Statistici'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.calculate),
                label: Text('Matematică'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.public),
                label: Text('Astronomie'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.memory),
                label: Text('Electronică'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.info),
                label: Text('AI'),
              ),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(child: child),
        ],
      ),
    );
  }
}
