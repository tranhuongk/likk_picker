import 'package:likk_picker/likk_picker.dart';
import 'package:flutter/material.dart';

///
class GridViewWidget extends StatelessWidget {
  ///
  GridViewWidget({
    Key? key,
    required this.notifier,
    this.isPlayground = false,
    this.onCreated,
  }) : super(key: key);

  ///
  final bool isPlayground;

  ///
  final Function(PlaygroundController)? onCreated;

  ///
  final ValueNotifier<List<LikkEntity>> notifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<LikkEntity>>(
      valueListenable: notifier,
      builder: (context, list, child) {
        if (list.isEmpty) {
          return const Center(
            child: Text('No data'),
          );
        }
        final controller = PlaygroundController(
          background: PhotoBackground(bytes: list.first.bytes),
        );

        if (onCreated != null) {
          onCreated!(controller);
        }
        if (isPlayground) {
          return Playground(
            enableOverlay: false,
            controller: controller,
          );
        }
        // controller.updateValue(hasFocus: true);

        return GridView.builder(
          padding: const EdgeInsets.all(4.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 1.0,
          ),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final entity = list[index];
            return Stack(
              fit: StackFit.expand,
              children: [
                // Media
                Image.memory(
                  entity.bytes,
                  fit: BoxFit.cover,
                ),

                // For video duration
                // Duration
                if (entity.entity.type == AssetType.video)
                  Positioned(
                    right: 4.0,
                    bottom: 4.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        color: Colors.black.withOpacity(0.7),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 2.0),
                        child: Text(
                          entity.entity.duration.formatedDuration,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 13.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
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
