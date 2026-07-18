# SSLCOMMERZ Native In-App Payment Guide

This guide explains how Protiva502/Kaaj BD should implement SSLCOMMERZ native in-app payment using the Android SDK and iOS framework PDFs downloaded from the SSLCOMMERZ dashboard.

Audience:

- Flutter developer: native SDK bridge, app payment flow, SDK result handling.
- Backend developer: payment session routes, transaction records, SSLCOMMERZ validation, booking status updates.

## Recommended Architecture

Do not let the mobile app decide whether a booking is paid. The app starts the SSLCOMMERZ SDK and receives the SDK result, but the backend must validate the transaction with SSLCOMMERZ before updating the booking/payment record.

```text
Flutter app
  -> POST /api/v1/payment/sslcommerz/initiate
Backend
  -> creates local payment record and transactionId
  -> returns SDK initialization fields
Flutter app
  -> starts Android/iOS SSLCOMMERZ SDK through MethodChannel/native plugin
SSLCOMMERZ SDK
  -> returns TransactionDetails / transaction info to native app
Flutter app
  -> POST /api/v1/payment/sslcommerz/confirm with SDK result fields
Backend
  -> validates valId/tranId/amount/status with SSLCOMMERZ Validation API
  -> marks payment/booking paid only after validation succeeds
Flutter app
  -> shows success, failed, cancelled, or pending state from backend response
```

## Current App State

The current Flutter implementation uses a backend-generated `gatewayUrl` and WebView:

- API constant: `ApiEndpoints.makePayment = '/payment/make-payment'`
- Controller: `lib/features/user/user_booking_confirmation/controller/payment_controller.dart`
- WebView screen: `lib/features/user/user_booking_confirmation/screen/payment_webview_screen.dart`

For native SDK integration, replace the WebView step with a platform bridge:

- Flutter calls backend `initiate`.
- Flutter calls native Android/iOS SDK with returned fields.
- Native SDK returns transaction data to Flutter.
- Flutter sends transaction data to backend `confirm`.

## Android SDK Notes From PDF

### SDK Files And Gradle

The Android PDF says to place the SDK AAR in:

```text
android/app/libs/sslCommerzSdk.aar
```

This project uses Kotlin Gradle DSL: `android/app/build.gradle.kts`. Add the local AAR repository and dependencies there.

```kotlin
repositories {
    flatDir {
        dirs("libs")
    }
}

dependencies {
    implementation("androidx.appcompat:appcompat:1.2.0")
    implementation("com.google.android.material:material:1.2.1")
    implementation("com.google.code.gson:gson:2.8.5")
    implementation("androidx.localbroadcastmanager:localbroadcastmanager:1.0.0")
    implementation("androidx.swiperefreshlayout:swiperefreshlayout:1.1.0")
    implementation(name = "sslCommerzSdk", ext = "aar")
}
```

### Android Mandatory Initialization

The Android SDK starts with `SSLCommerzInitialization`:

```java
final SSLCommerzInitialization sslCommerzInitialization =
    new SSLCommerzInitialization(
        "yourStoreID",
        "yourPassword",
        amount,
        SSLCCurrencyType.BDT,
        "123456789098765",
        "yourProductType",
        SSLCSdkType.TESTBOX
    );

IntegrateSSLCommerz
    .getInstance(context)
    .addSSLCommerzInitialization(sslCommerzInitialization)
    .buildApiCall(this);
```

Map backend response fields to the SDK:

| SDK value | Backend response field | Notes |
|---|---|---|
| `storeID` | `sdkConfig.storeId` | Provided from backend/env. |
| `storePassword` | `sdkConfig.storePassword` | Required by SDK, but sensitive. See security notes. |
| `amount` | `amount` | Must be backend-calculated amount. |
| `SSLCCurrencyType.BDT` | `currency = "BDT"` | Use BDT unless backend explicitly supports more. |
| `transactionId` | `transactionId` | Backend-generated, unique, stored before SDK starts. |
| `productType` | `product.productCategory` | Example: `service_booking`. |
| `SSLCSdkType.TESTBOX` / live type | `sdkConfig.environment` | Use sandbox/test for staging, live for production. |

### Android Optional Initializers

Use these only when data is available. Missing optional values should not block payment.

```java
final SSLCCustomerInfoInitializer customerInfoInitializer =
    new SSLCCustomerInfoInitializer(
        "customer name",
        "customer email",
        "address",
        "dhaka",
        "1214",
        "Bangladesh",
        phoneNumber
    );

final SSLCEMITransactionInitializer emiTransactionInitializer =
    new SSLCEMITransactionInitializer(1);

final SSLCProductInitializer productInitializer =
    new SSLCProductInitializer(
        "food",
        "food",
        new SSLCProductInitializer.ProductProfile.TravelVertical(
            "Travel",
            "10",
            "A",
            "12",
            "Dhk-Syl",
            "N/A",
            "AAA",
            "DDD"
        )
    );

final SSLCShipmentInfoInitializer shipmentInfoInitializer =
    new SSLCShipmentInfoInitializer(
        "Courier",
        2,
        new SSLCShipmentInfoInitializer.ShipmentDetails(
            "AA",
            "Address 1",
            "Dhaka",
            "1000",
            "BD"
        )
    );

final SSLCAdditionalInitializer additionalInitializer =
    new SSLCAdditionalInitializer();
additionalInitializer.setValueA("paymentId");
additionalInitializer.setValueB("bookingId");
additionalInitializer.setValueC("userId");
additionalInitializer.setValueD("platform");
```

Then attach them:

```java
IntegrateSSLCommerz
    .getInstance(context)
    .addSSLCommerzInitialization(sslCommerzInitialization)
    .addEMITransactionInitializer(emiTransactionInitializer)
    .addCustomerInfoInitializer(customerInfoInitializer)
    .addProductInitializer(productInitializer)
    .buildApiCall(this);
```

## iOS Framework Notes From PDF

### Framework Setup

The iOS PDF says to drag and drop the SSLCOMMERZ framework into the iOS app and add it to:

```text
Runner target -> General -> Frameworks, Libraries, and Embedded Content
```

Set it to embed/sign if Xcode requires it. The framework import used by the PDF is:

```swift
import SSLCommerz
```

### iOS Mandatory Initialization

The iOS framework starts with `IntegrationInformation`:

```swift
let integrationInfo = IntegrationInformation.init(
    storeID: "abc",
    storePassword: "123",
    totalAmount: 10.00,
    currency: "BDT",
    transactionId: "123id",
    productCategory: "product"
)
```

Map backend response fields to the SDK:

| SDK value | Backend response field | Notes |
|---|---|---|
| `storeID` | `sdkConfig.storeId` | Provided from backend/env. |
| `storePassword` | `sdkConfig.storePassword` | Required by SDK, but sensitive. See security notes. |
| `totalAmount` | `amount` | Must be backend-calculated amount. |
| `currency` | `currency` | Usually `BDT`. |
| `transactionId` | `transactionId` | Backend-generated and unique. |
| `productCategory` | `product.productCategory` | Example: `service_booking`. |

### iOS Optional Information

The PDF lists these optional objects:

```swift
let customerInfo = CustomerInformation.init(
    customerName: "john",
    customerEmail: "ssl@ssl.com",
    customerAddressOne: "address1",
    customerCity: "city",
    customerPostCode: "123",
    customerCountry: "BD",
    customerPhone: "00000"
)

let emiInfo = EMIInformation.init(emiOption: .NoEMI)

let productInfo = ProductInformation.init(
    productName: "product",
    productCategory: "category",
    productProfile: ProductProfileOption.General.profile
)

let shipmentInfo = ShipmentOption.NotRequired(
    shippingMethod: "courier",
    numberOfItem: 1
)

let additionalInfo = AdditionalInformation.init()
additionalInfo.paramA = "paymentId"
additionalInfo.paramB = "bookingId"
additionalInfo.paramC = "userId"
additionalInfo.paramD = "ios"
```

Create the SDK object with `nil` for optional sections you do not need:

```swift
sslCom = SSLCommerz.init(
    integrationInformation: integrationInfo,
    emiInformation: nil,
    customerInformation: customerInfo,
    shipmentInformation: nil,
    productInformation: productInfo,
    additionalInformation: additionalInfo
)
```

Start transaction:

```swift
sslCom?.delegate = self
sslCom?.start(in: self, shouldRunInTestMode: true)
```

The PDF notes:

- `shouldRunInTestMode: true` means test/sandbox mode.
- `shouldRunInTestMode: false` means live mode.

### iOS Result Delegate

The PDF shows this delegate method:

```swift
func transactionCompleted(withTransactionData transactionData: TransactionDetails?) {
    // Send fields back to Flutter, then Flutter confirms with backend.
}
```

## Flutter Integration Plan

Use a `MethodChannel`, for example:

```dart
const _sslcommerzChannel = MethodChannel('com.kaajbd.protiva502.iosapp/sslcommerz');
```

Flutter side flow:

1. Call `POST /payment/sslcommerz/initiate`.
2. Pass `data` from response to native channel method `startPayment`.
3. Native Android/iOS starts SDK.
4. Native returns a normalized result map to Flutter.
5. Flutter calls `POST /payment/sslcommerz/confirm`.
6. Navigate only based on backend confirmation response.

Suggested Flutter method shape:

```dart
final sdkResult = await _sslcommerzChannel.invokeMapMethod<String, dynamic>(
  'startPayment',
  initiateResponse.data,
);
```

Native should always return the same normalized keys on both platforms:

```json
{
  "paymentId": "pay_...",
  "bookingId": "booking_uuid",
  "transactionId": "ssl_tran_...",
  "status": "VALID",
  "apiConnect": "DONE",
  "sessionKey": "...",
  "valId": "...",
  "amount": "1500.00",
  "storeAmount": "1500.00",
  "currency": "BDT",
  "bankTranId": "...",
  "cardType": "...",
  "cardNo": "...",
  "cardIssuer": "...",
  "cardBrand": "...",
  "cardIssuerCountry": "...",
  "cardIssuerCountryCode": "...",
  "tranDate": "...",
  "validatedOn": "...",
  "gwVersion": "...",
  "riskLevel": "0",
  "riskTitle": "Safe",
  "platform": "android"
}
```

## Backend API Contract

### 1. Initiate Native Payment

Route:

```http
POST /api/v1/payment/sslcommerz/initiate
Authorization: Bearer <token>
Content-Type: application/json
```

Request fields from Flutter:

```json
{
  "bookingId": "booking_uuid",
  "couponCode": "SAVE10",
  "platform": "android",
  "deviceId": "optional_device_id"
}
```

Rules:

- `amount` should not be accepted from the app as authority.
- Backend calculates amount from booking, pricing, discount, coupon, wallet/fees if applicable.
- Backend verifies the authenticated user owns the booking.
- Backend creates a pending payment row before returning SDK config.
- Backend generates a unique `transactionId`.

Response:

```json
{
  "statusCode": 201,
  "message": "SSLCOMMERZ payment initialized",
  "data": {
    "paymentId": "pay_01HX...",
    "bookingId": "booking_uuid",
    "transactionId": "KAAJBD_20260511_000001",
    "amount": 1500.0,
    "currency": "BDT",
    "product": {
      "productName": "Service booking",
      "productCategory": "service_booking",
      "productProfile": "general"
    },
    "customer": {
      "name": "Customer Name",
      "email": "customer@example.com",
      "phone": "01700000000",
      "address": "Dhaka",
      "city": "Dhaka",
      "postCode": "1212",
      "country": "BD"
    },
    "shipment": {
      "required": false,
      "shippingMethod": "NO",
      "numberOfItem": 1
    },
    "additional": {
      "valueA": "pay_01HX...",
      "valueB": "booking_uuid",
      "valueC": "user_uuid",
      "valueD": "android"
    },
    "sdkConfig": {
      "storeId": "your_store_id",
      "storePassword": "your_store_password",
      "environment": "sandbox"
    }
  }
}
```

Backend payment row fields:

```text
id
bookingId
userId
transactionId
amount
currency
couponCode
discountAmount
status = PENDING
gateway = SSLCOMMERZ
platform = android|ios
createdAt
updatedAt
```

### 2. Confirm Native Payment

Route:

```http
POST /api/v1/payment/sslcommerz/confirm
Authorization: Bearer <token>
Content-Type: application/json
```

Request fields from Flutter:

```json
{
  "paymentId": "pay_01HX...",
  "bookingId": "booking_uuid",
  "transactionId": "KAAJBD_20260511_000001",
  "platform": "android",
  "apiConnect": "DONE",
  "status": "VALID",
  "sessionKey": "...",
  "valId": "...",
  "amount": "1500.00",
  "storeAmount": "1500.00",
  "currency": "BDT",
  "bankTranId": "...",
  "cardType": "...",
  "cardNo": "...",
  "cardIssuer": "...",
  "cardBrand": "...",
  "cardIssuerCountry": "...",
  "cardIssuerCountryCode": "...",
  "tranDate": "...",
  "validatedOn": "...",
  "gwVersion": "...",
  "riskLevel": "0",
  "riskTitle": "Safe",
  "rawSdkResponse": {}
}
```

Backend validation rules:

- Find the pending payment by `paymentId` and `transactionId`.
- Verify booking belongs to authenticated user.
- Reject if payment is already final unless idempotently returning the previous final state.
- Call SSLCOMMERZ Validation API using `valId`, backend `storeId`, and backend `storePassword`.
- Compare validation response:
  - `tran_id` equals local `transactionId`
  - amount/store amount matches local amount
  - currency is `BDT`
  - status is `VALID` or `VALIDATED`
  - risk level is acceptable for business rules
- Only then set payment `PAID` and booking payment status `PAID`.

Success response:

```json
{
  "statusCode": 200,
  "message": "Payment verified successfully",
  "data": {
    "paymentId": "pay_01HX...",
    "bookingId": "booking_uuid",
    "transactionId": "KAAJBD_20260511_000001",
    "paymentStatus": "PAID",
    "bookingStatus": "CONFIRMED",
    "amount": 1500.0,
    "currency": "BDT"
  }
}
```

Failed response:

```json
{
  "statusCode": 400,
  "message": "Payment verification failed",
  "data": {
    "paymentId": "pay_01HX...",
    "transactionId": "KAAJBD_20260511_000001",
    "paymentStatus": "FAILED",
    "reason": "SSLCOMMERZ validation status was FAILED"
  }
}
```

### 3. Mark Cancelled Or Failed

Route:

```http
POST /api/v1/payment/sslcommerz/fail
Authorization: Bearer <token>
Content-Type: application/json
```

Request:

```json
{
  "paymentId": "pay_01HX...",
  "bookingId": "booking_uuid",
  "transactionId": "KAAJBD_20260511_000001",
  "platform": "ios",
  "status": "CANCELLED",
  "reason": "User cancelled SDK flow",
  "rawSdkResponse": {}
}
```

Response:

```json
{
  "statusCode": 200,
  "message": "Payment marked as cancelled",
  "data": {
    "paymentId": "pay_01HX...",
    "paymentStatus": "CANCELLED"
  }
}
```

### 4. Payment Status Polling

Route:

```http
GET /api/v1/payment/sslcommerz/:paymentId/status
Authorization: Bearer <token>
```

Response:

```json
{
  "statusCode": 200,
  "data": {
    "paymentId": "pay_01HX...",
    "bookingId": "booking_uuid",
    "transactionId": "KAAJBD_20260511_000001",
    "paymentStatus": "PENDING",
    "amount": 1500.0,
    "currency": "BDT"
  }
}
```

## Transaction Result Fields From SDK

Both PDFs list these return fields. Normalize them in native code before sending to Flutter/backend.

| Normalized field | Android getter | iOS getter | Meaning |
|---|---|---|---|
| `apiConnect` | `getAPIConnect()` | `getAPIConnect()` | `INVALID_REQUEST`, `FAILED`, `INACTIVE`, or `DONE`. |
| `status` | `getStatus()` | `getStatus()` | `VALID`, `VALIDATED`, or `FAILED`. |
| `sessionKey` | `getSessionkey()` | `getSessionkey()` | SSLCOMMERZ session id. |
| `tranDate` | `getTranDate()` | `getTranDate()` | Transaction date/time. |
| `transactionId` | `getTranId()` | `getTranId()` | Merchant transaction id. |
| `valId` | `getValId()` | `getValId()` | Validation id for server-side validation. |
| `amount` | `getAmount()` | `getAmount()` | Transaction amount including charges. |
| `storeAmount` | `getStoreAmount()` | `getStoreAmount()` | Merchant store amount. |
| `bankTranId` | `getBankTranId()` | `getBankTranId()` | Bank transaction id. |
| `cardType` | `getCardType()` | `getCardType()` | Gateway/payment method. |
| `cardNo` | `getCardNo()` | `getCardNo()` | Card/account value if returned. |
| `cardIssuer` | `getCardIssuer()` | `getCardIssuer()` | Issuer name. |
| `cardBrand` | `getCardBrand()` | `getCardBrand()` | VISA, MasterCard, etc. |
| `cardIssuerCountry` | `getCardIssuerCountry()` | `getCardIssuerCountry()` | Issuer country. |
| `cardIssuerCountryCode` | `getCardIssuerCountryCode()` | `getCardIssuerCountryCode()` | Issuer country code. |
| `currency` | `getCurrencyType()` | `getCurrencyType()` | Merchant currency. |
| `currencyAmount` | `getCurrencyAmount()` | `getCurrencyAmount()` | Merchant currency amount. |
| `currencyRate` | `getCurrencyRate()` | `getCurrencyRate()` | Conversion rate if non-BDT. |
| `baseFair` | `getBaseFair()` | `getBaseFair()` | Merchant amount. |
| `valueA` | `getValueA()` | `getValueA()` | Optional value A. |
| `valueB` | `getValueB()` | `getValueB()` | Optional value B. |
| `valueC` | `getValueC()` | `getValueC()` | Optional value C. |
| `valueD` | `getValueD()` | `getValueD()` | Optional value D. |
| `validatedOn` | `getValidatedOn()` | `getValidatedOn()` | Validation date/time. |
| `gwVersion` | `getGwVersion()` | `getGwVersion()` | Gateway version. |
| `riskLevel` | `getRiskLevel()` | `getRiskLevel()` | `0` safe, `1` risky. |
| `riskTitle` | `getRiskTitle()` | `getRiskTitle()` | Risk/status title. |

## Status Handling

Backend statuses:

```text
PENDING
PAID
FAILED
CANCELLED
VALIDATION_FAILED
REFUNDED
```

App behavior:

- `apiConnect != DONE`: show failed state and call fail route.
- `status == VALID` or `status == VALIDATED`: call confirm route.
- `status == FAILED`: call fail route.
- User closes SDK/cancels: call fail route with `status = CANCELLED`.
- Confirm route returns `PAID`: show booking success.
- Confirm route returns anything else: show failed/pending message and allow retry/status check.

## Security Notes

- Backend must store real SSLCOMMERZ credentials in environment variables.
- Backend must never trust `amount`, `status`, or `valId` from the app without SSLCOMMERZ validation.
- The native SDK examples require `storePassword` in app-side initialization. If SSLCOMMERZ cannot provide a client-safe credential/token for the SDK, treat this as a known exposure risk and keep final authorization on the backend.
- Do not log `storePassword`, full card numbers, or raw sensitive SDK payloads.
- Use HTTPS only.
- Generate transaction ids server-side and make them unique.
- Make confirm route idempotent so app retries do not double-update bookings.

## Implementation Checklist

Flutter:

- Add `MethodChannel` wrapper for `startPayment`.
- Replace WebView navigation with native SDK call.
- Normalize Android/iOS result map.
- Call backend confirm/fail routes after SDK returns.
- Show success only after backend says `paymentStatus = PAID`.

Android:

- Add `sslCommerzSdk.aar` under `android/app/libs`.
- Add SDK dependencies and flatDir repository in `android/app/build.gradle.kts`.
- Update `MainActivity.kt` or create a Flutter plugin class to handle MethodChannel.
- Map initiate response to `SSLCommerzInitialization`.
- Attach customer/product/additional initializers when present.
- Return SDK result fields to Flutter.

iOS:

- Add SSLCOMMERZ framework to Runner target embedded frameworks.
- Import `SSLCommerz`.
- Add MethodChannel handler in `AppDelegate.swift` or a separate Swift plugin class.
- Map initiate response to `IntegrationInformation`.
- Set `sslCom.delegate = self`.
- Start with `shouldRunInTestMode` based on backend `sdkConfig.environment`.
- Return `TransactionDetails` fields to Flutter.

Backend:

- Implement initiate, confirm, fail/cancel, and status routes.
- Calculate amount server-side.
- Store pending payment before returning SDK config.
- Validate `valId` with SSLCOMMERZ before marking paid.
- Update booking payment status in the same DB transaction as payment status.
- Store validation response for audit/debugging.

## Testing

Sandbox test:

1. Backend uses sandbox SSLCOMMERZ credentials.
2. App requests initiate route.
3. Native SDK opens in test mode.
4. Complete payment with sandbox method/card.
5. App sends SDK result to confirm route.
6. Backend validates and marks booking paid.
7. App shows success only after backend response.

Failure tests:

- Invalid coupon.
- Expired/pending booking.
- Amount mismatch between SDK result and backend payment row.
- `apiConnect = FAILED`.
- `status = FAILED`.
- User cancels SDK.
- Confirm route called twice.
- Network drops after SDK success but before confirm route; app should retry/status-poll.

## Reference PDFs

- `Implementation Guide for iOS Framework of SSLCOMMERZ-V1.2.pdf`
- `Implementation Guide for Android SDK of SSLCOMMERZ V1.0_(AndroidX_version_only).pdf`

Last updated: 2026-05-11