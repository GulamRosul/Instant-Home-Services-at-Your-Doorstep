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
  final String bookingId;
  final String transactionId;
  final String valId;
  final double amount;
  final String? platform;
  final String? apiConnect;
  final String? status;
  final String? sessionKey;
  final String? storeAmount;
  final String? currency;
  final String? bankTranId;
  final String? cardType;
  final String? cardNo;
  final String? cardIssuer;
  final String? cardBrand;
  final String? cardIssuerCountry;
  final String? cardIssuerCountryCode;
  final String? tranDate;
  final String? validatedOn;
  final String? gwVersion;
  final String? riskLevel;
  final String? riskTitle;

  PaymentConfirmRequest({
    required this.bookingId,
    required this.transactionId,
    required this.valId,
    required this.amount,
    this.platform,
    this.apiConnect,
    this.status,
    this.sessionKey,
    this.storeAmount,
    this.currency,
    this.bankTranId,
    this.cardType,
    this.cardNo,
    this.cardIssuer,
    this.cardBrand,
    this.cardIssuerCountry,
    this.cardIssuerCountryCode,
    this.tranDate,
    this.validatedOn,
    this.gwVersion,
    this.riskLevel,
    this.riskTitle,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'bookingId': bookingId,
      'transactionId': transactionId,
      'platform': platform,
      'apiConnect': apiConnect,
      'status': status,
      'sessionKey': sessionKey,
      'valId': valId,
      'amount': double.parse(amount.toString()),
      'storeAmount': storeAmount,
      'currency': currency,
      'bankTranId': bankTranId,
      'cardType': cardType,
      'cardNo': cardNo,
      'cardIssuer': cardIssuer,
      'cardBrand': cardBrand,
      'cardIssuerCountry': cardIssuerCountry,
      'cardIssuerCountryCode': cardIssuerCountryCode,
      'tranDate': tranDate,
      'validatedOn': validatedOn,
      'gwVersion': gwVersion,
      'riskLevel': riskLevel,
      'riskTitle': riskTitle,

      // Keep the existing backend contract keys too.
      'val_id': valId,
      'tran_id': transactionId,
      'store_amount': storeAmount,
      'currency_type': currency,
      'bank_tran_id': bankTranId,
      'card_type': cardType,
      'card_no': cardNo,
      'card_issuer': cardIssuer,
      'card_brand': cardBrand,
      'card_issuer_country': cardIssuerCountry,
      'card_issuer_country_code': cardIssuerCountryCode,
      'tran_date': tranDate,
      'validated_on': validatedOn,
      'gw_version': gwVersion,
      'risk_level': riskLevel,
      'risk_title': riskTitle,
    };

    data.removeWhere((_, value) => value == null);
    return data;
  }
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
