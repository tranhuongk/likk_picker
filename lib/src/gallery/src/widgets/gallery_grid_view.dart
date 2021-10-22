import 'dart:typed_data';

import 'package:likk_picker/likk_picker.dart';
import 'package:likk_picker/src/animations/animations.dart';
import 'package:likk_picker/src/slidable_panel/slidable_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '../controllers/gallery_repository.dart';
import '../entities/gallery_value.dart';
import '../gallery_view.dart';
import 'gallery_permission_view.dart';

///
class GalleryGridView extends StatelessWidget {
  ///
  const GalleryGridView({
    Key? key,
    required this.controller,
    required this.onCameraRequest,
    required this.onSelect,
    required this.entitiesNotifier,
    required this.panelController,
  }) : super(key: key);

  ///
  final GalleryController controller;

  ///
  final ValueSetter<BuildContext> onCameraRequest;

  ///
  final void Function(LikkEntity, BuildContext) onSelect;

  ///
  final ValueNotifier<EntitiesType> entitiesNotifier;

  ///
  final PanelController panelController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: controller.panelSetting.background,
        ),
        ClipRRect(
          borderRadius:
              controller.setting.itemBorderRadius ?? BorderRadius.circular(8),
          child: ValueListenableBuilder<EntitiesType>(
            valueListenable: entitiesNotifier,
            builder: (context, state, child) {
              // Error
              if (state.hasError) {
                if (!state.hasPermission) {
                  return const GalleryPermissionView();
                }
              }

              // No data
              if (!state.isLoading && (state.data?.isEmpty ?? true)) {
                return const Center(
                  child: Text(
                    'No media available',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                );
              }

              final entities = state.isLoading ? <AssetEntity>[] : state.data!;

              final itemCount = state.isLoading
                  ? 20
                  : controller.setting.enableCamera
                      ? entities.length + 1
                      : entities.length;

              return CupertinoScrollbar(
                controller: panelController.scrollController,
                child: GridView.builder(
                  controller: panelController.scrollController,
                  padding:
                      (controller.setting.padding ?? const EdgeInsets.all(8))
                          .add(EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom,
                  )),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: controller.setting.crossAxisCount ?? 3,
                    crossAxisSpacing: controller.setting.space ?? 1.5,
                    mainAxisSpacing: controller.setting.space ?? 1.5,
                  ),
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    if (controller.setting.enableCamera && index == 0) {
                      return ClipRRect(
                        borderRadius: controller.setting.itemBorderRadius ??
                            BorderRadius.circular(8),
                        child: GestureDetector(
                          onTap: () => onCameraRequest(context),
                          child: controller.setting.cameraItemWidget ??
                              const ColoredBox(
                                color: Colors.black,
                                child: Icon(
                                  CupertinoIcons.photo_camera_solid,
                                  color: Colors.white,
                                ),
                              ),
                        ),
                      );
                    }

                    final ind =
                        controller.setting.enableCamera ? index - 1 : index;

                    final entity = state.isLoading ? null : entities[ind];

                    return ClipRRect(
                      borderRadius: controller.setting.itemBorderRadius ??
                          BorderRadius.circular(8),
                      child: _MediaTile(
                        controller: controller,
                        entity: entity,
                        onPressed: (entity) {
                          onSelect(entity, context);
                        },
                      ),
                    );
                  },
                ),
              );

              //
            },
          ),
        )
      ],
    );
  }
}

///
class _MediaTile extends StatelessWidget {
  ///
  const _MediaTile({
    Key? key,
    required this.entity,
    required this.controller,
    required this.onPressed,
  }) : super(key: key);

  ///
  final GalleryController controller;

  ///
  final AssetEntity? entity;

  ///
  final ValueSetter<LikkEntity> onPressed;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey.shade800,
      child: FutureBuilder<Uint8List?>(
        future: entity?.thumbDataWithSize(400, 400),
        builder: (context, snapshot) {
          final hasData = snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null;

          if (hasData) {
            final dEntity = LikkEntity(entity: entity!, bytes: snapshot.data!);
            return GestureDetector(
              onTap: () {
                onPressed(dEntity);
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Image
                  Image.memory(
                    snapshot.data!,
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                  ),

                  // Duration
                  if (entity!.type == AssetType.video)
                    Positioned(
                      right: 4,
                      bottom: 4,
                      child: _VideoDuration(duration: entity!.duration),
                    ),

                  // Image selection overlay
                  // if (!controller.singleSelection)
                  _SelectionCount(controller: controller, entity: dEntity),

                  //
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class _VideoDuration extends StatelessWidget {
  const _VideoDuration({
    Key? key,
    required this.duration,
  }) : super(key: key);

  final int duration;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: ColoredBox(
        color: Colors.black.withOpacity(0.7),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 2,
          ),
          child: Text(
            duration.formatedDuration,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectionCount extends StatelessWidget {
  const _SelectionCount({
    Key? key,
    required this.controller,
    required this.entity,
  }) : super(key: key);

  final GalleryController controller;
  final LikkEntity entity;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<GalleryValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        final isSelected = value.selectedEntities.contains(entity);
        // if (!isSelected) return const SizedBox();
        final index = value.selectedEntities.indexOf(entity);

        final crossFadeState =
            isSelected ? CrossFadeState.showFirst : CrossFadeState.showSecond;

        final Widget secondChild = Align(
          alignment: controller.setting.selectionCountAlignment,
          child: Padding(
            padding: controller.setting.selectionCountMargin ??
                const EdgeInsets.all(8),
            child: controller.setting.selectionCountBuilder != null
                ? controller.setting.selectionCountBuilder!(index)
                : CircleAvatar(
                    backgroundColor:
                        controller.setting.selectionCountRingColor ??
                            Colors.white,
                    radius: (controller.setting.selectionCountBackgroundSize ??
                            12) +
                        (controller.setting.selectionCountRingSize ?? 1),
                    child: CircleAvatar(
                      backgroundColor:
                          controller.setting.selectionCountBackgroundColor ??
                              Theme.of(context).primaryColor,
                      radius:
                          controller.setting.selectionCountBackgroundSize ?? 12,
                      child: Text(
                        '${index + 1}',
                        style: controller.setting.selectionCountTextStyle ??
                            Theme.of(context).textTheme.button?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                      ),
                    ),
                  ),
          ),
        );

        final firstChild = index == -1
            ? const SizedBox()
            : controller.setting.selectedStyle == SelectedStyle.border
                ? DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            controller.setting.selectionCountBackgroundColor ??
                                Theme.of(context).primaryColor,
                        width: 4,
                      ),
                      borderRadius: controller.setting.itemBorderRadius ??
                          BorderRadius.circular(8),
                    ),
                    child: secondChild,
                  )
                : ColoredBox(
                    color: (controller.setting.selectionCountBackgroundColor ??
                            Theme.of(context).primaryColor)
                        .withOpacity(0.2),
                    child: secondChild,
                  );
        return AppAnimatedCrossFade(
          firstChild: firstChild,
          secondChild: const SizedBox(),
          crossFadeState: crossFadeState,
          duration: const Duration(milliseconds: 300),
        );
      },
    );
  }
}

///
extension on int {
  String get formatedDuration {
    final duration = Duration(seconds: this);
    final min = duration.inMinutes.remainder(60).toString();
    final sec = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$min:$sec';
  }
}
