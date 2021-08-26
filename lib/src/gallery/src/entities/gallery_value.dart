import 'package:likk_picker/likk_picker.dart';

///
class GalleryValue {
  ///
  const GalleryValue({
    this.selectedEntities = const <LikkEntity>[],
    this.previousSelection = true,
    this.isAlbumVisible = false,
  });

  ///
  final List<LikkEntity> selectedEntities;

  ///
  final bool previousSelection;

  ///
  final bool isAlbumVisible;

  ///
  GalleryValue copyWith({
    List<LikkEntity>? selectedEntities,
    bool? previousSelection,
    bool? isAlbumVisible,
  }) =>
      GalleryValue(
        selectedEntities: selectedEntities ?? this.selectedEntities,
        previousSelection: previousSelection ?? this.previousSelection,
        isAlbumVisible: isAlbumVisible ?? this.isAlbumVisible,
      );

  @override
  String toString() =>
      'LENGTH  :  ${selectedEntities.length} \nLIST  :  $selectedEntities';

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   if (other is GalleryValue) {
  //     if (selectedEntities.length != other.selectedEntities.length) {
  //       return false;
  //     }

  //     var isIdentical = true;
  //     for (var i = 0; i < selectedEntities.length; i++) {
  //       if (!isIdentical) return false;
  //       isIdentical = other.selectedEntities[i].id == selectedEntities[i].id;
  //     }
  //     return true;
  //   }
  //   return false;
  // }

  // @override
  // int get hashCode => selectedEntities.hashCode;
}
