// // ignore_for_file: public_member_api_docs, sort_constructors_first

// import 'dart:convert';
// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';

// import 'package:union_bank_mobile/core/service/dependency_injection.dart';
// import 'package:union_bank_mobile/core/theme/theme_data.dart';
// import 'package:union_bank_mobile/error/messages.dart';
// import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
// import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
// import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
// import 'package:union_bank_mobile/features/presentation/bloc/splash/splash_bloc.dart';
// import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
// import 'package:union_bank_mobile/features/presentation/views/mailbox/data/attachment_data.dart';
// import 'package:union_bank_mobile/features/presentation/widgets/image_cropper.dart';
// import 'package:union_bank_mobile/utils/app_constants.dart';

// import '../../../../../utils/app_assets.dart';
// import '../../../../../utils/app_localizations.dart';
// import '../../../../../utils/enums.dart';

// import '../../../widgets/app_button.dart';

// class MailBoxBottomSheet extends BaseView {
//   MailBoxBottomSheet({Key? key}) : super(key: key);

//   @override
//   State<MailBoxBottomSheet> createState() => _MailBoxBottomSheetState();
// }

// class _MailBoxBottomSheetState extends BaseViewState<MailBoxBottomSheet> {
//   var bloc = injection<SplashBloc>();



//   @override
//   Widget buildView(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         height: 300,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(width: 50,height: 5,decoration: BoxDecoration(color: colors(context).greyColor,borderRadius: BorderRadius.circular(10)),),
//             const SizedBox(height: 20,),
//             Text(AppLocalizations.of(context).translate("add_attachments"),
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//                 color: colors(context).blackColor,
//               ),
//             ),
//             const SizedBox(height: 20,),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   width: 1,
//                 ),
//                 InkWell(
//                     onTap: () async {
//                       final file = await pickImageCamera();
//                       if (file?.path != null) {
//                         if (getFileSizeInMB(file?.path ?? "") <= AppConstants.UPLOAD_FILE_SIZE_IN_MB) {
//                           if (mounted) {
//                             Navigator.pop(
//                                 context,
//                                 AttachmentData(
//                                   base64File: base64Encode(File(file!.path).readAsBytesSync()),
//                                   extension: getFileExtension(file.path),
//                                   fileName: getFileName(file.path),
//                                   filePath: file.path,
//                                   file: File(file.path),
//                                 ));
//                           }
//                         } else {
//                           showAppDialog(
//                               alertType: AlertType.FAIL,
//                               isSessionTimeout: true,
//                               title: AppLocalizations.of(context)
                    // .translate(ErrorHandler.TITLE_ERROR),
//                               message:"Maximum size of the attachment shall be 1MB. Please Try again.",
//                               onPositiveCallback: () {
//                                 // logout();
//                               });
//                         }
//                       }
//                     },
//                     child: SizedBox(
//                   height: 50,
//                   child: Row(children: [Image.asset(
//                             AppAssets.icImage,
//                             scale: 3,
//                           ),const SizedBox(width: 20,),Text(AppLocalizations.of(context).translate("photos"),)],),
//                 )),
//                 const SizedBox(height: 20,),
//                 InkWell(
//                   onTap: () async {
//                   final file = await pickFiles();
//                       if (file?.path != null) {
//                         if (getFileSizeInMB(file?.path ?? "") <= AppConstants.UPLOAD_FILE_SIZE_IN_MB) {
//                           if (mounted) {
//                             Navigator.pop(
//                                 context,
//                                 AttachmentData(
//                                   base64File: base64Encode(File(file!.path).readAsBytesSync(),),
//                                   extension: getFileExtension(file.path),
//                                   fileName: getFileName(file.path),
//                                   filePath: file.path,
//                                   file: File(file.path),
//                                 ));
//                           }
//                         } else {
//                           showAppDialog(
//                              alertType: AlertType.FAIL,
//                               isSessionTimeout: true,
//                               title: AppLocalizations.of(context)
                    // .translate(ErrorHandler.TITLE_ERROR),
//                               message:"Maximum size of the attachment shall be 1MB. Please Try again.",
//                               onPositiveCallback: () {
//                                 // logout();
//                               });
//                         }
//                       } 
//                   },
//                   child: SizedBox(
//                     height: 50,
//                     child: Row(children: [Image.asset(
//                     AppAssets.icFolder,
//                     scale: 3,),
//                     const SizedBox(width: 20,),
//                     Text(AppLocalizations.of(context).translate("files"),)],),
//                   )),
//                 const SizedBox(
//                   width: 1,
//                 ),
//               ],
//             ),
//             const Spacer(),
//             AppButton(
//               buttonType:  ButtonType.PRIMARYENABLED,
//               buttonText: AppLocalizations.of(context).translate("cancel"),
//               onTapButton: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   Future<File?> pickImageCamera() async {
//     try {
//       final result = await ImagePicker().pickImage(
//           source: ImageSource.camera,
//           imageQuality: 80,
//           maxHeight: 800,
//           maxWidth: 800);
//       if (result != null) {
//         final CroppedFile? cropped =
//             await AppImageCropper().getCroppedImage(PickedFile(result.path),context);
//         if (cropped != null) {
//           final photo = File(cropped.path);
//           return photo;
//         }
//         return null;
//       }
//     } on PlatformException catch (e) {
      
//     }
//     return null;
//   }

//   Future<File?> pickFiles() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//           type: FileType.custom,
//           allowedExtensions: ["pdf", "jpeg", "jpg", "png", "xls"]);
//       if (result != null) {
//         File file = File(result.files.first.path!);
//         return file;
//       }
//     } on PlatformException catch (e) {
//     }
//     return null;
//   }

//   double getFileSizeInMB(String filepath) {
//     var file = File(filepath);
//     int bytes = file.lengthSync();
//     if (bytes <= 0) return 0.0;
//     double sizeInMb = bytes / (1024 * 1024);
//     return double.parse(sizeInMb.toStringAsFixed(2));
//   }

//   String getFileName(String filepath) {
//     File file = File(filepath);
//     String basename = file.path.split(Platform.pathSeparator).last;
//     return basename;
//   }

//   String getFileExtension(String filepath) {
//     return filepath.split('.').last;
//   }

//   @override
//   BaseBloc<BaseEvent, BaseState> getBloc() {
//     return bloc;
//   }
// }

