# SSLCommerzSDK for iOS (XCFramework)

SSLCommerzSDK provides a convenient way to integrate the SSLCommerz payment gateway into your iOS applications. This SDK is packaged as an XCFramework and can be installed via CocoaPods.

## Requirements
```plaintext
- iOS 13.0+
- Xcode 16.0+
- Swift 5.0+
```

# Installation

### SSLCommerzSDK is available through CocoaPods. If you don't have CocoaPods installed, you can install it with the following command
```
$ sudo gem install cocoapods
```
### To integrate SSLCommerz SDK into your Xcode project using CocoaPods, specify it in your Podfile
```
platform :ios, '13.0'

target 'YourApp' do
  use_frameworks!

  pod 'SSLCommerzSDK'

end
```
### Then, install the pod using the following command
```
$ pod install
```

# Usage

## Step 1: Import the SDK
### Import the SDK into your view controller or any class where you intend to use the payment functionalities
```
import SSLCommerzSDK
```

## Step 2: Initialize the Payment
```
You can initialize a payment using the provided SDK functions. Refer to the official documentation for details on how to configure and start transactions.
```

## Step 3: Handling Responses
```
The SDK provides callbacks to handle success, failure, and cancellation events during the payment process.
```
