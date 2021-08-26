import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

///
/// Setting for likk picker
///
class GallerySetting {
  ///
  const GallerySetting({
    this.requestType = RequestType.all,
    this.maximum = 20,
    this.enableCamera = true,
    this.crossAxisCount,
    this.onUnselect,
    this.onReachedMaximumLimit,
    this.selectionCountAlignment = Alignment.center,
    this.showActionButton = false,
    this.selectionCountTextStyle,
    this.selectionCountBackgroundColor,
    this.selectionCountBackgroundSize,
    this.selectionCountRingColor,
    this.selectionCountRingSize,
    this.selectionCountMargin,
    this.selectionCountBuilder,
  });

  /// On reached maximum limit
  final VoidCallback? onReachedMaximumLimit;

  ///
  /// Type of media e.g, image, video, audio, other
  /// Default is [RequestType.all]
  ///
  final RequestType requestType;

  ///
  /// Total media allowed to select. Default is 20
  ///
  final int maximum;

  ///
  /// Set false to hide camera from gallery view
  final bool enableCamera;

  ///
  /// Gallery cross axis count. Default is 3
  ///
  final int? crossAxisCount;

  ///
  /// On unselect item:
  /// return true is unselect,
  /// false is cancel
  ///
  final bool Function()? onUnselect;

  /// Show Edit, Select action
  final bool showActionButton;

  /// Set position for selection count
  final Alignment selectionCountAlignment;

  /// Set TextStyle for selection count
  final TextStyle? selectionCountTextStyle;

  /// Set Background color for selection count
  final Color? selectionCountBackgroundColor;

  /// Set Background size for selection count
  final double? selectionCountBackgroundSize;

  /// Set Ring for selection count
  final Color? selectionCountRingColor;

  /// Set Ring size for selection count
  final double? selectionCountRingSize;

  /// Set margin for selection count
  final EdgeInsets? selectionCountMargin;

  /// Set background for selection count
  final Widget Function(int index)? selectionCountBuilder;
}
