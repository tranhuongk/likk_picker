import 'dart:ui';

import 'package:likk_picker/likk_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'grid_view_widget.dart';

///
class FullscreenGallery extends StatefulWidget {
  ///
  const FullscreenGallery({
    Key? key,
  }) : super(key: key);

  @override
  _FullscreenGalleryState createState() => _FullscreenGalleryState();
}

class _FullscreenGalleryState extends State<FullscreenGallery> {
  late final GalleryController controller;
  late final ValueNotifier<List<LikkEntity>> notifier;

  @override
  void initState() {
    super.initState();
    controller = GalleryController(
      gallerySetting: GallerySetting(
          maximum: 1,
          requestType: RequestType.common,
          onItemClick: (item, list) {},
          enableCamera: true,
          crossAxisCount: 4,
          backAndUnselect: () => false,
          onReachedMaximumLimit: () {},
          selectionCountAlignment: Alignment.topRight,
          selectionCountRingSize: 5,
          selectedStyle: SelectedStyle.border,
          albumColor: Colors.greenAccent,
          albumBorderRadius: BorderRadius.zero,
          space: 0,
          itemBorderRadius: BorderRadius.zero,
          albumImageSize: 60,
          albumSubTitleStyle: const TextStyle(color: Colors.black),
          albumTitleStyle: const TextStyle(color: Colors.black),
          cameraItemWidget: const ColoredBox(
            color: Colors.red,
            child: Icon(
              CupertinoIcons.photo_camera_solid,
              color: Colors.white,
            ),
          )),
      headerSetting: HeaderSetting(
        headerMaxHeight: 56,
        elevation: 2,
        albumFit: FlexFit.tight,
        headerBackground: Image.asset('../assets/bg.jpeg', fit: BoxFit.cover),
        albumBuilder: (context, album, child) => Text(
          album.data?.name ?? 'Unknown',
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
        headerRightWidget: GestureDetector(
          // onTap: () {
          //   controller.completeTask(context);
          // },
          onTap: () {
            controller.completeTask(context);
          },
          child: const SizedBox(
            width: 50,
            height: 20,
            child: Icon(
              CupertinoIcons.photo_camera_solid,
              color: Colors.white,
            ),
          ),
        ),
      ),
      // ignore: prefer_const_constructors
      panelSetting: PanelSetting(
        background: Image.asset('../assets/bg.jpeg', fit: BoxFit.cover),
      ),
    );
    notifier = ValueNotifier(<LikkEntity>[]);
  }

  @override
  void dispose() {
    super.dispose();
    notifier.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: const Text('Fullscreen gallery picker'),
      ),
      body: Column(
        children: [
          // Grid view
          Expanded(child: GridViewWidget(notifier: notifier)),

          TextButton(
            onPressed: () async {
              final entities = await controller.pick(
                context,
                selectedEntities: notifier.value,
              );
              notifier.value = entities;
            },
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.green,
            ),
            child: const Text('Use Controller'),
          ),

          // Textfield
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Textfield
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Test field',
                    ),
                  ),
                ),

                // Camera field..
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CameraViewField(
                    onCapture: (entity) {
                      notifier.value = [...notifier.value, entity];
                    },
                    child: const Icon(Icons.camera),
                  ),
                ),

                // Gallery field
                ValueListenableBuilder<List<LikkEntity>>(
                  valueListenable: notifier,
                  builder: (context, list, child) {
                    return GalleryViewField(
                      selectedEntities: list,
                      controller: controller,
                      onChanged: (entity, isRemoved) {
                        final value = notifier.value.toList();
                        if (isRemoved) {
                          value.remove(entity);
                        } else {
                          value.add(entity);
                        }
                        notifier.value = value;
                      },
                      onSubmitted: (list) {
                        notifier.value = list;
                      },
                      child: child,
                    );
                  },
                  child: const Icon(Icons.photo),
                ),

                //
              ],
            ),
          ),

          //
        ],
      ),
    );
  }
}
