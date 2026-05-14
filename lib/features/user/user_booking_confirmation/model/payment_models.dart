class PaymentInitiateRequest {
  final String bookingId;
  final int amount;

  PaymentInitiateRequest({required this.bookingId, required this.amount});

  Map<String, dynamic> toJson() => {'bookingId': bookingId, 'amount': amount};
}

class PaymentInitiateResponse {
  final bool success;
  final String transactionId;
  final int amount;
  final String storeId;
  final String storePassword;
  final bool isSandbox;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final String customerAddress;

  PaymentInitiateResponse({
    required this.success,
    required this.transactionId,
    required this.amount,
    required this.storeId,
    required this.storePassword,
    required this.isSandbox,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.customerAddress,
  });

  factory PaymentInitiateResponse.fromJson(Map<String, dynamic> json) {
    return PaymentInitiateResponse(
      success: json['success'] ?? false,
      transactionId: json['transactionId'] ?? '',
      amount: json['amount'] ?? 0,
      storeId: json['storeId'] ?? '',
      storePassword: json['storePassword'] ?? '',
      isSandbox: json['isSandbox'] ?? false,
      customerName: json['customerName'] ?? '',
      customerEmail: json['customerEmail'] ?? '',
      customerPhone: json['customerPhone'] ?? '',
      customerAddress: json['customerAddress'] ?? '',
    );
  }
}

class PaymentConfirmRequest {
  final String valId;
  final String tranId;

  PaymentConfirmRequest({required this.valId, required this.tranId});

  Map<String, dynamic> toJson() => {'val_id': valId, 'tran_id': tranId};
}

class PaymentFailRequest {
  final String transactionId;
  final String status;
  final String reason;

  PaymentFailRequest({
    required this.transactionId,
    required this.status,
    required this.reason,
  });

  Map<String, dynamic> toJson() => {
    'transactionId': transactionId,
    'status': status,
    'reason': reason,
  };
}

class Coupon {
  final String id;
  final String couponCode;
  final int discountPercentage;
  final bool isActive;
  final String createdAt;
  final String updatedAt;

  Coupon({
    required this.id,
    required this.couponCode,
    required this.discountPercentage,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'] ?? '',
      couponCode: json['couponCode'] ?? '',
      discountPercentage: json['discountPercentage'] ?? 0,
      isActive: json['isActive'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'couponCode': couponCode,
    'discountPercentage': discountPercentage,
    'isActive': isActive,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}

class CouponResponse {
  final String id;
  final String couponCode;
  final int discountPercentage;
  final int totalUselimit;
  final int currentUselimit;
  final String expireAt;
  final bool isActive;
  final String createdAt;
  final String updatedAt;

  CouponResponse({
    required this.id,
    required this.couponCode,
    required this.discountPercentage,
    required this.totalUselimit,
    required this.currentUselimit,
    required this.expireAt,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CouponResponse.fromJson(Map<String, dynamic> json) {
    return CouponResponse(
      id: json['id'] ?? '',
      couponCode: json['couponCode'] ?? '',
      discountPercentage: json['discountPercentage'] ?? 0,
      totalUselimit: json['totalUselimit'] ?? 0,
      currentUselimit: json['currentUselimit'] ?? 0,
      expireAt: json['expireAt'] ?? '',
      isActive: json['isActive'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'couponCode': couponCode,
    'discountPercentage': discountPercentage,
    'totalUselimit': totalUselimit,
    'currentUselimit': currentUselimit,
    'expireAt': expireAt,
    'isActive': isActive,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}
