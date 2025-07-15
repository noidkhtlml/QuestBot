import 'package:flutter/material.dart';

class CapitolBox {
  final int id;
  final String titlu;

  CapitolBox({required this.id, required this.titlu});
}

class CapitolBoxList extends StatelessWidget {
  final List<CapitolBox> capitole;
  final void Function(int id) onTap;

  const CapitolBoxList({
    super.key,
    required this.capitole,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: capitole.map((c) => buildCard(context, c)).toList(),
    );
  }

  Widget buildCard(BuildContext context, CapitolBox capitol) {
    return InkWell(
      onTap: () => onTap(capitol.id),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.grey[400]!, width: 2),
        ),
        child: Container(
          width: 210,
          height: 120,
          alignment: Alignment.center,
          child: Text(
            capitol.titlu,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

}
