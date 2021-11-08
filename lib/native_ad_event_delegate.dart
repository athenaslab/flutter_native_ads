import 'package:flutter/services.dart';

/// A delegate that Android/iOS SDK ad events.
class NativeAdEventDelegate {
  /// Create a NativeAdEventDelegate
  const NativeAdEventDelegate({
    this.onAdImpression,
    this.onAdLeftApplication,
    this.onAdClicked,
    this.onAdFailedToLoad,
    this.onAdLoaded,
  });

  /// Called when an impression is recorded for an ad.
  final Function()? onAdImpression;

  /// Called when an ad leaves the application (e.g., to go to the browser).
  final Function()? onAdLeftApplication;

  /// Called when a click is recorded for an ad.
  final Function()? onAdClicked;

  /// Called when an ad request failed.
  final Function(Map<String, dynamic>)? onAdFailedToLoad;

  /// Called when an ad is received.
  final Function()? onAdLoaded;

  /// Handling of method that Android or iOS.
  Future<dynamic> handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'onAdImpression':
      case 'nativeAdDidRecordImpression':
        if (onAdImpression != null) {
          onAdImpression!();
        }
        break;
      case 'onAdLeftApplication':
      case 'nativeAdWillLeaveApplication':
        if(onAdLeftApplication != null) {
          onAdLeftApplication!();
        }
        break;
      case 'onAdClicked':
      case 'nativeAdDidRecordClick':
        if(onAdClicked != null) {
          onAdClicked!();
        }
        break;
      case 'onAdFailedToLoad':
      case 'didFailToReceiveAdWithError':
        if(onAdFailedToLoad != null) {
          onAdFailedToLoad!(Map<String, dynamic>.from(call.arguments));
        }
        break;
      case 'onAdLoaded':
      case 'didReceive':
        if(onAdLoaded != null) {
          onAdLoaded!();
        }
        break;
    }
  }
}
