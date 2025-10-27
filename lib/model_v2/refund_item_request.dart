class RefundItemRequest {
  final int lineItemId;
  final int count;

  RefundItemRequest({
    required this.lineItemId,
    required this.count,
  });

  factory RefundItemRequest.fromJson(Map<String, dynamic> json) {
    return RefundItemRequest(
      lineItemId: json['line_item_id'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'line_item_id': lineItemId,
      'count': count,
    };
  }
}