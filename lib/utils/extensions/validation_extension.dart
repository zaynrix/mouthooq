import 'package:easy_localization/easy_localization.dart';

extension StringValidation on String? {
  // Basic validations
  String? get required {
    if (this == null || this!.trim().isEmpty) {
      return 'validation.required'.tr();
    }
    return null;
  }

  String? get email {
    if (this == null || this!.trim().isEmpty) {
      return 'validation.required'.tr();
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(this!.trim())) {
      return 'validation.email_invalid'.tr();
    }
    return null;
  }

  String? get password {
    if (this == null || this!.trim().isEmpty) {
      return 'validation.required'.tr();
    }

    if (this!.length < 6) {
      return 'validation.password_min'.tr();
    }
    return null;
  }

  String? get strongPassword {
    if (this == null || this!.trim().isEmpty) {
      return 'validation.required'.tr();
    }

    if (this!.length < 8) {
      return 'validation.password_min_strong'.tr();
    }

    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(this!)) {
      return 'validation.password_requirements'.tr();
    }
    return null;
  }

  String? get phone {
    if (this == null || this!.trim().isEmpty) {
      return 'validation.required'.tr();
    }

    final phoneRegex = RegExp(r'^[+]?[1-9][\d]{7,14}$');
    if (!phoneRegex.hasMatch(this!.replaceAll(RegExp(r'[\s\-\(\)]'), ''))) {
      return 'validation.phone_invalid'.tr();
    }
    return null;
  }

  String? get name {
    if (this == null || this!.trim().isEmpty) {
      return 'validation.required'.tr();
    }

    if (this!.trim().length < 2) {
      return 'validation.name_min'.tr();
    }

    if (!RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$').hasMatch(this!.trim())) {
      return 'validation.name_invalid'.tr();
    }
    return null;
  }

  String? get url {
    if (this == null || this!.trim().isEmpty) {
      return 'validation.required'.tr();
    }

    final urlRegex = RegExp(
        r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$'
    );
    if (!urlRegex.hasMatch(this!.trim())) {
      return 'validation.url_invalid'.tr();
    }
    return null;
  }

  // Length validations
  String? minLength(int min) {
    if (this == null || this!.trim().isEmpty) {
      return 'validation.required'.tr();
    }

    if (this!.length < min) {
      return 'validation.min_length'.tr(args: [min.toString()]);
    }
    return null;
  }

  String? maxLength(int max) {
    if (this != null && this!.length > max) {
      return 'validation.max_length'.tr(args: [max.toString()]);
    }
    return null;
  }

  String? lengthBetween(int min, int max) {
    if (this == null || this!.trim().isEmpty) {
      return 'validation.required'.tr();
    }

    if (this!.length < min || this!.length > max) {
      return 'validation.length_between'.tr(args: [min.toString(), max.toString()]);
    }
    return null;
  }

  // Number validations
  String? get number {
    if (this == null || this!.trim().isEmpty) {
      return 'validation.required'.tr();
    }

    if (double.tryParse(this!) == null) {
      return 'validation.number_invalid'.tr();
    }
    return null;
  }

  String? get integer {
    if (this == null || this!.trim().isEmpty) {
      return 'validation.required'.tr();
    }

    if (int.tryParse(this!) == null) {
      return 'validation.integer_invalid'.tr();
    }
    return null;
  }

  String? minValue(double min) {
    final numberValidation = number;
    if (numberValidation != null) return numberValidation;

    final value = double.parse(this!);
    if (value < min) {
      return 'validation.min_value'.tr(args: [min.toString()]);
    }
    return null;
  }

  String? maxValue(double max) {
    final numberValidation = number;
    if (numberValidation != null) return numberValidation;

    final value = double.parse(this!);
    if (value > max) {
      return 'validation.max_value'.tr(args: [max.toString()]);
    }
    return null;
  }

  // Custom pattern validation
  String? pattern(RegExp regex, String errorKey) {
    if (this == null || this!.trim().isEmpty) {
      return 'validation.required'.tr();
    }

    if (!regex.hasMatch(this!)) {
      return errorKey.tr();
    }
    return null;
  }

  // Confirmation validation (for password confirmation)
  String? confirmation(String? originalValue) {
    if (this == null || this!.trim().isEmpty) {
      return 'validation.required'.tr();
    }

    if (this != originalValue) {
      return 'validation.password_mismatch'.tr();
    }
    return null;
  }

  // Optional validations (no required check)
  String? get optionalEmail {
    if (this == null || this!.trim().isEmpty) {
      return null; // Optional field
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(this!.trim())) {
      return 'validation.email_invalid'.tr();
    }
    return null;
  }

  String? get optionalPhone {
    if (this == null || this!.trim().isEmpty) {
      return null; // Optional field
    }

    final phoneRegex = RegExp(r'^[+]?[1-9][\d]{7,14}$');
    if (!phoneRegex.hasMatch(this!.replaceAll(RegExp(r'[\s\-\(\)]'), ''))) {
      return 'validation.phone_invalid'.tr();
    }
    return null;
  }

  String? get optionalUrl {
    if (this == null || this!.trim().isEmpty) {
      return null; // Optional field
    }

    final urlRegex = RegExp(
        r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$'
    );
    if (!urlRegex.hasMatch(this!.trim())) {
      return 'validation.url_invalid'.tr();
    }
    return null;
  }
}

// Combine multiple validations
extension ValidationComposer on String? {
  String? validate(List<String? Function(String?)> validators) {
    for (final validator in validators) {
      final result = validator(this);
      if (result != null) {
        return result; // Return first error found
      }
    }
    return null; // All validations passed
  }
}
