import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

class UserController extends GetxController {
  final supabase = Supabase.instance.client; //supabase client

  //user data
  final isLogged = false.obs;
  final uid = ''.obs;
  final name = ''.obs;
  final initials = ''.obs;
  final email = ''.obs;
  final phoneNumber = ''.obs;
  final photoUrl = ''.obs;
  final photoUint = Uint8List(0).obs;
  final photoName = ''.obs;

  //password management
  final passwordObscure = true.obs;
  final rePasswordObscure = true.obs;
  final oldPasswordObscure = true.obs;

  void setpassObscure() {
    passwordObscure.value = !passwordObscure.value;
  }

  void setrePassObscure() {
    rePasswordObscure.value = !rePasswordObscure.value;
  }

  void setOldPassObscure() {
    oldPasswordObscure.value = !oldPasswordObscure.value;
  }

  //form controllers
  final nameController = TextEditingController(text: 'Gustavo Falavigna');
  final emailController = TextEditingController(text: 'gfalav@yahoo.com');
  final passwordController = TextEditingController(text: 'pppppppp');
  final repasswordController = TextEditingController(text: 'pppppppp');
  final oldPasswordController = TextEditingController(text: 'pppppppp');
  final phoneNumberController = TextEditingController(text: '2664512644');

  @override
  void onInit() {
    supabase.auth.onAuthStateChange.listen((data) {
      final Session? session = data.session;
      setUser(session);
    });
    super.onInit();
  }

  void setUser(Session? session) {
    if (session != null) {
      isLogged.value = true;
      uid.value = session.user.id;
      email.value = session.user.email != null ? session.user.email! : '';
      name.value = session.user.userMetadata!['name'] ?? '';
      phoneNumber.value = session.user.userMetadata!['phoneNumber'] ?? '';
      photoUrl.value = '';
      photoUrl.value = supabase.storage
          .from('profilepictures')
          .getPublicUrl(session.user.userMetadata!['photoUrl'] ?? '');
      initials.value = name.value.split(" ").map((l) => l[0]).take(2).join();
    } else {
      isLogged.value = false;
      uid.value = '';
      email.value = '';
      name.value = '';
      phoneNumber.value = '';
      photoUrl.value = '';
      initials.value = '';
    }
  }

  Future<void> signUp() async {
    try {
      await supabase.auth.signUp(
        email: emailController.text,
        password: passwordController.text,
        data: {
          'name': nameController.text,
          'phoneNumber': phoneNumberController.text,
          'photoUrl': '',
        },
      );
      Get.snackbar(
        "Debe confirmar su mail",
        "Verifique su casilla o spam",
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAllNamed('/signin');
    } on AuthException catch (e) {
      Get.snackbar(
        "Error on Sign Up",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on Exception catch (e) {
      Get.snackbar(
        "Error on Sign Up",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> signIn() async {
    try {
      await supabase.auth.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Get.snackbar(
        "Bienvenido a Qubit",
        "",
        snackPosition: SnackPosition.BOTTOM,
      );
    } on AuthException catch (e) {
      Get.snackbar(
        "Error on Sign In",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on Exception catch (e) {
      Get.snackbar(
        "Error on Sign In",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
      Get.snackbar(
        "User Signed Out",
        "GoodBye",
        snackPosition: SnackPosition.BOTTOM,
      );
    } on AuthException catch (e) {
      Get.snackbar(
        "Error on Sign Out",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on Exception catch (e) {
      Get.snackbar(
        "Error on Sign Out",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> resetPassword() async {
    try {
      await supabase.auth.resetPasswordForEmail(emailController.text);
      Get.snackbar(
        "Email enviado",
        "Verifique su email or spam",
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAllNamed('/signin');
    } on AuthException catch (e) {
      Get.snackbar(
        "Error on Reset Password",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on Exception catch (e) {
      Get.snackbar(
        "Error on Reset Password",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await supabase.auth.signUp(email: emailController.text, password: '');
      Get.snackbar(
        "Email enviado",
        "Verifique su casilla o spam",
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAllNamed('/signin');
    } on AuthException catch (e) {
      Get.snackbar(
        "Error sending email",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on Exception catch (e) {
      Get.snackbar(
        "Error sending email",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> updatePassword() async {
    try {
      await supabase.auth.updateUser(
        UserAttributes(password: passwordController.text),
      );
      Get.snackbar(
        "Password Actualizada",
        "",
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAllNamed('/home');
    } on AuthException catch (e) {
      Get.snackbar(
        "Error on Password Update",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on Exception catch (e) {
      Get.snackbar(
        "Error on Password Update",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> updateName() async {
    try {
      await supabase.auth.updateUser(
        UserAttributes(data: {'name': nameController.text}),
      );
      Get.snackbar(
        "Nombre de usuario cambiado",
        "",
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAllNamed('/home');
    } on AuthException catch (e) {
      Get.snackbar(
        "Error on Name Update",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on Exception catch (e) {
      Get.snackbar(
        "Error on Name Update",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    photoUint.value = await image.readAsBytes();
    photoName.value = image.name;
  }

  Future<void> updatePhotoUrl() async {
    try {
      await supabase.storage
          .from('profilepictures')
          .updateBinary(
            '${uid.value}.${photoName.split('.').last}',
            photoUint.value,
            fileOptions: FileOptions(cacheControl: '3600', upsert: false),
          );
      await supabase.auth.updateUser(
        UserAttributes(
          data: {'photoUrl': '${uid.value}.${photoName.split('.').last}'},
        ),
      );
      Get.snackbar("Foto actualizada", "", snackPosition: SnackPosition.BOTTOM);
      Get.offAllNamed('/home');
    } on AuthException catch (e) {
      Get.snackbar(
        "Error on Photo Update",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on Exception catch (e) {
      Get.snackbar(
        "Error on Photo Update",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> updatePhoneNumber(String phoneNumber) async {
    try {
      await supabase.auth.updateUser(
        UserAttributes(data: {'phoneNumber': phoneNumber}),
      );
      Get.snackbar(
        "Teléfono actualizado",
        "",
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAllNamed('/signin');
    } on AuthException catch (e) {
      Get.snackbar(
        "Error on Phone Update",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on Exception catch (e) {
      Get.snackbar(
        "Error on Phone Update",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void initRouteIsLogged() {
    routeIsLogged();
    ever(isLogged, (callback) => routeIsLogged());
  }

  void routeIsLogged() {
    if (isLogged.value) {
      Get.offAllNamed("/home");
    } else {
      Get.offAllNamed("/signin");
    }
  }
}
