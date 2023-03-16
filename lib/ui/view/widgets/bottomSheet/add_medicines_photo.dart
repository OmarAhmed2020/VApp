import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:voithy/ui/localization/app_strings.dart';
import 'package:voithy/ui/theme/app_colors.dart';
import 'dart:io';

import '../../../../provider/add_medicine_provider.dart';

class ImagePickerWidget {
  File? image;
  var imagePicker = ImagePicker();

  void addPhotoBottomSheet(context) {
    final addMedicineProvider =
        Provider.of<AddMedicineProvider>(context, listen: false);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppColors.colorececec,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Container(
              height: 230.h,
              decoration: const BoxDecoration(
                  color: AppColors.colorececec,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        )),
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50.h,
                    child: Text(
                      AppStrings.takePhoto.tr,
                      style: const TextStyle(
                          color: AppColors.color8f8f8f,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      PermissionStatus storageStatus =
                          await Permission.storage.request();
                      if (storageStatus == PermissionStatus.granted) {
                        tackPhotoByCamera().then((file) {
                          addMedicineProvider.imageFile = file;
                          Get.back();
                        });
                      }
                      if (storageStatus == PermissionStatus.denied) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(AppStrings.providePermission.tr)));
                      }
                      if (storageStatus == PermissionStatus.permanentlyDenied) {
                        openAppSettings();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 50.h,
                        child: Text(AppStrings.takePhoto.tr,
                            style: TextStyle(
                                color: AppColors.color007aff,
                                fontWeight: FontWeight.w400,
                                fontSize: 18.sp)),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      PermissionStatus storageStatus =
                          await Permission.storage.request();
                      if (storageStatus == PermissionStatus.granted) {
                        pickImageFromGallery().then((file) {
                          addMedicineProvider.imageFile = file;
                          Get.back();
                        });
                      }
                      if (storageStatus == PermissionStatus.denied) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(AppStrings.providePermission.tr)));
                      }
                      if (storageStatus == PermissionStatus.permanentlyDenied) {
                        openAppSettings();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15)),
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 50.h,
                        child: Text(AppStrings.chooseImage.tr,
                            style: TextStyle(
                                color: AppColors.color007aff,
                                fontWeight: FontWeight.w400,
                                fontSize: 18.sp)),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 50.h,
                        child: Text(AppStrings.cancel.tr,
                            style: TextStyle(
                                color: AppColors.color007aff,
                                fontWeight: FontWeight.w700,
                                fontSize: 18.sp)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  Future<XFile?> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    } else {
      return image;
    }
  }

  Future<XFile?> tackPhotoByCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo == null) {
      return null;
    } else {
      return photo;
    }
  }
}
