import 'package:get/get.dart';
import 'package:pet_pal/controllers/add_pet_controller.dart';
import 'package:pet_pal/controllers/authControllers/login_controller.dart';
import 'package:pet_pal/controllers/authControllers/signup_controller.dart';
import 'package:pet_pal/controllers/detail_screen_controller.dart';

class InitialBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(SignupController());
    Get.put(LoginController());
  }



}

class AuthBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(SignupController());
    Get.put(LoginController());
  }

}

class AddPetBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AddPetController());
  }

}

class DetailScreenBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.put(DetailScreenController(Get.arguments));
  }


}