import 'package:flutter/material.dart';

class ShipmentTile extends StatelessWidget {
  final String title;
  final int? totalShipment;
  final IconData icon;
  const ShipmentTile({
    super.key,
    required this.title,
    required this.icon,
    required this.totalShipment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).primaryColor,
              size: 20,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "$totalShipment",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
