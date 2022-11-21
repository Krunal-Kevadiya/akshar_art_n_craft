import '../models/models.dart';

class AppString {
  AppString._();

  static const String appTitle = 'app.appTitle';
  static const String welcome = 'app.welcome';
}

class SheetString {
  SheetString._();

  static const String pickFromGalleryLabel = 'sheet.pickFromGalleryLabel';
  static const String pickFromCameraLabel = 'sheet.pickFromCameraLabel';
  static const String cancelButton = 'sheet.cancelButton';
  static const String goToSettingsButton = 'sheet.goToSettingsButton';
  static const String allowButton = 'sheet.allowButton';
  static const String noThanksButton = 'sheet.noThanksButton';
  static const String pmStorageTitle = 'sheet.pmStorageTitle';
  static const String pmStorageDesc = 'sheet.pmStorageDesc';
  static const String pmStorageNotTitle = 'sheet.pmStorageNotTitle';
  static const String pmStorageNotDesc = 'sheet.pmStorageNotDesc';
  static const String pmLibraryTitle = 'sheet.pmLibraryTitle';
  static const String pmLibraryDesc = 'sheet.pmLibraryDesc';
  static const String pmLibraryNotTitle = 'sheet.pmLibraryNotTitle';
  static const String pmLibraryNotDesc = 'sheet.pmLibraryNotDesc';
  static const String pmCameraTitle = 'sheet.pmCameraTitle';
  static const String pmCameraDesc = 'sheet.pmCameraDesc';
  static const String pmCameraNotTitle = 'sheet.pmCameraNotTitle';
  static const String pmCameraNotDesc = 'sheet.pmCameraNotDesc';
}

class ErrorString {
  ErrorString._();
  static const String signIn = 'error.signIn';
  static const String emptyName = 'error.emptyName';
  static const String lengthName = 'error.lengthName';
  static const String invalidName = 'error.invalidName';
  static const String emptyEmail = 'error.emptyEmail';
  static const String invalidEmail = 'error.invalidEmail';
  static const String emptyPassword = 'error.emptyPassword';
  static const String startAlphabetCharacterInPassword =
      'error.startAlphabetCharacterInPassword';
  static const String oneUpperCaseAlphabetCharacterInPassword =
      'error.oneUpperCaseAlphabetCharacterInPassword';
  static const String oneNumericCharacterInPassword =
      'error.oneNumericCharacterInPassword';
  static const String oneSymbolCharacterInPassword =
      'error.oneSymbolCharacterInPassword';
  static const String lengthPassword = 'error.lengthPassword';
  static const String fbInvalidEmail = 'error.fbInvalidEmail';
  static const String fbWrongPassword = 'error.fbWrongPassword';
  static const String fbWeakPassword = 'error.fbWeakPassword';
  static const String fbEmailAlreadyInUse = 'error.fbEmailAlreadyInUse';
  static const String fbUnknown = 'error.fbUnknown';
  static const String emptyDescription = 'error.emptyDescription';
  static const String lengthDescription = 'error.lengthDescription';
  static const String notMatchPassword = 'error.notMatchPassword';
  static const String emptyPhone = 'error.emptyPhone';
  static const String invalidPhone = 'error.invalidPhone';
  static const String fbVerifyEmail = 'error.fbVerifyEmail';
  static const String pathNotFound = 'error.pathNotFound';
  static const String emptyComment = 'error.emptyComment';
  static const String lengthComment = 'error.lengthComment';
  static const String emptyCategory = 'error.emptyCategory';
  static const String emptySubCategory = 'error.emptySubCategory';
  static const String emptyBrand = 'error.emptyBrand';
  static const String emptyFabric = 'error.emptyFabric';
  static const String emptyDropdown = 'error.emptyDropdown';
  static const String emptyDigit = 'error.emptyDigit';
  static const String invalidDigits = 'error.invalidDigits';
  static const String emptySize = 'error.emptySize';
  static const String emptyWeight = 'error.emptyWeight';
  static const String emptyMoq = 'error.emptyMoq';
}

class SignInString {
  SignInString._();

  static const String signInTitle = 'signIn.signInTitle';
  static const String emailHint = 'signIn.emailHint';
  static const String passwordHint = 'signIn.passwordHint';
  static const String forgotPasswordLabel = 'signIn.forgotPasswordLabel';
  static const String signInDescription = 'signIn.signInDescription';
}

class SignUpString {
  SignUpString._();

  static const String signUpTitle = 'signUp.signUpTitle';
  static const String nameHint = 'signUp.nameHint';
  static const String orLabel = 'signUp.orLabel';
  static const String signUpDescription = 'signUp.signUpDescription';
}

class ForgotPasswordString {
  ForgotPasswordString._();

  static const String forgotPasswordTitle =
      'forgotPassword.forgotPasswordTitle';
  static const String msgForgotEmail = 'forgotPassword.msgForgotEmail';
}

class VerifyEmailString {
  VerifyEmailString._();

  static const String verifyEmailTitle = 'verifyEmail.verifyEmailTitle';
  static const String resentEmailButton = 'verifyEmail.resentEmailButton';
}

class DrawerMenuString {
  DrawerMenuString._();

  static const String shopForSection = 'drawerMenu.shopForSection';
  static const String home = 'drawerMenu.home';
  static const String category = 'drawerMenu.category';
  static const String subCategory = 'drawerMenu.subCategory';
  static const String brand = 'drawerMenu.brand';
  static const String fabric = 'drawerMenu.fabric';
  static const String product = 'drawerMenu.product';
  static const String shopByCategory = 'drawerMenu.shopByCategory';
  static const String videos = 'drawerMenu.videos';
  static const String myAccountSection = 'drawerMenu.myAccountSection';
  static const String signIn = 'drawerMenu.signIn';
  static const String wishlist = 'drawerMenu.wishlist';
  static const String orders = 'drawerMenu.orders';
  static const String profile = 'drawerMenu.profile';
  static const String logout = 'drawerMenu.logout';
  static const String hellAndSupportSection =
      'drawerMenu.hellAndSupportSection';
  static const String testimonials = 'drawerMenu.testimonials';
  static const String contactUs = 'drawerMenu.contactUs';
  static const String aboutUs = 'drawerMenu.aboutUs';
  static const String shareApp = 'drawerMenu.shareApp';
  static const String rateUs = 'drawerMenu.rateUs';
}

class CatalogString {
  CatalogString._();

  static const String categoryTitle = 'catalog.categoryTitle';
  static const String subCategoryTitle = 'catalog.subCategoryTitle';
  static const String brandTitle = 'catalog.brandTitle';
  static const String fabricTitle = 'catalog.fabricTitle';
  static const String nameLabel = 'catalog.nameLabel';
  static const String descriptionLabel = 'catalog.descriptionLabel';
  static const String addButton = 'catalog.addButton';
  static const String editButton = 'catalog.editButton';
  static const String deleteButton = 'catalog.deleteButton';
  static const String deletedTitle = 'catalog.deletedTitle';
  static const String undoButton = 'catalog.undoButton';
}

class ProductString {
  ProductString._();

  static const String productTitle = 'product.productTitle';
  static const String perPiecePriceHint = 'product.perPiecePriceHint';
  static const String totalDesignHint = 'product.totalDesignHint';
  static const String sizeHint = 'product.sizeHint';
  static const String weightHint = 'product.weightHint';
  static const String moqHint = 'product.moqHint';
  static const String gstHint = 'product.gstHint';
  static const String searchLabel = 'product.searchLabel';
}

class ProfileString {
  ProfileString._();

  static const String profileTitle = 'profile.profileTitle';
  static const String phoneHint = 'profile.phoneHint';
  static const String confirmPasswordHint = 'profile.confirmPasswordHint';
  static const String saveButton = 'profile.saveButton';
  static const String msgUpdatedProfile = 'profile.msgUpdatedProfile';
}

class ContactUsString {
  ContactUsString._();

  static const String byAddressTitle = 'contact.byAddressTitle';
  static const String byAddressDesc = 'contact.byAddressDesc';
  static const String byPhoneTitle = 'contact.byPhoneTitle';
  static List<TestimonialModel> byPhoneDesc = [
    TestimonialModel(
      id: 1,
      name: 'contact.byPhoneName',
      phone: 'contact.byPhoneNo',
    )
  ];
  static const String byEmailTitle = 'contact.byEmailTitle';
  static const String byEmailDesc = 'contact.byEmailDesc';
}

class AboutUsString {
  AboutUsString._();

  static const String aboutUsDesc = 'about.aboutUsDesc';
}

class ShareAppString {
  ShareAppString._();

  static const String shareAppDesc = 'shareApp.shareAppDesc';
}

class RateUsString {
  RateUsString._();

  static const String ratingLabel = 'rate.ratingLabel';
  static const String commentHint = 'rate.commentHint';
}
