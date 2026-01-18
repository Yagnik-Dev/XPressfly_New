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
    _clearAllData();
    getData().then((value) {
      _initializeControllers();
    });
  }

  void _clearAllData() {
    profileImage.value = null;
    aadharCardFront.value = null;
    aadharCardBack.value = null;
    driverLicenseFront.value = null;
    driverLicenseBack.value = null;
    userDetails.value = GetUserProfileDataModel();
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
  // Replace the entire updateUserProfile method with this corrected version:

  Future<bool> updateUserProfile(Function(bool) onCompleteHandler) async {
    Future.delayed(Duration.zero, () {
      showLoading();
    });

    try {
      final userRoleValue = GetStorage().read(userRole) ?? 'customer';

      Map<String, dynamic> formDataMap = {};

      if (userRoleValue == 'driver') {
        formDataMap = {
          'name': nameTextEditingController.text.trim(),
          'email': emailTextEditingController.text.trim(),
          'address': addressTextEditingController.text.trim(),
          'pincode': pincodeTextEditingController.text.trim(),
          'city': cityTextEditingController.text.trim(),
          'is_duty_on': GetStorage().read('is_duty_on') ?? '0',
        };
      } else {
        // Customer profile data
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

      // Add image files for both driver and customer
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

      // Driver-specific images
      if (userRoleValue == 'driver') {
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

        if (driverLicenseFront.value != null) {
          formData.files.add(
            MapEntry(
              'driver_license_front',
              await multipart_file.MultipartFile.fromFile(
                driverLicenseFront.value!.path,
                filename: driverLicenseFront.value!.path.split('/').last,
              ),
            ),
          );
        }

        if (driverLicenseBack.value != null) {
          formData.files.add(
            MapEntry(
              'driver_license_back',
              await multipart_file.MultipartFile.fromFile(
                driverLicenseBack.value!.path,
                filename: driverLicenseBack.value!.path.split('/').last,
              ),
            ),
          );
        }
      } else {
        // Customer - optional Aadhar cards
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
          validateStatus: (status) => true,
        ),
      );

      debugPrint('=== RESPONSE DEBUG ===');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Data: ${response.data}');

      hideLoading();

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = response.data;

        if (responseData is Map && responseData['user'] != null) {
          final userData = responseData['user'];

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

          // Clear the local file reference after successful upload
          profileImage.value = null;

          // Refresh user details from API to get updated profile image URL
          await getUserDetails((p0) {});

          onCompleteHandler(true);
          approvedDialog(
            "Success",
            responseData['message'] ?? 'Profile updated successfully',
          );
          return true;
        }
      }

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
        declineDialog("Error", "Failed to update profile. Please try again.");
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
      // _initializeControllers();
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

  @override
  void onClose() {
    _clearAllData();
    nameTextEditingController.dispose();
    mobileTextEditingController.dispose();
    emailTextEditingController.dispose();
    addressTextEditingController.dispose();
    pincodeTextEditingController.dispose();
    cityTextEditingController.dispose();
    bankAccountHolderNameController.dispose();
    bankAccountNumberController.dispose();
    bankIFSCController.dispose();
    super.onClose();
  }
}
