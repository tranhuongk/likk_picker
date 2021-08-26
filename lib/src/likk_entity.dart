import 'dart:typed_data';

import 'package:likk_picker/likk_picker.dart';

///
class LikkEntity {
  ///
  LikkEntity({
    required this.entity,
    required this.bytes,
  });

  ///
  final AssetEntity entity;

  ///
  final Uint8List bytes;

  @override
  int get hashCode {
    return entity.id.hashCode;
  }

  @override
  bool operator ==(other) {
    if (other is! LikkEntity) {
      return false;
    }
    return entity.id == other.entity.id;
  }

  @override
  String toString() {
    return 'LikkEntity{ id:${entity.id} , type: ${entity.type}}';
  }
}
