import 'package:flutter/material.dart';

class SquareBox {
  final String id;
  final GlobalKey key;

  SquareBox(this.id) : key = GlobalKey();
}

class SquareBoxList extends StatelessWidget {
  final int startId;
  final int endId;
  final void Function(String id)? onTap;

  SquareBoxList({
    required this.startId,
    required this.endId,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final boxes = List.generate(
      endId - startId + 1,
          (index) => SquareBox('box_${startId + index}'),
    );

    return ListView(
      padding: EdgeInsets.all(16),
      children: boxes.map((box) {
        return GestureDetector(
          onTap: () => onTap?.call(box.id),
          child: Container(
            key: box.key,
            margin: EdgeInsets.symmetric(vertical: 8),
            width: 100,
            height: 100,
            color: Colors.blue,
            child: Center(
              child: Text(
                box.id,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
