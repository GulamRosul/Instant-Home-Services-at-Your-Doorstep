import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Profile Information
  var name = "Charlotte Davis".obs;
  var email = "demo01@gmail.com".obs;
  var phone = "+110 2516542".obs;
  var profession = "Profession".obs;
  var bio = "I have taught third.....".obs;

  var imagePath = "".obs;

  // Address Information
  var streetAddress = "123 Main Street".obs;
  var city = "Ontario".obs;
  var state = "Canada".obs;
  var zipCode = "1251".obs;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }

  // Methods to update (placeholders)
  void updateName(String val) => name.value = val;
  void updateEmail(String val) => email.value = val;
  void updatePhone(String val) => phone.value = val;
  void updateProfession(String val) => profession.value = val;
  void updateBio(String val) => bio.value = val;
  void updateStreet(String val) => streetAddress.value = val;
  void updateCity(String val) => city.value = val;
  void updateState(String val) => state.value = val;
  void updateZip(String val) => zipCode.value = val;
}
