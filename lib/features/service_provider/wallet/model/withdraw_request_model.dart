class WithdrawRequestModel {
  const WithdrawRequestModel({
    required this.amount,
    required this.status,
    required this.dateLabel,
  });

  final String amount;
  final String status;
  final String dateLabel;
}
