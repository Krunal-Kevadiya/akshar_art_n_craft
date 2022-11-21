import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';

class Validations {
  Validations._();

  static FormFieldValidator<String>? name = (name) {
    if (name == null || name.isEmpty) {
      return ErrorString.emptyName.tr();
    }
    name = name.trim();
    if (name.length < 4) {
      return ErrorString.lengthName.tr();
    }
    final nameRegExp = RegExp('^[a-zA-Z0-9 À-ÖØ-öø-ÿ]');
    if (!nameRegExp.hasMatch(name)) {
      return ErrorString.invalidName.tr();
    }
    return null;
  };

  static FormFieldValidator<String>? email = (email) {
    if (email == null || email.isEmpty) {
      return ErrorString.emptyEmail.tr();
    }
    email = email.trim();
    final emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (!emailRegExp.hasMatch(email)) {
      return ErrorString.invalidEmail.tr();
    }
    return null;
  };

  static FormFieldValidator<String>? password = (password) {
    if (password == null || password.isEmpty) {
      return ErrorString.emptyPassword.tr();
    }
    password = password.trim();
    if (!password.startsWith(RegExp('[A-Z][a-z]'))) {
      return ErrorString.startAlphabetCharacterInPassword.tr();
    }
    if (!password.contains(RegExp('[A-Z]'))) {
      return ErrorString.oneUpperCaseAlphabetCharacterInPassword.tr();
    }
    if (!password.contains(RegExp('[0-9]'))) {
      return ErrorString.oneNumericCharacterInPassword.tr();
    }
    if (!!password.contains(RegExp('[A-Z][a-z][0-9]'))) {
      return ErrorString.oneSymbolCharacterInPassword.tr();
    }
    if (password.length < 4 && password.length > 16) {
      return ErrorString.lengthPassword.tr();
    }
    return null;
  };

  static FormFieldValidator<String>? phone = (phone) {
    if (phone == null || phone.isEmpty) {
      return ErrorString.emptyPhone.tr();
    }
    phone = phone.trim();
    final emailRegExp = RegExp(
      r'\+(9[976]\d|8[987530]\d|6[987]\d|5[90]\d|42\d|3[875]\d|2[98654321]\d|9[8543210]|8[6421]|6[6543210]|5[87654321]|4[987654310]|3[9643210]|2[70]|7|1)\d{1,14}$',
    );
    if (!emailRegExp.hasMatch(phone)) {
      return ErrorString.invalidPhone.tr();
    }
    return null;
  };

  static FormFieldValidator<String>? changePassword = (password) {
    if (password == null || password.isEmpty) {
      return null;
    }
    password = password.trim();
    if (!password.startsWith(RegExp('[A-Z][a-z]'))) {
      return ErrorString.startAlphabetCharacterInPassword.tr();
    }
    if (!password.contains(RegExp('[A-Z]'))) {
      return ErrorString.oneUpperCaseAlphabetCharacterInPassword.tr();
    }
    if (!password.contains(RegExp('[0-9]'))) {
      return ErrorString.oneNumericCharacterInPassword.tr();
    }
    if (!!password.contains(RegExp('[A-Z][a-z][0-9]'))) {
      return ErrorString.oneSymbolCharacterInPassword.tr();
    }
    if (password.length < 4 && password.length > 16) {
      return ErrorString.lengthPassword.tr();
    }
    return null;
  };

  static FormFieldValidator<String>? confirmPassword(String? password) {
    return (String? confirmPassword) {
      if (confirmPassword == null || confirmPassword.isEmpty) {
        return null;
      }
      confirmPassword = confirmPassword.trim();
      if (!confirmPassword.startsWith(RegExp('[A-Z][a-z]'))) {
        return ErrorString.startAlphabetCharacterInPassword.tr();
      }
      if (!confirmPassword.contains(RegExp('[A-Z]'))) {
        return ErrorString.oneUpperCaseAlphabetCharacterInPassword.tr();
      }
      if (!confirmPassword.contains(RegExp('[0-9]'))) {
        return ErrorString.oneNumericCharacterInPassword.tr();
      }
      if (!!confirmPassword.contains(RegExp('[A-Z][a-z][0-9]'))) {
        return ErrorString.oneSymbolCharacterInPassword.tr();
      }
      if (confirmPassword.length < 4 && confirmPassword.length > 16) {
        return ErrorString.lengthPassword.tr();
      }
      if (password != confirmPassword) {
        return ErrorString.notMatchPassword.tr();
      }
      return null;
    };
  }

  static FormFieldValidator<String>? description = (description) {
    if (description == null || description.isEmpty) {
      return ErrorString.emptyDescription.tr();
    }
    description = description.trim();
    if (description.length < 4) {
      return ErrorString.lengthDescription.tr();
    }
    return null;
  };

  static FormFieldValidator<String>? comment = (comment) {
    if (comment == null || comment.isEmpty) {
      return ErrorString.emptyComment.tr();
    }
    comment = comment.trim();
    if (comment.length < 4) {
      return ErrorString.lengthComment.tr();
    }
    return null;
  };

  static FormFieldValidator<String>? digit = (digit) {
    if (digit == null || digit.isEmpty) {
      return ErrorString.emptyDigit.tr();
    }
    digit = digit.trim();
    if (double.tryParse(digit) == null) {
      return ErrorString.invalidDigits.tr();
    }
    return null;
  };

  static FormFieldValidator<String>? size = (size) {
    if (size == null || size.isEmpty) {
      return ErrorString.emptySize.tr();
    }
    return null;
  };

  static FormFieldValidator<String>? weight = (weight) {
    if (weight == null || weight.isEmpty) {
      return ErrorString.emptyWeight.tr();
    }
    return null;
  };

  static FormFieldValidator<String>? moq = (moq) {
    if (moq == null || moq.isEmpty) {
      return ErrorString.emptyMoq.tr();
    }
    return null;
  };
}
