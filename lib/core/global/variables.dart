import 'package:email_otp/email_otp.dart';
import 'package:get/get.dart';
import 'package:pet_pal/models/user_model.dart';

Rx<UserModel> userModelGlobal = UserModel(
        userId: '',
        name: '',
        email: '',
        phoneNumber: '',
        profileUrl: '',
        dob: '', username: '')
    .obs;

EmailOTP myAuth = EmailOTP();