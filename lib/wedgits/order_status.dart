import 'package:flutter/material.dart';

class OrderStatusWidget extends StatelessWidget {
  final int orderStatus;        // e.g. 10, 11, 12, etc.
  final String refundStatus;    // e.g. 'pending', 'refund-accepted', 'non'

  const OrderStatusWidget({
    Key? key,
    required this.orderStatus,
    required this.refundStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color orderColor;
    String orderText;

    // 🟢 ORDER STATUS MAPPING
    switch (orderStatus) {
      case -1:
        // orderText = "Refused";
        orderText = "Canceled";
        orderColor = Colors.red;
        break;
      case 0:
        orderText = "Pending";
        orderColor = Colors.orange;
        break;
      case 1:
        orderText = "Delivered";
        orderColor = Colors.green;
        break;
      case 10:
        // orderText = "In Process";
        orderText = "Order Accepted";
        orderColor = Colors.blue;
        break;
      case 11:
        // orderText = "Items Collecting";
        // orderColor = Colors.teal;
        orderText = "Order Accepted";
        orderColor = Colors.blue;
        break;
      case 12:
        // orderText = "In Transit";
        orderText = "Order Shipped";
        orderColor = Colors.indigo;
        break;
      case 13:
        orderText = "Out for Delivery";
        orderColor = Colors.purple;
        break;
      default:
        orderText = "Unknown";
        orderColor = Colors.grey;
    }

    // 🟣 REFUND STATUS MAPPING
    Color refundColor;
    String refundText;

    switch (refundStatus) {
      case 'pending':
        refundText = "Refund Pending";
        refundColor = Colors.orange;
        break;
      case 'refund-rejected':
        refundText = "Refund Rejected";
        refundColor = Colors.red;
        break;
      case 'refund-accepted':
        refundText = "Refund Accepted";
        refundColor = Colors.green;
        break;
      case 'refund in process':
        refundText = "Refund In Process";
        refundColor = Colors.blue;
        break;
      case 'item collected':
        refundText = "Item Collected";
        refundColor = Colors.teal;
        break;
      case 'in transit':
        // refundText = "Refund In Transit";
        // refundColor = Colors.indigo;
        refundText = "Refund Completed";
        refundColor = Colors.green;
        break;
      case 'refund-completed':
        refundText = "Refund Completed";
        refundColor = Colors.green;
        break;
      default:
        refundText = "Normal Order";
        refundColor = Colors.grey;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ORDER STATUS BADGE
        _buildBadge(orderText, orderColor, Icons.local_shipping),

        if (refundStatus != 'non')
        const SizedBox(width: 5),

        // REFUND STATUS BADGE (only if not "non")
        if (refundStatus != 'non')
          _buildBadge(refundText, refundColor, Icons.autorenew),
      ],
    );
  }

  // 🔹 Reusable badge builder
  Widget _buildBadge(String text, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 12),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w600,),
          ),
        ],
      ),
    );
  }
}
