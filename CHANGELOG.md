## [1.1.0] - 23/09/2021
* Remove `onUnselectAll`
* Add `backAndUnselect`: if true unselect item in this session
* Add ValueNotifier `PanelState` for check panel is show or hide
## [1.0.9] - 23/09/2021
* Fix height panel
* Fix keyboard show, selected item is cleared

## [1.0.8+1] - 23/09/2021
* Back version camera, photo_manager

## [1.0.8] - 23/09/2021
* Fix status bar

## [1.0.7+1] - 31/08/2021
* Update GalleryController `close` to close panel
* Fix clear selection return empty

## [1.0.7] - 31/08/2021
* Update permission when open screen which have GalleryController
* Update unSelect with list item
* Update onUnSelect = false -> will pop 

## [1.0.6] - 27/08/2021
* GalleryViewWrapper: Add `safeAreaBottom` for check item if have use SafeArea widget on bottom
* Fix padding of album and album item
* Add CupertinoScrollBar for ListView and GridView

## [1.0.5] - 28/08/2021
* GallerySetting: Add `albumBackground` for set background of album
* HeaderSetting: Add `barSize` for setting size of header bar
* Fix size of header and panel

## [1.0.4] - 27/08/2021
* Fix bug show action button
* GallerySetting: Add `cameraItemWidget` for custom camera widget
* Fix bug call Function `completeTask`

## [1.0.3] - 27/08/2021

* Move `selectedStyle`, `padding`, `space`, `itemBorderRadius`, `albumColor`, `albumImageSize`, `albumBorderRadius`, `albumTitleStyle`, `albumSubTitleStyle` from PanelSetting to GallerySetting
* Add `elevation` for HeaderSetting
* Add callback `onItemClick` for GallerySetting

## [1.0.2] - 26/08/2021

* Update choose from multi album
* Hide panel when keyboard shown
 
## [1.0.1] - 26/08/2021

* Update README.md

## [1.0.0] - 26/08/2021

* Initial release.
* Picker in gallery and camera
