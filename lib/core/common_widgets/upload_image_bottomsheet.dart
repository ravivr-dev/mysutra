import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:permission_handler/permission_handler.dart';

class UploadImageBottomSheet extends StatefulWidget {
  final bool showRemovePhoto;
  final Function(XFile? image) onChange;
  final Function() removePhoto;
  const UploadImageBottomSheet({
    super.key,
    this.showRemovePhoto = false,
    required this.onChange,
    required this.removePhoto,
  });

  @override
  State<UploadImageBottomSheet> createState() => _UploadImageBottomSheetState();
}

class _UploadImageBottomSheetState extends State<UploadImageBottomSheet> {
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Colors.white),
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.showRemovePhoto) ...[
                  GestureDetector(
                    onTap: () {
                      widget.removePhoto();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: component.text(
                        "Remove Photo",
                        style: theme.publicSansFonts
                            .semiBoldStyle(fontSize: 16, fontColor: Colors.red),
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey.shade200),
                ],
                GestureDetector(
                  onTap: () async {
                    bool permission = await requestCameraPermission();
                    if (!permission) {
                      return;
                    }
                    XFile? image =
                        await picker.pickImage(source: ImageSource.camera);
                    widget.onChange(image);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: component.text(
                      "Camera",
                      style: theme.publicSansFonts.semiBoldStyle(fontSize: 16),
                    ),
                  ),
                ),
                Divider(color: Colors.grey.shade200),
                GestureDetector(
                  onTap: () async {
                    XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);

                    widget.onChange(image);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: component.text(
                      "Upload New Photo",
                      // context.stringForKey(StringKeys.uploadNewPhoto),
                      style: theme.publicSansFonts.semiBoldStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              width: context.screenWidth,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: Colors.white),
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Center(
                child: component.text(
                  "Cancel",
                  // context.stringForKey(StringKeys.cancel),
                  style: theme.publicSansFonts.semiBoldStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> requestCameraPermission() async {
    const permission = Permission.camera;

    if (!(await permission.isGranted)) {
      await permission.request();
      if (!(await permission.isGranted)) {
        await permission.request();
      }
      if (await permission.isPermanentlyDenied) {
        await openAppSettings();
      }
      if (!(await permission.isGranted)) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }
}
