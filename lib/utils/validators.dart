import 'package:mouthooq/utils/extensions/validation_extension.dart';

class CommonValidators {
  static String? Function(String?) get requiredEmail => (value) =>
      value.validate([
            (v) => v.required,
            (v) => v.email,
      ]);

  static String? Function(String?) get requiredPassword => (value) =>
      value.validate([
            (v) => v.required,
            (v) => v.password,
      ]);

  static String? Function(String?) get requiredStrongPassword => (value) =>
      value.validate([
            (v) => v.required,
            (v) => v.strongPassword,
      ]);

  static String? Function(String?) get requiredName => (value) =>
      value.validate([
            (v) => v.required,
            (v) => v.name,
      ]);

  static String? Function(String?) get requiredPhone => (value) =>
      value.validate([
            (v) => v.required,
            (v) => v.phone,
      ]);

  static String? Function(String?) passwordConfirmation(String originalPassword) =>
          (value) => value?.validate([
            (v) => v.required,
            (v) => v.confirmation(originalPassword),
      ]);

  // static String? Function(String?) usernameValidator => (value) =>
  // value.validate([
  // (v) => v.required,
  // (v) => v.minLength(3),
  // (v) => v.maxLength(20),
  // (v) => v.pattern(
  // RegExp(r'^[a-zA-Z0-9_]+$'),
  // 'validation.username_invalid'
  // ),
  // ]);
}