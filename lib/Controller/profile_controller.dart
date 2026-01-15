import 'dart:convert';
import 'dart:io';
// ignore: implementation_imports
import 'package:dio/src/form_data.dart' as formdata;
// ignore: implementation_imports
import 'package:dio/src/multipart_file.dart' as multipart_file;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xpressfly_git/Constants/api_constant.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart';
import 'package:xpressfly_git/Models/profile_model.dart';
import 'package:xpressfly_git/Screens/AuthScreens/device_info_details.dart';
import 'package:xpressfly_git/Services/rest_service.dart';
import 'package:xpressfly_git/Utility/api_error_handler.dart';
import 'package:xpressfly_git/Utility/app_utility.dart';

class ProfileController extends GetxController {
  var mobileTextEditingController = TextEditingController();
  var nameTextEditingController = TextEditingController();
  var emailTextEditingController = TextEditingController();
  var addressTextEditingController = TextEditingController();
  var pincodeTextEditingController = TextEditingController();
  var cityTextEditingController = TextEditingController();
  var bankAccountHolderNameController = TextEditingController();
  var bankAccountNumberController = TextEditingController();
  var bankIFSCController = TextEditingController();

  final RxBool isEditingName = false.obs;
  GlobalKey<FormState> formKeyProfile = GlobalKey<FormState>();

  // Image file references
  Rx<File?> profileImage = Rx<File?>(null);
  Rx<File?> aadharCardFront = Rx<File?>(null);
  Rx<File?> aadharCardBack = Rx<File?>(null);
  Rx<File?> driverLicenseFront = Rx<File?>(null);
  Rx<File?> driverLicenseBack = Rx<File?>(null);

  var imgPicker = ImagePicker();

  Rx<GetUserProfileDataModel> userDetails = Rx<GetUserProfileDataModel>(
    GetUserProfileDataModel(),
  );

  @override
  void onInit() {
    super.onInit();
    getData().then((value) {
      _initializeControllers();
    });
  }

  void _initializeControllers() {
    final storage = GetStorage();

    // Initialize from API response if available
    if (userDetails.value.user != null) {
      nameTextEditingController.text = userDetails.value.user?.name ?? '';
      mobileTextEditingController.text = userDetails.value.user?.phone ?? '';
      emailTextEditingController.text = userDetails.value.user?.email ?? '';
      addressTextEditingController.text = userDetails.value.user?.address ?? '';
      pincodeTextEditingController.text = userDetails.value.user?.pincode ?? '';
      cityTextEditingController.text = userDetails.value.user?.city ?? '';
      bankAccountHolderNameController.text =
          userDetails.value.user?.bankAccountHolderName ?? '';
      bankAccountNumberController.text =
          userDetails.value.user?.bankAccountNumber ?? '';
      bankIFSCController.text = userDetails.value.user?.bankIfsc ?? '';
      if (userDetails.value.user?.profileImage != null &&
          userDetails.value.user!.profileImage!.isNotEmpty) {
        // Store the image URL for display purposes
        storage.write(
          'profile_image_url',
          userDetails.value.user?.profileImage ?? '',
        );
      }
    } else {
      nameTextEditingController.text = storage.read(userName) ?? '';
      mobileTextEditingController.text = storage.read(userPhone) ?? '';
      emailTextEditingController.text = storage.read(userEmail) ?? '';
      addressTextEditingController.text = storage.read(userAddress) ?? '';
      pincodeTextEditingController.text = storage.read(userPincode) ?? '';
      cityTextEditingController.text = storage.read(userCity) ?? '';
      bankAccountHolderNameController.text =
          storage.read('bank_account_holder_name') ?? '';
      bankAccountNumberController.text =
          storage.read('bank_account_number') ?? '';
      bankIFSCController.text = storage.read('bank_ifsc') ?? '';
    }
  }

  Future getData() async {
    await getUserDetails((p0) {});
  }

  Future<void> pickImage(ImageSource source, Rx<File?> imageFile) async {
    final pickedFile = await imgPicker.pickImage(source: source);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  // Update Profile Method with all fields
  Future<bool> updateUserProfile(Function(bool) onCompleteHandler) async {
    Future.delayed(Duration.zero, () {
      showLoading();
    });

    try {
      // Get user role to determine which API to call
      final userRoleValue = GetStorage().read(userRole) ?? 'customer';

      // Create form data based on user role
      Map<String, dynamic> formDataMap = {};

      if (userRoleValue == 'driver') {
        // Driver profile data
        formDataMap = {
          'name': nameTextEditingController.text.trim(),
          // 'phone': mobileTextEditingController.text.trim(),
          'email': emailTextEditingController.text.trim(),
          'address': addressTextEditingController.text.trim(),
          'pincode': pincodeTextEditingController.text.trim(),
          'city': cityTextEditingController.text.trim(),
          // 'device_fcm_token':
          //     // GetStorage().read('device_fcm_token') ??
          //     'c_-jq5UPIwCQilLKVuWtgf:APA91bFG4hy_yuIW2OidJLe7CCWWtM6u5hMolcMcXATwrUDTv9nzq4fd5NnA97vyEtb9VnzS4l7CmEtwDQQRLoBKoUVtceb9OyUb7iWjEbeQs6RKgGV2w74',
          // "device_id": deviceInfo["deviceId"],
          // "device_name": deviceInfo["deviceName"],
          // "device_type": deviceInfo["deviceType"],
          // 'bank_account_holder_name':
          //     bankAccountHolderNameController.text.trim(),
          // 'bank_account_number': bankAccountNumberController.text.trim(),
          // 'bank_ifsc': bankIFSCController.text.trim(),
          'is_duty_on': GetStorage().read('is_duty_on') ?? '0',
        };
      } else {
        // Customer profile data - phone is NOT editable for customers
        formDataMap = {
          'name': nameTextEditingController.text.trim(),
          'email': emailTextEditingController.text.trim(),
          'address': addressTextEditingController.text.trim(),
          'pincode': pincodeTextEditingController.text.trim(),
          'city': cityTextEditingController.text.trim(),
          'is_phone_verified': '1',
        };
      }

      var formData = formdata.FormData.fromMap(formDataMap);

      // Add image files based on user role
      if (userRoleValue == 'driver') {
        if (profileImage.value != null) {
          formData.files.add(
            MapEntry(
              'profile_image',
              await multipart_file.MultipartFile.fromFile(
                profileImage.value!.path,
                filename: profileImage.value!.path.split('/').last,
              ),
            ),
          );
        }

        // if (aadharCardFront.value != null) {
        //   formData.files.add(
        //     MapEntry(
        //       'adhar_card_front',
        //       await multipart_file.MultipartFile.fromFile(
        //         aadharCardFront.value!.path,
        //         filename: aadharCardFront.value!.path.split('/').last,
        //       ),
        //     ),
        //   );
        // }

        // if (aadharCardBack.value != null) {
        //   formData.files.add(
        //     MapEntry(
        //       'adhar_card_back',
        //       await multipart_file.MultipartFile.fromFile(
        //         aadharCardBack.value!.path,
        //         filename: aadharCardBack.value!.path.split('/').last,
        //       ),
        //     ),
        //   );
        // }

        // if (driverLicenseFront.value != null) {
        //   formData.files.add(
        //     MapEntry(
        //       'driver_license_front',
        //       await multipart_file.MultipartFile.fromFile(
        //         driverLicenseFront.value!.path,
        //         filename: driverLicenseFront.value!.path.split('/').last,
        //       ),
        //     ),
        //   );
        // }

        // if (driverLicenseBack.value != null) {
        //   formData.files.add(
        //     MapEntry(
        //       'driver_license_back',
        //       await multipart_file.MultipartFile.fromFile(
        //         driverLicenseBack.value!.path,
        //         filename: driverLicenseBack.value!.path.split('/').last,
        //       ),
        //     ),
        //   );
        // }
        // Replace the entire else block for customers (around lines 175-271)
        // This is the COMPLETE customer section - remove all the old code
        else {
          // For customers - check if there's an existing profile image OR a new one selected
          final hasExistingImage =
              userDetails.value.user?.profileImage != null &&
              userDetails.value.user!.profileImage!.isNotEmpty;

          // Only require image selection if there's no existing image
          if (profileImage.value == null && !hasExistingImage) {
            hideLoading();
            declineDialog("Error", "Please select a profile image first");
            onCompleteHandler(false);
            return false;
          }

          // Only add profile image to form if a new one was selected
          if (profileImage.value != null) {
            formData.files.add(
              MapEntry(
                'profile_image',
                await multipart_file.MultipartFile.fromFile(
                  profileImage.value!.path,
                  filename: profileImage.value!.path.split('/').last,
                ),
              ),
            );
          }

          // Optionally add Aadhar cards if selected
          if (aadharCardFront.value != null) {
            formData.files.add(
              MapEntry(
                'adhar_card_front',
                await multipart_file.MultipartFile.fromFile(
                  aadharCardFront.value!.path,
                  filename: aadharCardFront.value!.path.split('/').last,
                ),
              ),
            );
          }

          if (aadharCardBack.value != null) {
            formData.files.add(
              MapEntry(
                'adhar_card_back',
                await multipart_file.MultipartFile.fromFile(
                  aadharCardBack.value!.path,
                  filename: aadharCardBack.value!.path.split('/').last,
                ),
              ),
            );
          }
        }
      }

      // Use Dio directly for better control
      final dio = Dio();
      String apiEndpoint =
          userRoleValue == 'driver'
              ? ApiConstant.updateDriverProfile
              : ApiConstant.updateCustomerProfile;

      final fullUrl = '${ApiConstant.baseUrl}$apiEndpoint';

      debugPrint('=== REQUEST DEBUG ===');
      debugPrint('Full URL: $fullUrl');
      debugPrint('Method: PATCH');
      debugPrint('Form Data Fields: ${formData.fields}');
      debugPrint(
        'Form Data Files: ${formData.files.map((e) => e.key).toList()}',
      );

      final response = await dio.patch(
        fullUrl,
        data: formData,
        options: Options(
          headers: {
            'Authorization': GetStorage().read(accessToken),
            'accept': 'application/json',
          },
          validateStatus: (status) => true, // Accept all status codes
        ),
      );

      debugPrint('=== RESPONSE DEBUG ===');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Data: ${response.data}');

      hideLoading();

      // Handle successful response (200 or 201)
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = response.data;

        // API returns {message: "...", user: {...}}
        if (responseData is Map && responseData['user'] != null) {
          // Extract user data from response
          final userData = responseData['user'];

          // Update GetStorage with data from API response
          GetStorage().write(userName, userData['name'] ?? '');
          GetStorage().write(userPhone, userData['phone'] ?? '');
          GetStorage().write(userEmail, userData['email'] ?? '');
          GetStorage().write(userAddress, userData['address'] ?? '');
          GetStorage().write(userPincode, userData['pincode'] ?? '');
          GetStorage().write(userCity, userData['city'] ?? '');

          if (userRoleValue == 'driver') {
            GetStorage().write(
              'bank_account_holder_name',
              userData['bank_account_holder_name'] ?? '',
            );
            GetStorage().write(
              'bank_account_number',
              userData['bank_account_number'] ?? '',
            );
            GetStorage().write('bank_ifsc', userData['bank_ifsc'] ?? '');
          }

          // Refresh user details from API
          await getUserDetails((p0) {});

          onCompleteHandler(true);
          approvedDialog(
            "Success",
            responseData['message'] ?? 'Profile updated successfully',
          );
          return true;
        }
      }

      // Handle error responses
      var errorData = response.data;
      String errorMessage = 'Failed to update profile';

      if (errorData is Map) {
        if (errorData['errors'] != null) {
          final errors = errorData['errors'] as Map<String, dynamic>;
          errorMessage = errors.entries
              .map((entry) {
                final value = entry.value;
                if (value is List) {
                  return '${entry.key}: ${value.join(', ')}';
                }
                return '${entry.key}: ${value.toString()}';
              })
              .join('\n');
        } else if (errorData['message'] != null) {
          errorMessage = errorData['message'].toString();
        } else if (errorData is String) {
          errorMessage = errorData.toString();
        }
      }

      onCompleteHandler(false);
      declineDialog("Error", errorMessage);
      return false;
    } catch (error) {
      hideLoading();
      debugPrint('=== EXCEPTION ===');
      debugPrint('Error Type: ${error.runtimeType}');
      debugPrint('Error: $error');

      if (error is DioException) {
        debugPrint('DioException Type: ${error.type}');
        debugPrint('Response: ${error.response?.data}');

        String errorMessage = 'Failed to update profile';
        if (error.response?.data is Map) {
          final data = error.response?.data;
          if (data['message'] != null) {
            errorMessage = data['message'];
          }
        }
        declineDialog("Error", errorMessage);
      } else {
        handleError(error);
      }

      onCompleteHandler(false);
      return false;
    }
  }

  Future<bool> getUserDetails(Function(bool) onCompleteHandler) async {
    Future.delayed(Duration.zero, () {
      showLoading();
    });
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': GetStorage().read(accessToken),
    };

    try {
      var response = await ServiceCall().get(
        ApiConstant.baseUrl,
        ApiConstant.profile,
        headers,
      );

      if (response == null) {
        hideLoading();
        onCompleteHandler(false);
        return false;
      }

      userDetails.value = GetUserProfileDataModel.fromJson(
        jsonDecode(response),
      );

      // Save to GetStorage for offline access
      final user = userDetails.value.user;
      if (user != null) {
        GetStorage().write(userName, user.name ?? '');
        GetStorage().write(userPhone, user.phone ?? '');
        GetStorage().write(userEmail, user.email ?? '');
        GetStorage().write(userAddress, user.address ?? '');
        GetStorage().write(userPincode, user.pincode ?? '');
        GetStorage().write(userCity, user.city ?? '');
        GetStorage().write(
          'bank_account_holder_name',
          user.bankAccountHolderName ?? '',
        );
        GetStorage().write('bank_account_number', user.bankAccountNumber ?? '');
        GetStorage().write('bank_ifsc', user.bankIfsc ?? '');
      }

      hideLoading();
      onCompleteHandler(true);
      return userDetails.value != null;
    } catch (error) {
      hideLoading();
      if (error is DioException) {
        final responseData = error.response?.data;
        debugPrint('Response Data: $responseData');

        Map<String, dynamic>? parsedData;
        if (responseData is String) {
          try {
            parsedData = jsonDecode(responseData);
          } catch (e) {
            debugPrint('Failed to parse responseData: $e');
          }
        } else if (responseData is Map<String, dynamic>) {
          parsedData = responseData;
        }

        if (parsedData != null && parsedData['errors'] != null) {
          final errors = parsedData['errors'] as Map<String, dynamic>;
          final errorMessage = errors.entries
              .map((entry) {
                final value = entry.value;
                if (value is List) {
                  return value.join(', ');
                } else {
                  return value.toString();
                }
              })
              .join('\n');
          declineDialog("Error", errorMessage);
        }
      } else {
        handleError(error);
      }
      onCompleteHandler(false);
      return false;
    }
  }
}
