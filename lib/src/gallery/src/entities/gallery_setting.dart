import 'package:flutter/material.dart';
import 'package:likk_picker/likk_picker.dart';
import 'package:likk_picker/src/gallery/gallery_view.dart';
import 'package:photo_manager/photo_manager.dart';

///
/// Setting for likk picker
///
class GallerySetting {
  ///
  const GallerySetting({
    this.enableCropper = false,
    this.requestType = RequestType.all,
    this.maximum = 20,
    this.enableCamera = true,
    this.crossAxisCount,
    this.backAndUnselect,
    this.onItemClick,
    this.onReachedMaximumLimit,
    this.selectionCountAlignment = Alignment.center,
    this.actionButton = const SizedBox(),
    this.selectionCountTextStyle,
    this.selectionCountBackgroundColor,
    this.selectionCountBackgroundSize,
    this.selectionCountRingColor,
    this.selectionCountRingSize,
    this.selectionCountMargin,
    this.selectionCountBuilder,
    this.selectedStyle = SelectedStyle.border,
    this.padding,
    this.space,
    this.itemBorderRadius,
    this.albumBackground = const ColoredBox(color: Colors.black),
    this.albumColor = Colors.grey,
    this.albumImageSize,
    this.albumBorderRadius,
    this.albumTitleStyle,
    this.albumSubTitleStyle,
    this.cameraItemWidget,
  });

  /// Enable image cropper when maximum = 1 or open camera
  final bool enableCropper;

  /// Padding for panel content
  final EdgeInsets? padding;

  /// Space for items
  final double? space;

  /// BorderRadius of item
  /// Default: BorderRadius.circular(8)
  final BorderRadius? itemBorderRadius;

  ///
  final Widget albumBackground;

  ///
  final Color albumColor;

  ///
  final int? albumImageSize;

  ///
  final BorderRadius? albumBorderRadius;

  ///
  final TextStyle? albumTitleStyle;

  ///
  final TextStyle? albumSubTitleStyle;

  /// Item selected style
  /// Default: SelectedStyle.border
  final SelectedStyle? selectedStyle;

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
  final bool Function()? backAndUnselect;

  ///
  /// On select item callback
  /// Result is: clicked item and selected list
  ///
  final Function(LikkEntity, List<LikkEntity>)? onItemClick;

  /// Show Edit, Select action
  final Widget? actionButton;

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

  /// Custom Widget for camera item
  final Widget? cameraItemWidget;

  /// Helper function
  GallerySetting copyWith({
    bool? enableCropper,
    SelectedStyle? selectedStyle,
    VoidCallback? onReachedMaximumLimit,
    RequestType? requestType,
    int? maximum,
    bool? enableCamera,
    int? crossAxisCount,
    bool Function()? backAndUnselect,
    Function(LikkEntity, List<LikkEntity>)? onItemClick,
    Widget? actionButton,
    Alignment? selectionCountAlignment,
    TextStyle? selectionCountTextStyle,
    Color? selectionCountBackgroundColor,
    double? selectionCountBackgroundSize,
    Color? selectionCountRingColor,
    double? selectionCountRingSize,
    EdgeInsets? selectionCountMargin,
    Widget Function(int index)? selectionCountBuilder,
    EdgeInsets? padding,
    double? space,
    BorderRadius? itemBorderRadius,
    Widget? albumBackground,
    Color? albumColor,
    int? albumImageSize,
    BorderRadius? albumBorderRadius,
    TextStyle? albumTitleStyle,
    TextStyle? albumSubTitleStyle,
    Widget? cameraItemWidget,
  }) {
    return GallerySetting(
      enableCropper: enableCropper ?? this.enableCropper,
      requestType: requestType ?? this.requestType,
      maximum: maximum ?? this.maximum,
      enableCamera: enableCamera ?? this.enableCamera,
      crossAxisCount: crossAxisCount ?? this.crossAxisCount,
      backAndUnselect: backAndUnselect ?? this.backAndUnselect,
      onItemClick: onItemClick ?? this.onItemClick,
      onReachedMaximumLimit:
          onReachedMaximumLimit ?? this.onReachedMaximumLimit,
      selectionCountAlignment:
          selectionCountAlignment ?? this.selectionCountAlignment,
      actionButton: actionButton ?? this.actionButton,
      selectionCountTextStyle:
          selectionCountTextStyle ?? this.selectionCountTextStyle,
      selectionCountBackgroundColor:
          selectionCountBackgroundColor ?? this.selectionCountBackgroundColor,
      selectionCountBackgroundSize:
          selectionCountBackgroundSize ?? this.selectionCountBackgroundSize,
      selectionCountRingColor:
          selectionCountRingColor ?? this.selectionCountRingColor,
      selectionCountRingSize:
          selectionCountRingSize ?? this.selectionCountRingSize,
      selectionCountMargin: selectionCountMargin ?? this.selectionCountMargin,
      selectionCountBuilder:
          selectionCountBuilder ?? this.selectionCountBuilder,
      selectedStyle: selectedStyle ?? this.selectedStyle,
      padding: padding ?? this.padding,
      space: space ?? this.space,
      itemBorderRadius: itemBorderRadius ?? this.itemBorderRadius,
      albumBackground: albumBackground ?? this.albumBackground,
      albumColor: albumColor ?? this.albumColor,
      albumImageSize: albumImageSize ?? this.albumImageSize,
      albumBorderRadius: albumBorderRadius ?? this.albumBorderRadius,
      albumTitleStyle: albumTitleStyle ?? this.albumTitleStyle,
      albumSubTitleStyle: albumSubTitleStyle ?? this.albumSubTitleStyle,
      cameraItemWidget: cameraItemWidget ?? this.cameraItemWidget,
    );
  }
}
