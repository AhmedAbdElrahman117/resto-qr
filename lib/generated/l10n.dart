// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Enter your Email`
  String get enterYourEmail {
    return Intl.message(
      'Enter your Email',
      name: 'enterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Email Required`
  String get emailRequired {
    return Intl.message(
      'Email Required',
      name: 'emailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Email`
  String get invalidEmail {
    return Intl.message(
      'Invalid Email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Enter your Password`
  String get enterYourPassword {
    return Intl.message(
      'Enter your Password',
      name: 'enterYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password Required`
  String get passwordRequired {
    return Intl.message(
      'Password Required',
      name: 'passwordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Re enter the same Password`
  String get reenterTheSamePassword {
    return Intl.message(
      'Re enter the same Password',
      name: 'reenterTheSamePassword',
      desc: '',
      args: [],
    );
  }

  /// `Password Confirmation Required`
  String get passwordConfirmationRequired {
    return Intl.message(
      'Password Confirmation Required',
      name: 'passwordConfirmationRequired',
      desc: '',
      args: [],
    );
  }

  /// `Passwords is not Identical`
  String get passwordsNotIdentical {
    return Intl.message(
      'Passwords is not Identical',
      name: 'passwordsNotIdentical',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Phone Number`
  String get enterYourPhoneNumber {
    return Intl.message(
      'Enter your Phone Number',
      name: 'enterYourPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Phone Required`
  String get phoneRequired {
    return Intl.message(
      'Phone Required',
      name: 'phoneRequired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Number`
  String get invalidNumber {
    return Intl.message(
      'Invalid Number',
      name: 'invalidNumber',
      desc: '',
      args: [],
    );
  }

  /// `Search Country`
  String get searchCountry {
    return Intl.message(
      'Search Country',
      name: 'searchCountry',
      desc: '',
      args: [],
    );
  }

  /// `Enter Country Name Or Code`
  String get enterCountryNameOrCode {
    return Intl.message(
      'Enter Country Name Or Code',
      name: 'enterCountryNameOrCode',
      desc: '',
      args: [],
    );
  }

  /// `8 Characters at least`
  String get atLeastEightCharacters {
    return Intl.message(
      '8 Characters at least',
      name: 'atLeastEightCharacters',
      desc: '',
      args: [],
    );
  }

  /// `One Number at least`
  String get atLeastOneNumber {
    return Intl.message(
      'One Number at least',
      name: 'atLeastOneNumber',
      desc: '',
      args: [],
    );
  }

  /// `One Special Char at least`
  String get atLeastOneSpecialCharacter {
    return Intl.message(
      'One Special Char at least',
      name: 'atLeastOneSpecialCharacter',
      desc: '',
      args: [],
    );
  }

  /// `Login Failed`
  String get loginFailed {
    return Intl.message(
      'Login Failed',
      name: 'loginFailed',
      desc: '',
      args: [],
    );
  }

  /// `Your Restaurant, one scan away.`
  String get restQrTagline {
    return Intl.message(
      'Your Restaurant, one scan away.',
      name: 'restQrTagline',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back`
  String get welcomeBack {
    return Intl.message(
      'Welcome back',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to continue managing your restaurant.`
  String get signInToContinue {
    return Intl.message(
      'Sign in to continue managing your restaurant.',
      name: 'signInToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Secure account access`
  String get secureAccountAccess {
    return Intl.message(
      'Secure account access',
      name: 'secureAccountAccess',
      desc: '',
      args: [],
    );
  }

  /// `New to RestoQR?`
  String get newToRestoQr {
    return Intl.message(
      'New to RestoQR?',
      name: 'newToRestoQr',
      desc: '',
      args: [],
    );
  }

  /// ` Create an account`
  String get createAnAccount {
    return Intl.message(
      ' Create an account',
      name: 'createAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Account Info`
  String get accountInfo {
    return Intl.message(
      'Account Info',
      name: 'accountInfo',
      desc: '',
      args: [],
    );
  }

  /// `Create your login credentials to manage your restaurant menu.`
  String get createLoginCredentials {
    return Intl.message(
      'Create your login credentials to manage your restaurant menu.',
      name: 'createLoginCredentials',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get userName {
    return Intl.message('User Name', name: 'userName', desc: '', args: []);
  }

  /// `Enter your full name`
  String get enterYourFullName {
    return Intl.message(
      'Enter your full name',
      name: 'enterYourFullName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name`
  String get pleaseEnterYourName {
    return Intl.message(
      'Please enter your name',
      name: 'pleaseEnterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Business Info`
  String get businessInfo {
    return Intl.message(
      'Business Info',
      name: 'businessInfo',
      desc: '',
      args: [],
    );
  }

  /// `Add your restaurant details so customers can find you.`
  String get addRestaurantDetails {
    return Intl.message(
      'Add your restaurant details so customers can find you.',
      name: 'addRestaurantDetails',
      desc: '',
      args: [],
    );
  }

  /// `Upload Restaurant Logo`
  String get uploadRestaurantLogo {
    return Intl.message(
      'Upload Restaurant Logo',
      name: 'uploadRestaurantLogo',
      desc: '',
      args: [],
    );
  }

  /// `Supported formats: JPG, PNG, JPEG`
  String get supportedImageFormats {
    return Intl.message(
      'Supported formats: JPG, PNG, JPEG',
      name: 'supportedImageFormats',
      desc: '',
      args: [],
    );
  }

  /// `Description (Optional)`
  String get descriptionOptional {
    return Intl.message(
      'Description (Optional)',
      name: 'descriptionOptional',
      desc: '',
      args: [],
    );
  }

  /// `Add a brief Description about your Restaurant`
  String get addRestaurantDescription {
    return Intl.message(
      'Add a brief Description about your Restaurant',
      name: 'addRestaurantDescription',
      desc: '',
      args: [],
    );
  }

  /// `Restaurant Address`
  String get restaurantAddress {
    return Intl.message(
      'Restaurant Address',
      name: 'restaurantAddress',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Restaurant Address`
  String get enterRestaurantAddress {
    return Intl.message(
      'Enter your Restaurant Address',
      name: 'enterRestaurantAddress',
      desc: '',
      args: [],
    );
  }

  /// `Restaurant Address Required`
  String get restaurantAddressRequired {
    return Intl.message(
      'Restaurant Address Required',
      name: 'restaurantAddressRequired',
      desc: '',
      args: [],
    );
  }

  /// `Restaurant Location`
  String get restaurantLocation {
    return Intl.message(
      'Restaurant Location',
      name: 'restaurantLocation',
      desc: '',
      args: [],
    );
  }

  /// `Tap to select your Restaurant Location`
  String get selectRestaurantLocation {
    return Intl.message(
      'Tap to select your Restaurant Location',
      name: 'selectRestaurantLocation',
      desc: '',
      args: [],
    );
  }

  /// `Restaurant Location Required`
  String get restaurantLocationRequired {
    return Intl.message(
      'Restaurant Location Required',
      name: 'restaurantLocationRequired',
      desc: '',
      args: [],
    );
  }

  /// `Restaurant Name`
  String get restaurantName {
    return Intl.message(
      'Restaurant Name',
      name: 'restaurantName',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Restaurant Name`
  String get enterRestaurantName {
    return Intl.message(
      'Enter your Restaurant Name',
      name: 'enterRestaurantName',
      desc: '',
      args: [],
    );
  }

  /// `Restaurant Name Required`
  String get restaurantNameRequired {
    return Intl.message(
      'Restaurant Name Required',
      name: 'restaurantNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message('Account', name: 'account', desc: '', args: []);
  }

  /// `Business`
  String get business {
    return Intl.message('Business', name: 'business', desc: '', args: []);
  }

  /// `SignUp Failed`
  String get signUpFailed {
    return Intl.message(
      'SignUp Failed',
      name: 'signUpFailed',
      desc: '',
      args: [],
    );
  }

  /// `Verify Email`
  String get verifyEmail {
    return Intl.message(
      'Verify Email',
      name: 'verifyEmail',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Enter Verification Code`
  String get enterVerificationCode {
    return Intl.message(
      'Enter Verification Code',
      name: 'enterVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `OTP Required`
  String get otpRequired {
    return Intl.message(
      'OTP Required',
      name: 'otpRequired',
      desc: '',
      args: [],
    );
  }

  /// `OTP Sent`
  String get otpSent {
    return Intl.message('OTP Sent', name: 'otpSent', desc: '', args: []);
  }

  /// `OTP has been sent to your email`
  String get otpSentToEmail {
    return Intl.message(
      'OTP has been sent to your email',
      name: 'otpSentToEmail',
      desc: '',
      args: [],
    );
  }

  /// `We have sent a 4 Digits Code to:\n`
  String get verificationCodeIntro {
    return Intl.message(
      'We have sent a 4 Digits Code to:\n',
      name: 'verificationCodeIntro',
      desc: '',
      args: [],
    );
  }

  /// `Resend code in:`
  String get resendCodeIn {
    return Intl.message(
      'Resend code in:',
      name: 'resendCodeIn',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message('Resend Code', name: 'resendCode', desc: '', args: []);
  }

  /// `Forgot Password`
  String get forgotPasswordTitle {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email and we'll send you an OTP Code to reset your password.`
  String get forgotPasswordDescription {
    return Intl.message(
      'Enter your email and we\'ll send you an OTP Code to reset your password.',
      name: 'forgotPasswordDescription',
      desc: '',
      args: [],
    );
  }

  /// `Email Not Found`
  String get emailNotFound {
    return Intl.message(
      'Email Not Found',
      name: 'emailNotFound',
      desc: '',
      args: [],
    );
  }

  /// `We didn't find you email`
  String get emailNotFoundDescription {
    return Intl.message(
      'We didn\'t find you email',
      name: 'emailNotFoundDescription',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `Verify`
  String get verify {
    return Intl.message('Verify', name: 'verify', desc: '', args: []);
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your new password with the following measures for security`
  String get changePasswordDescription {
    return Intl.message(
      'Enter your new password with the following measures for security',
      name: 'changePasswordDescription',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message('Change', name: 'change', desc: '', args: []);
  }

  /// `Password Changed`
  String get passwordChanged {
    return Intl.message(
      'Password Changed',
      name: 'passwordChanged',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations, your account password is changed. now you can access your account with your new password`
  String get passwordChangedDescription {
    return Intl.message(
      'Congratulations, your account password is changed. now you can access your account with your new password',
      name: 'passwordChangedDescription',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get goToLogin {
    return Intl.message('Login', name: 'goToLogin', desc: '', args: []);
  }

  /// `Account Created!`
  String get accountCreated {
    return Intl.message(
      'Account Created!',
      name: 'accountCreated',
      desc: '',
      args: [],
    );
  }

  /// `Welcome aboard! You are now ready to create and manage your restaurant's digital menus.`
  String get accountCreatedDescription {
    return Intl.message(
      'Welcome aboard! You are now ready to create and manage your restaurant\'s digital menus.',
      name: 'accountCreatedDescription',
      desc: '',
      args: [],
    );
  }

  /// `Go to Dashboard`
  String get goToDashboard {
    return Intl.message(
      'Go to Dashboard',
      name: 'goToDashboard',
      desc: '',
      args: [],
    );
  }

  /// `Images Required`
  String get imagesRequired {
    return Intl.message(
      'Images Required',
      name: 'imagesRequired',
      desc: '',
      args: [],
    );
  }

  /// `Logo Required`
  String get logoRequired {
    return Intl.message(
      'Logo Required',
      name: 'logoRequired',
      desc: '',
      args: [],
    );
  }

  /// `Image must be less than 5 MB`
  String get imageMustBeLessThanFiveMb {
    return Intl.message(
      'Image must be less than 5 MB',
      name: 'imageMustBeLessThanFiveMb',
      desc: '',
      args: [],
    );
  }

  /// `Register Restaurant`
  String get registerRestaurant {
    return Intl.message(
      'Register Restaurant',
      name: 'registerRestaurant',
      desc: '',
      args: [],
    );
  }

  /// `Join thousands of venues. Set up your profile, upload your logo, and get ready to serve digitally.`
  String get registerRestaurantDescription {
    return Intl.message(
      'Join thousands of venues. Set up your profile, upload your logo, and get ready to serve digitally.',
      name: 'registerRestaurantDescription',
      desc: '',
      args: [],
    );
  }

  /// `Build Your Menu`
  String get buildYourMenu {
    return Intl.message(
      'Build Your Menu',
      name: 'buildYourMenu',
      desc: '',
      args: [],
    );
  }

  /// `Transform your menu into a stunning digital experience`
  String get buildYourMenuDescription {
    return Intl.message(
      'Transform your menu into a stunning digital experience',
      name: 'buildYourMenuDescription',
      desc: '',
      args: [],
    );
  }

  /// `Generate QR Codes`
  String get generateQrCodes {
    return Intl.message(
      'Generate QR Codes',
      name: 'generateQrCodes',
      desc: '',
      args: [],
    );
  }

  /// `Create unique QR codes for your menus that customers can scan to access instantly`
  String get generateQrCodesDescription {
    return Intl.message(
      'Create unique QR codes for your menus that customers can scan to access instantly',
      name: 'generateQrCodesDescription',
      desc: '',
      args: [],
    );
  }

  /// `Data Driven Decisions`
  String get dataDrivenDecisions {
    return Intl.message(
      'Data Driven Decisions',
      name: 'dataDrivenDecisions',
      desc: '',
      args: [],
    );
  }

  /// `Understand what your Customers are craving. Track menu views and popular items to maxmize your revenue`
  String get dataDrivenDecisionsDescription {
    return Intl.message(
      'Understand what your Customers are craving. Track menu views and popular items to maxmize your revenue',
      name: 'dataDrivenDecisionsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Manage Multiple Branches`
  String get manageMultipleBranches {
    return Intl.message(
      'Manage Multiple Branches',
      name: 'manageMultipleBranches',
      desc: '',
      args: [],
    );
  }

  /// `Control menus, pricing, and QR codes for all your locations from one single dashboard.`
  String get manageMultipleBranchesDescription {
    return Intl.message(
      'Control menus, pricing, and QR codes for all your locations from one single dashboard.',
      name: 'manageMultipleBranchesDescription',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message('Get Started', name: 'getStarted', desc: '', args: []);
  }

  /// `Update Available`
  String get updateAvailable {
    return Intl.message(
      'Update Available',
      name: 'updateAvailable',
      desc: '',
      args: [],
    );
  }

  /// `A new version of RestoQR is available. Please update to continue using the app.`
  String get mandatoryUpdateDescription {
    return Intl.message(
      'A new version of RestoQR is available. Please update to continue using the app.',
      name: 'mandatoryUpdateDescription',
      desc: '',
      args: [],
    );
  }

  /// `A new version of RestoQR is available. Would you like to update?`
  String get optionalUpdateDescription {
    return Intl.message(
      'A new version of RestoQR is available. Would you like to update?',
      name: 'optionalUpdateDescription',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get later {
    return Intl.message('Later', name: 'later', desc: '', args: []);
  }

  /// `Update Now`
  String get updateNow {
    return Intl.message('Update Now', name: 'updateNow', desc: '', args: []);
  }

  /// `Website Customization`
  String get websiteCustomization {
    return Intl.message(
      'Website Customization',
      name: 'websiteCustomization',
      desc: '',
      args: [],
    );
  }

  /// `Marketing & Promotions`
  String get marketingAndPromotions {
    return Intl.message(
      'Marketing & Promotions',
      name: 'marketingAndPromotions',
      desc: '',
      args: [],
    );
  }

  /// `Engage your customers with dynamic content`
  String get dynamicContentDescription {
    return Intl.message(
      'Engage your customers with dynamic content',
      name: 'dynamicContentDescription',
      desc: '',
      args: [],
    );
  }

  /// `Components`
  String get components {
    return Intl.message('Components', name: 'components', desc: '', args: []);
  }

  /// `Personalize how your digital menu looks to customers`
  String get personalizeMenuDescription {
    return Intl.message(
      'Personalize how your digital menu looks to customers',
      name: 'personalizeMenuDescription',
      desc: '',
      args: [],
    );
  }

  /// `More components will be added in future updates!`
  String get moreComponentsInfo {
    return Intl.message(
      'More components will be added in future updates!',
      name: 'moreComponentsInfo',
      desc: '',
      args: [],
    );
  }

  /// `Failed to Load Customizations`
  String get failedToLoadCustomizations {
    return Intl.message(
      'Failed to Load Customizations',
      name: 'failedToLoadCustomizations',
      desc: '',
      args: [],
    );
  }

  /// `Website updated successfully!`
  String get websiteUpdatedSuccessfully {
    return Intl.message(
      'Website updated successfully!',
      name: 'websiteUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Your changes have been saved and will reflect on your digital menu shortly.`
  String get websiteChangesSaved {
    return Intl.message(
      'Your changes have been saved and will reflect on your digital menu shortly.',
      name: 'websiteChangesSaved',
      desc: '',
      args: [],
    );
  }

  /// `Promotional Banners`
  String get promotionalBanners {
    return Intl.message(
      'Promotional Banners',
      name: 'promotionalBanners',
      desc: '',
      args: [],
    );
  }

  /// `Manage promotional banners and advertisements`
  String get managePromotionalBanners {
    return Intl.message(
      'Manage promotional banners and advertisements',
      name: 'managePromotionalBanners',
      desc: '',
      args: [],
    );
  }

  /// `Brand Primary Color`
  String get brandPrimaryColor {
    return Intl.message(
      'Brand Primary Color',
      name: 'brandPrimaryColor',
      desc: '',
      args: [],
    );
  }

  /// `Customize the primary color of your brand`
  String get customizeBrandPrimaryColor {
    return Intl.message(
      'Customize the primary color of your brand',
      name: 'customizeBrandPrimaryColor',
      desc: '',
      args: [],
    );
  }

  /// `Background Color`
  String get backgroundColor {
    return Intl.message(
      'Background Color',
      name: 'backgroundColor',
      desc: '',
      args: [],
    );
  }

  /// `Customize the background color of your website`
  String get customizeWebsiteBackground {
    return Intl.message(
      'Customize the background color of your website',
      name: 'customizeWebsiteBackground',
      desc: '',
      args: [],
    );
  }

  /// `Font Style`
  String get fontStyle {
    return Intl.message('Font Style', name: 'fontStyle', desc: '', args: []);
  }

  /// `Customize the font style in your website`
  String get customizeWebsiteFont {
    return Intl.message(
      'Customize the font style in your website',
      name: 'customizeWebsiteFont',
      desc: '',
      args: [],
    );
  }

  /// `Cards Radius`
  String get cardsRadius {
    return Intl.message(
      'Cards Radius',
      name: 'cardsRadius',
      desc: '',
      args: [],
    );
  }

  /// `Customize the radius of your item cards`
  String get customizeCardRadius {
    return Intl.message(
      'Customize the radius of your item cards',
      name: 'customizeCardRadius',
      desc: '',
      args: [],
    );
  }

  /// `Primary Color Preview`
  String get primaryColorPreview {
    return Intl.message(
      'Primary Color Preview',
      name: 'primaryColorPreview',
      desc: '',
      args: [],
    );
  }

  /// `Background Color Preview`
  String get backgroundColorPreview {
    return Intl.message(
      'Background Color Preview',
      name: 'backgroundColorPreview',
      desc: '',
      args: [],
    );
  }

  /// `Card Radius Preview`
  String get cardRadiusPreview {
    return Intl.message(
      'Card Radius Preview',
      name: 'cardRadiusPreview',
      desc: '',
      args: [],
    );
  }

  /// `Font Style Preview`
  String get fontStylePreview {
    return Intl.message(
      'Font Style Preview',
      name: 'fontStylePreview',
      desc: '',
      args: [],
    );
  }

  /// `Preview`
  String get preview {
    return Intl.message('Preview', name: 'preview', desc: '', args: []);
  }

  /// `See how your brand color looks on key elements`
  String get primaryColorPreviewDescription {
    return Intl.message(
      'See how your brand color looks on key elements',
      name: 'primaryColorPreviewDescription',
      desc: '',
      args: [],
    );
  }

  /// `See how your chosen color looks as a page background`
  String get backgroundColorPreviewDescription {
    return Intl.message(
      'See how your chosen color looks as a page background',
      name: 'backgroundColorPreviewDescription',
      desc: '',
      args: [],
    );
  }

  /// `See how your item cards look with the selected settings`
  String get cardRadiusPreviewDescription {
    return Intl.message(
      'See how your item cards look with the selected settings',
      name: 'cardRadiusPreviewDescription',
      desc: '',
      args: [],
    );
  }

  /// `See how the selected font looks on your menu`
  String get fontStylePreviewDescription {
    return Intl.message(
      'See how the selected font looks on your menu',
      name: 'fontStylePreviewDescription',
      desc: '',
      args: [],
    );
  }

  /// `Price tag`
  String get priceTag {
    return Intl.message('Price tag', name: 'priceTag', desc: '', args: []);
  }

  /// `Action button`
  String get actionButton {
    return Intl.message(
      'Action button',
      name: 'actionButton',
      desc: '',
      args: [],
    );
  }

  /// `Pick a Color`
  String get pickAColor {
    return Intl.message('Pick a Color', name: 'pickAColor', desc: '', args: []);
  }

  /// `Choose the primary color for your brand`
  String get choosePrimaryColor {
    return Intl.message(
      'Choose the primary color for your brand',
      name: 'choosePrimaryColor',
      desc: '',
      args: [],
    );
  }

  /// `Order Now`
  String get orderNow {
    return Intl.message('Order Now', name: 'orderNow', desc: '', args: []);
  }

  /// `Choose the background color for your website pages`
  String get chooseBackgroundColor {
    return Intl.message(
      'Choose the background color for your website pages',
      name: 'chooseBackgroundColor',
      desc: '',
      args: [],
    );
  }

  /// `Preview of background color`
  String get previewBackgroundColor {
    return Intl.message(
      'Preview of background color',
      name: 'previewBackgroundColor',
      desc: '',
      args: [],
    );
  }

  /// `Card Radius`
  String get cardRadius {
    return Intl.message('Card Radius', name: 'cardRadius', desc: '', args: []);
  }

  /// `Adjust the corner rounding of item cards`
  String get adjustCardCorners {
    return Intl.message(
      'Adjust the corner rounding of item cards',
      name: 'adjustCardCorners',
      desc: '',
      args: [],
    );
  }

  /// `Card Elevation`
  String get cardElevation {
    return Intl.message(
      'Card Elevation',
      name: 'cardElevation',
      desc: '',
      args: [],
    );
  }

  /// `Control the shadow depth beneath the card`
  String get controlShadowDepth {
    return Intl.message(
      'Control the shadow depth beneath the card',
      name: 'controlShadowDepth',
      desc: '',
      args: [],
    );
  }

  /// `Enable Shadow`
  String get enableShadow {
    return Intl.message(
      'Enable Shadow',
      name: 'enableShadow',
      desc: '',
      args: [],
    );
  }

  /// `Modern`
  String get fontModern {
    return Intl.message('Modern', name: 'fontModern', desc: '', args: []);
  }

  /// `Clean`
  String get fontClean {
    return Intl.message('Clean', name: 'fontClean', desc: '', args: []);
  }

  /// `Elegant`
  String get fontElegant {
    return Intl.message('Elegant', name: 'fontElegant', desc: '', args: []);
  }

  /// `The quick brown fox`
  String get quickBrownFox {
    return Intl.message(
      'The quick brown fox',
      name: 'quickBrownFox',
      desc: '',
      args: [],
    );
  }

  /// `Grilled Salmon — $18.99`
  String get grilledSalmon {
    return Intl.message(
      'Grilled Salmon — \$18.99',
      name: 'grilledSalmon',
      desc: '',
      args: [],
    );
  }

  /// `Fresh Atlantic salmon fillet with lemon butter sauce.`
  String get salmonDescription {
    return Intl.message(
      'Fresh Atlantic salmon fillet with lemon butter sauce.',
      name: 'salmonDescription',
      desc: '',
      args: [],
    );
  }

  /// `Select Font`
  String get selectFont {
    return Intl.message('Select Font', name: 'selectFont', desc: '', args: []);
  }

  /// `Choose the typography that matches your restaurant style`
  String get chooseTypography {
    return Intl.message(
      'Choose the typography that matches your restaurant style',
      name: 'chooseTypography',
      desc: '',
      args: [],
    );
  }

  /// `Current Selection`
  String get currentSelection {
    return Intl.message(
      'Current Selection',
      name: 'currentSelection',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message('Active', name: 'active', desc: '', args: []);
  }

  /// `Completed`
  String get completed {
    return Intl.message('Completed', name: 'completed', desc: '', args: []);
  }

  /// `Error loading banners`
  String get errorLoadingBanners {
    return Intl.message(
      'Error loading banners',
      name: 'errorLoadingBanners',
      desc: '',
      args: [],
    );
  }

  /// `No Banners`
  String get noBanners {
    return Intl.message('No Banners', name: 'noBanners', desc: '', args: []);
  }

  /// `You currently have no banners. Add some to promote your menu items!`
  String get noBannersDescription {
    return Intl.message(
      'You currently have no banners. Add some to promote your menu items!',
      name: 'noBannersDescription',
      desc: '',
      args: [],
    );
  }

  /// `No Active Banners`
  String get noActiveBannersTitle {
    return Intl.message(
      'No Active Banners',
      name: 'noActiveBannersTitle',
      desc: '',
      args: [],
    );
  }

  /// `No active banners`
  String get noActiveBanners {
    return Intl.message(
      'No active banners',
      name: 'noActiveBanners',
      desc: '',
      args: [],
    );
  }

  /// `You currently have no active banners.`
  String get noActiveBannersDescription {
    return Intl.message(
      'You currently have no active banners.',
      name: 'noActiveBannersDescription',
      desc: '',
      args: [],
    );
  }

  /// `No Completed Banners`
  String get noCompletedBanners {
    return Intl.message(
      'No Completed Banners',
      name: 'noCompletedBanners',
      desc: '',
      args: [],
    );
  }

  /// `Banners that have expired will appear here.`
  String get noCompletedBannersDescription {
    return Intl.message(
      'Banners that have expired will appear here.',
      name: 'noCompletedBannersDescription',
      desc: '',
      args: [],
    );
  }

  /// `Banner Added`
  String get bannerAdded {
    return Intl.message(
      'Banner Added',
      name: 'bannerAdded',
      desc: '',
      args: [],
    );
  }

  /// `Your banner has been added successfully.`
  String get bannerAddedDescription {
    return Intl.message(
      'Your banner has been added successfully.',
      name: 'bannerAddedDescription',
      desc: '',
      args: [],
    );
  }

  /// `Banner Updated`
  String get bannerUpdated {
    return Intl.message(
      'Banner Updated',
      name: 'bannerUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Your banner has been updated successfully.`
  String get bannerUpdatedDescription {
    return Intl.message(
      'Your banner has been updated successfully.',
      name: 'bannerUpdatedDescription',
      desc: '',
      args: [],
    );
  }

  /// `Banner Deleted`
  String get bannerDeleted {
    return Intl.message(
      'Banner Deleted',
      name: 'bannerDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Your banner has been deleted successfully.`
  String get bannerDeletedDescription {
    return Intl.message(
      'Your banner has been deleted successfully.',
      name: 'bannerDeletedDescription',
      desc: '',
      args: [],
    );
  }

  /// `Banner Toggled`
  String get bannerToggled {
    return Intl.message(
      'Banner Toggled',
      name: 'bannerToggled',
      desc: '',
      args: [],
    );
  }

  /// `Your banner status has been updated successfully.`
  String get bannerToggledDescription {
    return Intl.message(
      'Your banner status has been updated successfully.',
      name: 'bannerToggledDescription',
      desc: '',
      args: [],
    );
  }

  /// `Add New Banner`
  String get addNewBanner {
    return Intl.message(
      'Add New Banner',
      name: 'addNewBanner',
      desc: '',
      args: [],
    );
  }

  /// `Edit Banner`
  String get editBanner {
    return Intl.message('Edit Banner', name: 'editBanner', desc: '', args: []);
  }

  /// `Upload Banner Image`
  String get uploadBannerImage {
    return Intl.message(
      'Upload Banner Image',
      name: 'uploadBannerImage',
      desc: '',
      args: [],
    );
  }

  /// `Redirect To Item (Optional)`
  String get redirectToItemOptional {
    return Intl.message(
      'Redirect To Item (Optional)',
      name: 'redirectToItemOptional',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load items: {message}`
  String failedToLoadItems(String message) {
    return Intl.message(
      'Failed to load items: $message',
      name: 'failedToLoadItems',
      desc: '',
      args: [message],
    );
  }

  /// `Expiration Date (Optional)`
  String get bannerExpirationDateOptional {
    return Intl.message(
      'Expiration Date (Optional)',
      name: 'bannerExpirationDateOptional',
      desc: '',
      args: [],
    );
  }

  /// `Make banner live now?`
  String get makeBannerLive {
    return Intl.message(
      'Make banner live now?',
      name: 'makeBannerLive',
      desc: '',
      args: [],
    );
  }

  /// `Add Banner`
  String get addBanner {
    return Intl.message('Add Banner', name: 'addBanner', desc: '', args: []);
  }

  /// `Update Banner`
  String get updateBanner {
    return Intl.message(
      'Update Banner',
      name: 'updateBanner',
      desc: '',
      args: [],
    );
  }

  /// `No expiration`
  String get noExpiration {
    return Intl.message(
      'No expiration',
      name: 'noExpiration',
      desc: '',
      args: [],
    );
  }

  /// `Select a menu item`
  String get selectMenuItem {
    return Intl.message(
      'Select a menu item',
      name: 'selectMenuItem',
      desc: '',
      args: [],
    );
  }

  /// `No Redirect`
  String get noRedirect {
    return Intl.message('No Redirect', name: 'noRedirect', desc: '', args: []);
  }

  /// `Updating...`
  String get updating {
    return Intl.message('Updating...', name: 'updating', desc: '', args: []);
  }

  /// `Live`
  String get live {
    return Intl.message('Live', name: 'live', desc: '', args: []);
  }

  /// `Hidden`
  String get hidden {
    return Intl.message('Hidden', name: 'hidden', desc: '', args: []);
  }

  /// `Delete Banner`
  String get deleteBanner {
    return Intl.message(
      'Delete Banner',
      name: 'deleteBanner',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this banner?`
  String get deleteBannerConfirmation {
    return Intl.message(
      'Are you sure you want to delete this banner?',
      name: 'deleteBannerConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `No Redirect Link`
  String get noRedirectLink {
    return Intl.message(
      'No Redirect Link',
      name: 'noRedirectLink',
      desc: '',
      args: [],
    );
  }

  /// `{count} Total Clicks`
  String totalClicks(int count) {
    return Intl.message(
      '$count Total Clicks',
      name: 'totalClicks',
      desc: '',
      args: [count],
    );
  }

  /// `Expires: {date}`
  String expires(String date) {
    return Intl.message(
      'Expires: $date',
      name: 'expires',
      desc: '',
      args: [date],
    );
  }

  /// `Expired`
  String get expired {
    return Intl.message('Expired', name: 'expired', desc: '', args: []);
  }

  /// `Ended: {date}`
  String ended(String date) {
    return Intl.message('Ended: $date', name: 'ended', desc: '', args: [date]);
  }

  /// `Republish Banner`
  String get republishBanner {
    return Intl.message(
      'Republish Banner',
      name: 'republishBanner',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to permanently delete this expired banner?`
  String get deleteExpiredBannerConfirmation {
    return Intl.message(
      'Are you sure you want to permanently delete this expired banner?',
      name: 'deleteExpiredBannerConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `No expiration date`
  String get noExpirationDate {
    return Intl.message(
      'No expiration date',
      name: 'noExpirationDate',
      desc: '',
      args: [],
    );
  }

  /// `{count} Clicks`
  String clicks(int count) {
    return Intl.message(
      '$count Clicks',
      name: 'clicks',
      desc: '',
      args: [count],
    );
  }

  /// `Add New Item`
  String get addNewItem {
    return Intl.message('Add New Item', name: 'addNewItem', desc: '', args: []);
  }

  /// `Edit Item`
  String get editItem {
    return Intl.message('Edit Item', name: 'editItem', desc: '', args: []);
  }

  /// `Item Images`
  String get itemImages {
    return Intl.message('Item Images', name: 'itemImages', desc: '', args: []);
  }

  /// `Upload clear photos to attract customers to this item`
  String get uploadClearPhotos {
    return Intl.message(
      'Upload clear photos to attract customers to this item',
      name: 'uploadClearPhotos',
      desc: '',
      args: [],
    );
  }

  /// `Upload Food Images`
  String get uploadFoodImages {
    return Intl.message(
      'Upload Food Images',
      name: 'uploadFoodImages',
      desc: '',
      args: [],
    );
  }

  /// `Item Details`
  String get itemDetails {
    return Intl.message(
      'Item Details',
      name: 'itemDetails',
      desc: '',
      args: [],
    );
  }

  /// `Fill in the name, price and a short description`
  String get fillItemDetails {
    return Intl.message(
      'Fill in the name, price and a short description',
      name: 'fillItemDetails',
      desc: '',
      args: [],
    );
  }

  /// `Item Name`
  String get itemName {
    return Intl.message('Item Name', name: 'itemName', desc: '', args: []);
  }

  /// `e.g. Chicken Alfredo Pasta`
  String get itemNameHint {
    return Intl.message(
      'e.g. Chicken Alfredo Pasta',
      name: 'itemNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the item name`
  String get enterItemName {
    return Intl.message(
      'Please enter the item name',
      name: 'enterItemName',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message('Price', name: 'price', desc: '', args: []);
  }

  /// `e.g. 12.99`
  String get priceHint {
    return Intl.message('e.g. 12.99', name: 'priceHint', desc: '', args: []);
  }

  /// `Please enter the price`
  String get enterPrice {
    return Intl.message(
      'Please enter the price',
      name: 'enterPrice',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Describe the ingredients, allergens, or preparation...`
  String get descriptionHint {
    return Intl.message(
      'Describe the ingredients, allergens, or preparation...',
      name: 'descriptionHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the description`
  String get enterDescription {
    return Intl.message(
      'Please enter the description',
      name: 'enterDescription',
      desc: '',
      args: [],
    );
  }

  /// `Ingredients (Optional)`
  String get ingredientsOptional {
    return Intl.message(
      'Ingredients (Optional)',
      name: 'ingredientsOptional',
      desc: '',
      args: [],
    );
  }

  /// `List the main ingredients to help customers with dietary preferences or allergies`
  String get ingredientsDescription {
    return Intl.message(
      'List the main ingredients to help customers with dietary preferences or allergies',
      name: 'ingredientsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Add Ingredients`
  String get addIngredients {
    return Intl.message(
      'Add Ingredients',
      name: 'addIngredients',
      desc: '',
      args: [],
    );
  }

  /// `{count} Ingredients`
  String ingredientsCount(Object count) {
    return Intl.message(
      '$count Ingredients',
      name: 'ingredientsCount',
      desc: '',
      args: [count],
    );
  }

  /// `Availability`
  String get availability {
    return Intl.message(
      'Availability',
      name: 'availability',
      desc: '',
      args: [],
    );
  }

  /// `Control whether this item is visible to customers`
  String get itemVisibilityDescription {
    return Intl.message(
      'Control whether this item is visible to customers',
      name: 'itemVisibilityDescription',
      desc: '',
      args: [],
    );
  }

  /// `Save Item`
  String get saveItem {
    return Intl.message('Save Item', name: 'saveItem', desc: '', args: []);
  }

  /// `Add New Offer`
  String get addNewOffer {
    return Intl.message(
      'Add New Offer',
      name: 'addNewOffer',
      desc: '',
      args: [],
    );
  }

  /// `Edit Offer`
  String get editOffer {
    return Intl.message('Edit Offer', name: 'editOffer', desc: '', args: []);
  }

  /// `Upload Offer Image`
  String get uploadOfferImage {
    return Intl.message(
      'Upload Offer Image',
      name: 'uploadOfferImage',
      desc: '',
      args: [],
    );
  }

  /// `Offer Details`
  String get offerDetails {
    return Intl.message(
      'Offer Details',
      name: 'offerDetails',
      desc: '',
      args: [],
    );
  }

  /// `Offer Name`
  String get offerName {
    return Intl.message('Offer Name', name: 'offerName', desc: '', args: []);
  }

  /// `e.g. Big Meal Combo`
  String get offerNameHint {
    return Intl.message(
      'e.g. Big Meal Combo',
      name: 'offerNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the offer name`
  String get enterOfferName {
    return Intl.message(
      'Please enter the offer name',
      name: 'enterOfferName',
      desc: '',
      args: [],
    );
  }

  /// `Offer Items`
  String get offerItems {
    return Intl.message('Offer Items', name: 'offerItems', desc: '', args: []);
  }

  /// `List the items included in the offer`
  String get offerItemsDescription {
    return Intl.message(
      'List the items included in the offer',
      name: 'offerItemsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Add the details customers need to know about this offer`
  String get offerDetailsDescription {
    return Intl.message(
      'Add the details customers need to know about this offer',
      name: 'offerDetailsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Stay informed about interactions with your menu`
  String get menuInteractionsDescription {
    return Intl.message(
      'Stay informed about interactions with your menu',
      name: 'menuInteractionsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Receive notifications when someone scans your QR code`
  String get qrScanNotificationsDescription {
    return Intl.message(
      'Receive notifications when someone scans your QR code',
      name: 'qrScanNotificationsDescription',
      desc: '',
      args: [],
    );
  }

  /// `System & Growth`
  String get systemAndGrowth {
    return Intl.message(
      'System & Growth',
      name: 'systemAndGrowth',
      desc: '',
      args: [],
    );
  }

  /// `Platform updates and performance improvements`
  String get platformUpdatesDescription {
    return Intl.message(
      'Platform updates and performance improvements',
      name: 'platformUpdatesDescription',
      desc: '',
      args: [],
    );
  }

  /// `Default`
  String get defaultLanguage {
    return Intl.message('Default', name: 'defaultLanguage', desc: '', args: []);
  }

  /// `Interactions: {count}`
  String bannerInteractions(Object count) {
    return Intl.message(
      'Interactions: $count',
      name: 'bannerInteractions',
      desc: '',
      args: [count],
    );
  }

  /// `{count} views`
  String itemViewsCount(Object count) {
    return Intl.message(
      '$count views',
      name: 'itemViewsCount',
      desc: '',
      args: [count],
    );
  }

  /// `RestoQR {version}`
  String version(Object version) {
    return Intl.message(
      'RestoQR $version',
      name: 'version',
      desc: '',
      args: [version],
    );
  }

  /// `Please add at least one item`
  String get addAtLeastOneItem {
    return Intl.message(
      'Please add at least one item',
      name: 'addAtLeastOneItem',
      desc: '',
      args: [],
    );
  }

  /// `Add Item`
  String get addItem {
    return Intl.message('Add Item', name: 'addItem', desc: '', args: []);
  }

  /// `{count} Items`
  String itemsCount(Object count) {
    return Intl.message(
      '$count Items',
      name: 'itemsCount',
      desc: '',
      args: [count],
    );
  }

  /// `Save Offer`
  String get saveOffer {
    return Intl.message('Save Offer', name: 'saveOffer', desc: '', args: []);
  }

  /// `Category Image`
  String get categoryImage {
    return Intl.message(
      'Category Image',
      name: 'categoryImage',
      desc: '',
      args: [],
    );
  }

  /// `A high-quality photo helps customers recognise this category`
  String get categoryImageDescription {
    return Intl.message(
      'A high-quality photo helps customers recognise this category',
      name: 'categoryImageDescription',
      desc: '',
      args: [],
    );
  }

  /// `Add Category`
  String get addCategory {
    return Intl.message(
      'Add Category',
      name: 'addCategory',
      desc: '',
      args: [],
    );
  }

  /// `Edit Category`
  String get editCategory {
    return Intl.message(
      'Edit Category',
      name: 'editCategory',
      desc: '',
      args: [],
    );
  }

  /// `Upload Category Image`
  String get uploadCategoryImage {
    return Intl.message(
      'Upload Category Image',
      name: 'uploadCategoryImage',
      desc: '',
      args: [],
    );
  }

  /// `Category Details`
  String get categoryDetails {
    return Intl.message(
      'Category Details',
      name: 'categoryDetails',
      desc: '',
      args: [],
    );
  }

  /// `Keep names short and descriptive, e.g. Pizza, Salads`
  String get categoryDetailsDescription {
    return Intl.message(
      'Keep names short and descriptive, e.g. Pizza, Salads',
      name: 'categoryDetailsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Category Name`
  String get categoryName {
    return Intl.message(
      'Category Name',
      name: 'categoryName',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Pizza, Pasta, etc.`
  String get categoryNameHint {
    return Intl.message(
      'e.g. Pizza, Pasta, etc.',
      name: 'categoryNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a category name`
  String get enterCategoryName {
    return Intl.message(
      'Please enter a category name',
      name: 'enterCategoryName',
      desc: '',
      args: [],
    );
  }

  /// `Display Setting`
  String get displaySetting {
    return Intl.message(
      'Display Setting',
      name: 'displaySetting',
      desc: '',
      args: [],
    );
  }

  /// `Control whether this category is visible to customers`
  String get categoryVisibilityDescription {
    return Intl.message(
      'Control whether this category is visible to customers',
      name: 'categoryVisibilityDescription',
      desc: '',
      args: [],
    );
  }

  /// `Categories help customers navigate your menu. We recommend keeping category names short and using high-quality photos.`
  String get categoryInfo {
    return Intl.message(
      'Categories help customers navigate your menu. We recommend keeping category names short and using high-quality photos.',
      name: 'categoryInfo',
      desc: '',
      args: [],
    );
  }

  /// `Save Category`
  String get saveCategory {
    return Intl.message(
      'Save Category',
      name: 'saveCategory',
      desc: '',
      args: [],
    );
  }

  /// `My Menu`
  String get myMenu {
    return Intl.message('My Menu', name: 'myMenu', desc: '', args: []);
  }

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `Manage your menu categories and their items`
  String get menuCategoriesDescription {
    return Intl.message(
      'Manage your menu categories and their items',
      name: 'menuCategoriesDescription',
      desc: '',
      args: [],
    );
  }

  /// `No categories yet`
  String get noCategoriesYet {
    return Intl.message(
      'No categories yet',
      name: 'noCategoriesYet',
      desc: '',
      args: [],
    );
  }

  /// `Add categories to build your menu and organize your items`
  String get addCategoriesDescription {
    return Intl.message(
      'Add categories to build your menu and organize your items',
      name: 'addCategoriesDescription',
      desc: '',
      args: [],
    );
  }

  /// `Offers`
  String get offers {
    return Intl.message('Offers', name: 'offers', desc: '', args: []);
  }

  /// `Tap an Offer to view details or make changes`
  String get offerInstructions {
    return Intl.message(
      'Tap an Offer to view details or make changes',
      name: 'offerInstructions',
      desc: '',
      args: [],
    );
  }

  /// `No offers yet`
  String get noOffersYet {
    return Intl.message(
      'No offers yet',
      name: 'noOffersYet',
      desc: '',
      args: [],
    );
  }

  /// `Add offers to your menu and promote them to your customers`
  String get addOffersDescription {
    return Intl.message(
      'Add offers to your menu and promote them to your customers',
      name: 'addOffersDescription',
      desc: '',
      args: [],
    );
  }

  /// `Items`
  String get items {
    return Intl.message('Items', name: 'items', desc: '', args: []);
  }

  /// `Category Items`
  String get categoryItems {
    return Intl.message(
      'Category Items',
      name: 'categoryItems',
      desc: '',
      args: [],
    );
  }

  /// `Tap an item to view details or make changes`
  String get itemInstructions {
    return Intl.message(
      'Tap an item to view details or make changes',
      name: 'itemInstructions',
      desc: '',
      args: [],
    );
  }

  /// `No Items`
  String get noItems {
    return Intl.message('No Items', name: 'noItems', desc: '', args: []);
  }

  /// `No items found in this category`
  String get noItemsInCategory {
    return Intl.message(
      'No items found in this category',
      name: 'noItemsInCategory',
      desc: '',
      args: [],
    );
  }

  /// `Item Added`
  String get itemAdded {
    return Intl.message('Item Added', name: 'itemAdded', desc: '', args: []);
  }

  /// `The item has been added successfully to your menu.`
  String get itemAddedDescription {
    return Intl.message(
      'The item has been added successfully to your menu.',
      name: 'itemAddedDescription',
      desc: '',
      args: [],
    );
  }

  /// `Item Updated`
  String get itemUpdated {
    return Intl.message(
      'Item Updated',
      name: 'itemUpdated',
      desc: '',
      args: [],
    );
  }

  /// `The item has been updated successfully on your menu.`
  String get itemUpdatedDescription {
    return Intl.message(
      'The item has been updated successfully on your menu.',
      name: 'itemUpdatedDescription',
      desc: '',
      args: [],
    );
  }

  /// `Item Deleted`
  String get itemDeleted {
    return Intl.message(
      'Item Deleted',
      name: 'itemDeleted',
      desc: '',
      args: [],
    );
  }

  /// `The item has been deleted successfully from your menu.`
  String get itemDeletedDescription {
    return Intl.message(
      'The item has been deleted successfully from your menu.',
      name: 'itemDeletedDescription',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message('Success', name: 'success', desc: '', args: []);
  }

  /// `Offer deleted successfully`
  String get offerDeletedDescription {
    return Intl.message(
      'Offer deleted successfully',
      name: 'offerDeletedDescription',
      desc: '',
      args: [],
    );
  }

  /// `Offer added successfully`
  String get offerAddedDescription {
    return Intl.message(
      'Offer added successfully',
      name: 'offerAddedDescription',
      desc: '',
      args: [],
    );
  }

  /// `Offer updated successfully`
  String get offerUpdatedDescription {
    return Intl.message(
      'Offer updated successfully',
      name: 'offerUpdatedDescription',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load top items`
  String get errorLoadingTopItems {
    return Intl.message(
      'Failed to load top items',
      name: 'errorLoadingTopItems',
      desc: '',
      args: [],
    );
  }

  /// `No items found`
  String get noItemsFound {
    return Intl.message(
      'No items found',
      name: 'noItemsFound',
      desc: '',
      args: [],
    );
  }

  /// `Active Banners`
  String get activeBanners {
    return Intl.message(
      'Active Banners',
      name: 'activeBanners',
      desc: '',
      args: [],
    );
  }

  /// `Performance of your live promotional banners`
  String get activeBannersDescription {
    return Intl.message(
      'Performance of your live promotional banners',
      name: 'activeBannersDescription',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load banners`
  String get failedToLoadBanners {
    return Intl.message(
      'Failed to load banners',
      name: 'failedToLoadBanners',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message('Today', name: 'today', desc: '', args: []);
  }

  /// `This week`
  String get thisWeek {
    return Intl.message('This week', name: 'thisWeek', desc: '', args: []);
  }

  /// `This month`
  String get thisMonth {
    return Intl.message('This month', name: 'thisMonth', desc: '', args: []);
  }

  /// `Total Menu Views`
  String get totalMenuViews {
    return Intl.message(
      'Total Menu Views',
      name: 'totalMenuViews',
      desc: '',
      args: [],
    );
  }

  /// `Total Menu Visits`
  String get totalMenuVisits {
    return Intl.message(
      'Total Menu Visits',
      name: 'totalMenuVisits',
      desc: '',
      args: [],
    );
  }

  /// `QR Code`
  String get qrCode {
    return Intl.message('QR Code', name: 'qrCode', desc: '', args: []);
  }

  /// `Scanning this leads customers directly to your restaurant's digital menu`
  String get qrCodeInfo {
    return Intl.message(
      'Scanning this leads customers directly to your restaurant\'s digital menu',
      name: 'qrCodeInfo',
      desc: '',
      args: [],
    );
  }

  /// `Actions`
  String get actions {
    return Intl.message('Actions', name: 'actions', desc: '', args: []);
  }

  /// `Share or save your QR code to promote your menu`
  String get qrCodeActionsDescription {
    return Intl.message(
      'Share or save your QR code to promote your menu',
      name: 'qrCodeActionsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message('Share', name: 'share', desc: '', args: []);
  }

  /// `Print`
  String get print {
    return Intl.message('Print', name: 'print', desc: '', args: []);
  }

  /// `Save to Gallery`
  String get saveToGallery {
    return Intl.message(
      'Save to Gallery',
      name: 'saveToGallery',
      desc: '',
      args: [],
    );
  }

  /// `Your QR code image has been saved to your device's gallery.`
  String get savedToGalleryDescription {
    return Intl.message(
      'Your QR code image has been saved to your device\'s gallery.',
      name: 'savedToGalleryDescription',
      desc: '',
      args: [],
    );
  }

  /// `Print Failed`
  String get printFailed {
    return Intl.message(
      'Print Failed',
      name: 'printFailed',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Notification Settings`
  String get notificationSettings {
    return Intl.message(
      'Notification Settings',
      name: 'notificationSettings',
      desc: '',
      args: [],
    );
  }

  /// `Changes made here only affect this device's notifications.`
  String get notificationSettingsDescription {
    return Intl.message(
      'Changes made here only affect this device\'s notifications.',
      name: 'notificationSettingsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Profile Settings`
  String get profileSettings {
    return Intl.message(
      'Profile Settings',
      name: 'profileSettings',
      desc: '',
      args: [],
    );
  }

  /// `Update Logo`
  String get updateLogo {
    return Intl.message('Update Logo', name: 'updateLogo', desc: '', args: []);
  }

  /// `Tap the pencil icon to update your logo`
  String get updateLogoDescription {
    return Intl.message(
      'Tap the pencil icon to update your logo',
      name: 'updateLogoDescription',
      desc: '',
      args: [],
    );
  }

  /// `Business Details`
  String get businessDetails {
    return Intl.message(
      'Business Details',
      name: 'businessDetails',
      desc: '',
      args: [],
    );
  }

  /// `Update your restaurant information`
  String get businessDetailsDescription {
    return Intl.message(
      'Update your restaurant information',
      name: 'businessDetailsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
  }

  /// `Enter your username`
  String get usernameHint {
    return Intl.message(
      'Enter your username',
      name: 'usernameHint',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message('Dark Mode', name: 'darkMode', desc: '', args: []);
  }

  /// `Enable dark theme for better visuals`
  String get darkModeDescription {
    return Intl.message(
      'Enable dark theme for better visuals',
      name: 'darkModeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Visible to Customers`
  String get visibleToCustomers {
    return Intl.message(
      'Visible to Customers',
      name: 'visibleToCustomers',
      desc: '',
      args: [],
    );
  }

  /// `Immediately publish to your digital menu`
  String get visibleToCustomersDescription {
    return Intl.message(
      'Immediately publish to your digital menu',
      name: 'visibleToCustomersDescription',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Add Ingredient`
  String get addIngredient {
    return Intl.message(
      'Add Ingredient',
      name: 'addIngredient',
      desc: '',
      args: [],
    );
  }

  /// `Tip: Leave a field empty to skip it.`
  String get ingredientsTip {
    return Intl.message(
      'Tip: Leave a field empty to skip it.',
      name: 'ingredientsTip',
      desc: '',
      args: [],
    );
  }

  /// `One ingredient per line for clean menus.`
  String get ingredientPerLine {
    return Intl.message(
      'One ingredient per line for clean menus.',
      name: 'ingredientPerLine',
      desc: '',
      args: [],
    );
  }

  /// `{count} items`
  String ingredientCount(Object count) {
    return Intl.message(
      '$count items',
      name: 'ingredientCount',
      desc: '',
      args: [count],
    );
  }

  /// `Ingredient {index}`
  String ingredientLabel(Object index) {
    return Intl.message(
      'Ingredient $index',
      name: 'ingredientLabel',
      desc: '',
      args: [index],
    );
  }

  /// `e.g. Chicken, Rice, Vegetables`
  String get ingredientHint {
    return Intl.message(
      'e.g. Chicken, Rice, Vegetables',
      name: 'ingredientHint',
      desc: '',
      args: [],
    );
  }

  /// `Add Items`
  String get addItems {
    return Intl.message('Add Items', name: 'addItems', desc: '', args: []);
  }

  /// `Select the Items of this offer`
  String get selectOfferItems {
    return Intl.message(
      'Select the Items of this offer',
      name: 'selectOfferItems',
      desc: '',
      args: [],
    );
  }

  /// `No items available to add to this offer.`
  String get noItemsAvailable {
    return Intl.message(
      'No items available to add to this offer.',
      name: 'noItemsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Share URL`
  String get shareUrl {
    return Intl.message('Share URL', name: 'shareUrl', desc: '', args: []);
  }

  /// `Share QR Code Image`
  String get shareQrCodeImage {
    return Intl.message(
      'Share QR Code Image',
      name: 'shareQrCodeImage',
      desc: '',
      args: [],
    );
  }

  /// `Item Visible to Customers`
  String get itemVisibleToCustomers {
    return Intl.message(
      'Item Visible to Customers',
      name: 'itemVisibleToCustomers',
      desc: '',
      args: [],
    );
  }

  /// `Manage Offer`
  String get manageOffer {
    return Intl.message(
      'Manage Offer',
      name: 'manageOffer',
      desc: '',
      args: [],
    );
  }

  /// `Delete Offer`
  String get deleteOffer {
    return Intl.message(
      'Delete Offer',
      name: 'deleteOffer',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this offer? \nThis action cannot be undone.`
  String get deleteOfferConfirmation {
    return Intl.message(
      'Are you sure you want to delete this offer? \nThis action cannot be undone.',
      name: 'deleteOfferConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Apply Discount`
  String get applyDiscount {
    return Intl.message(
      'Apply Discount',
      name: 'applyDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Update Discount`
  String get updateDiscount {
    return Intl.message(
      'Update Discount',
      name: 'updateDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Current Price: {price}`
  String currentPrice(Object price) {
    return Intl.message(
      'Current Price: $price',
      name: 'currentPrice',
      desc: '',
      args: [price],
    );
  }

  /// `Discount Percentage: {value}%`
  String discountPercentage(Object value) {
    return Intl.message(
      'Discount Percentage: $value%',
      name: 'discountPercentage',
      desc: '',
      args: [value],
    );
  }

  /// `Discounted Price`
  String get discountedPrice {
    return Intl.message(
      'Discounted Price',
      name: 'discountedPrice',
      desc: '',
      args: [],
    );
  }

  /// `Enter new price (e.g. 19.99)`
  String get discountedPriceHint {
    return Intl.message(
      'Enter new price (e.g. 19.99)',
      name: 'discountedPriceHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a discounted price`
  String get enterDiscountedPrice {
    return Intl.message(
      'Please enter a discounted price',
      name: 'enterDiscountedPrice',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a different price`
  String get differentPrice {
    return Intl.message(
      'Please enter a different price',
      name: 'differentPrice',
      desc: '',
      args: [],
    );
  }

  /// `Discounted price must be less than original price`
  String get discountLessThanOriginal {
    return Intl.message(
      'Discounted price must be less than original price',
      name: 'discountLessThanOriginal',
      desc: '',
      args: [],
    );
  }

  /// `Expiration Date & Time (Optional)`
  String get expirationDateOptional {
    return Intl.message(
      'Expiration Date & Time (Optional)',
      name: 'expirationDateOptional',
      desc: '',
      args: [],
    );
  }

  /// `Select date and time`
  String get selectDateTime {
    return Intl.message(
      'Select date and time',
      name: 'selectDateTime',
      desc: '',
      args: [],
    );
  }

  /// `Remove Discount`
  String get removeDiscount {
    return Intl.message(
      'Remove Discount',
      name: 'removeDiscount',
      desc: '',
      args: [],
    );
  }

  /// `No Discount`
  String get noDiscount {
    return Intl.message('No Discount', name: 'noDiscount', desc: '', args: []);
  }

  /// `RestoQR Loading...`
  String get versionLoading {
    return Intl.message(
      'RestoQR Loading...',
      name: 'versionLoading',
      desc: '',
      args: [],
    );
  }

  /// `Top Items`
  String get topItems {
    return Intl.message('Top Items', name: 'topItems', desc: '', args: []);
  }

  /// `Most viewed items across your menu this week`
  String get topItemsDescription {
    return Intl.message(
      'Most viewed items across your menu this week',
      name: 'topItemsDescription',
      desc: '',
      args: [],
    );
  }

  /// `This week`
  String get weekly {
    return Intl.message('This week', name: 'weekly', desc: '', args: []);
  }

  /// `Profile Details`
  String get profileDetails {
    return Intl.message(
      'Profile Details',
      name: 'profileDetails',
      desc: '',
      args: [],
    );
  }

  /// `View and edit your profile information`
  String get profileDetailsDescription {
    return Intl.message(
      'View and edit your profile information',
      name: 'profileDetailsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Manage notification preferences`
  String get manageNotificationPreferences {
    return Intl.message(
      'Manage notification preferences',
      name: 'manageNotificationPreferences',
      desc: '',
      args: [],
    );
  }

  /// `Item Views`
  String get itemViews {
    return Intl.message('Item Views', name: 'itemViews', desc: '', args: []);
  }

  /// `Promo Clicks`
  String get promoClicks {
    return Intl.message(
      'Promo Clicks',
      name: 'promoClicks',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get saveChanges {
    return Intl.message(
      'Save Changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Start Date`
  String get startDate {
    return Intl.message('Start Date', name: 'startDate', desc: '', args: []);
  }

  /// `End Date`
  String get endDate {
    return Intl.message('End Date', name: 'endDate', desc: '', args: []);
  }

  /// `Category Added`
  String get categoryAdded {
    return Intl.message(
      'Category Added',
      name: 'categoryAdded',
      desc: '',
      args: [],
    );
  }

  /// `Category Added to your menu`
  String get categoryAddedDescription {
    return Intl.message(
      'Category Added to your menu',
      name: 'categoryAddedDescription',
      desc: '',
      args: [],
    );
  }

  /// `Category Updated`
  String get categoryUpdated {
    return Intl.message(
      'Category Updated',
      name: 'categoryUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Category Updated in your menu`
  String get categoryUpdatedDescription {
    return Intl.message(
      'Category Updated in your menu',
      name: 'categoryUpdatedDescription',
      desc: '',
      args: [],
    );
  }

  /// `Category Deleted`
  String get categoryDeleted {
    return Intl.message(
      'Category Deleted',
      name: 'categoryDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Category Deleted from your menu`
  String get categoryDeletedDescription {
    return Intl.message(
      'Category Deleted from your menu',
      name: 'categoryDeletedDescription',
      desc: '',
      args: [],
    );
  }

  /// `Category Toggled`
  String get categoryToggled {
    return Intl.message(
      'Category Toggled',
      name: 'categoryToggled',
      desc: '',
      args: [],
    );
  }

  /// `Category Failed`
  String get categoryFailed {
    return Intl.message(
      'Category Failed',
      name: 'categoryFailed',
      desc: '',
      args: [],
    );
  }

  /// `Activity Notifications`
  String get activityNotifications {
    return Intl.message(
      'Activity Notifications',
      name: 'activityNotifications',
      desc: '',
      args: [],
    );
  }

  /// `New Menu Visits`
  String get newMenuVisits {
    return Intl.message(
      'New Menu Visits',
      name: 'newMenuVisits',
      desc: '',
      args: [],
    );
  }

  /// `System Updates`
  String get systemUpdates {
    return Intl.message(
      'System Updates',
      name: 'systemUpdates',
      desc: '',
      args: [],
    );
  }

  /// `Security and platform updates`
  String get securityPlatformUpdates {
    return Intl.message(
      'Security and platform updates',
      name: 'securityPlatformUpdates',
      desc: '',
      args: [],
    );
  }

  /// `Share Failed`
  String get shareFailed {
    return Intl.message(
      'Share Failed',
      name: 'shareFailed',
      desc: '',
      args: [],
    );
  }

  /// `Enter your restaurant name`
  String get restaurantNameHint {
    return Intl.message(
      'Enter your restaurant name',
      name: 'restaurantNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Business Email`
  String get businessEmail {
    return Intl.message(
      'Business Email',
      name: 'businessEmail',
      desc: '',
      args: [],
    );
  }

  /// `Profile Updated`
  String get profileUpdated {
    return Intl.message(
      'Profile Updated',
      name: 'profileUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Your profile information has been updated successfully.`
  String get profileUpdatedDescription {
    return Intl.message(
      'Your profile information has been updated successfully.',
      name: 'profileUpdatedDescription',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to sign out?`
  String get signOutConfirmation {
    return Intl.message(
      'Are you sure you want to sign out?',
      name: 'signOutConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to remove the discount from this item?`
  String get removeDiscountConfirmation {
    return Intl.message(
      'Are you sure you want to remove the discount from this item?',
      name: 'removeDiscountConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Edit Item Details`
  String get editItemDetails {
    return Intl.message(
      'Edit Item Details',
      name: 'editItemDetails',
      desc: '',
      args: [],
    );
  }

  /// `Delete Item`
  String get deleteItem {
    return Intl.message('Delete Item', name: 'deleteItem', desc: '', args: []);
  }

  /// `Delete Offer`
  String get deleteOfferConfirmationTitle {
    return Intl.message(
      'Delete Offer',
      name: 'deleteOfferConfirmationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Edit Offer`
  String get editOfferTitle {
    return Intl.message(
      'Edit Offer',
      name: 'editOfferTitle',
      desc: '',
      args: [],
    );
  }

  /// `Remove Discount`
  String get removeDiscountTitle {
    return Intl.message(
      'Remove Discount',
      name: 'removeDiscountTitle',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Website`
  String get website {
    return Intl.message('Website', name: 'website', desc: '', args: []);
  }

  /// `Welcome Back`
  String get welcomeBackHome {
    return Intl.message(
      'Welcome Back',
      name: 'welcomeBackHome',
      desc: '',
      args: [],
    );
  }

  /// `Account Settings`
  String get accountSettings {
    return Intl.message(
      'Account Settings',
      name: 'accountSettings',
      desc: '',
      args: [],
    );
  }

  /// `Manage your profile, notifications and preferences`
  String get accountSettingsDescription {
    return Intl.message(
      'Manage your profile, notifications and preferences',
      name: 'accountSettingsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Top Categories`
  String get topCategories {
    return Intl.message(
      'Top Categories',
      name: 'topCategories',
      desc: '',
      args: [],
    );
  }

  /// `Overview of your menu categories`
  String get topCategoriesDescription {
    return Intl.message(
      'Overview of your menu categories',
      name: 'topCategoriesDescription',
      desc: '',
      args: [],
    );
  }

  /// `No categories found`
  String get noCategoriesFound {
    return Intl.message(
      'No categories found',
      name: 'noCategoriesFound',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load categories`
  String get failedToLoadCategories {
    return Intl.message(
      'Failed to load categories',
      name: 'failedToLoadCategories',
      desc: '',
      args: [],
    );
  }

  /// `Show All`
  String get showAll {
    return Intl.message('Show All', name: 'showAll', desc: '', args: []);
  }

  /// `Leaderboard`
  String get leaderboard {
    return Intl.message('Leaderboard', name: 'leaderboard', desc: '', args: []);
  }

  /// `Items ranked by total views across your menu`
  String get leaderboardDescription {
    return Intl.message(
      'Items ranked by total views across your menu',
      name: 'leaderboardDescription',
      desc: '',
      args: [],
    );
  }

  /// `There are no items to display.`
  String get noItemsToDisplay {
    return Intl.message(
      'There are no items to display.',
      name: 'noItemsToDisplay',
      desc: '',
      args: [],
    );
  }

  /// `Manage Item`
  String get manageItem {
    return Intl.message('Manage Item', name: 'manageItem', desc: '', args: []);
  }

  /// `Sign Out`
  String get signOut {
    return Intl.message('Sign Out', name: 'signOut', desc: '', args: []);
  }

  /// `Offer activated successfully`
  String get offerActivatedDescription {
    return Intl.message(
      'Offer activated successfully',
      name: 'offerActivatedDescription',
      desc: '',
      args: [],
    );
  }

  /// `Offer deactivated successfully`
  String get offerDeactivatedDescription {
    return Intl.message(
      'Offer deactivated successfully',
      name: 'offerDeactivatedDescription',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while trying to print the QR code. Please try again.`
  String get qrPrintErrorDescription {
    return Intl.message(
      'An error occurred while trying to print the QR code. Please try again.',
      name: 'qrPrintErrorDescription',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while trying to share the QR code URL. Please try again.`
  String get qrShareErrorDescription {
    return Intl.message(
      'An error occurred while trying to share the QR code URL. Please try again.',
      name: 'qrShareErrorDescription',
      desc: '',
      args: [],
    );
  }

  /// `Menu URL copied to clipboard`
  String get menuUrlCopied {
    return Intl.message(
      'Menu URL copied to clipboard',
      name: 'menuUrlCopied',
      desc: '',
      args: [],
    );
  }

  /// `Authentication Error`
  String get authenticationError {
    return Intl.message(
      'Authentication Error',
      name: 'authenticationError',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect email or password. Please try again.`
  String get incorrectCredentials {
    return Intl.message(
      'Incorrect email or password. Please try again.',
      name: 'incorrectCredentials',
      desc: '',
      args: [],
    );
  }

  /// `No account found with this email.`
  String get accountNotFound {
    return Intl.message(
      'No account found with this email.',
      name: 'accountNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Please verify your email address before logging in.`
  String get emailNotConfirmed {
    return Intl.message(
      'Please verify your email address before logging in.',
      name: 'emailNotConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `Your password must be at least 6 characters long.`
  String get passwordTooShort {
    return Intl.message(
      'Your password must be at least 6 characters long.',
      name: 'passwordTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet connection.`
  String get checkInternetConnection {
    return Intl.message(
      'Please check your internet connection.',
      name: 'checkInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `An account with this email already exists.`
  String get emailAlreadyRegistered {
    return Intl.message(
      'An account with this email already exists.',
      name: 'emailAlreadyRegistered',
      desc: '',
      args: [],
    );
  }

  /// `We could not sign you in. Please try again later.`
  String get signInFailed {
    return Intl.message(
      'We could not sign you in. Please try again later.',
      name: 'signInFailed',
      desc: '',
      args: [],
    );
  }

  /// `Data Error`
  String get dataError {
    return Intl.message('Data Error', name: 'dataError', desc: '', args: []);
  }

  /// `This record already exists. Please use a different one.`
  String get recordAlreadyExists {
    return Intl.message(
      'This record already exists. Please use a different one.',
      name: 'recordAlreadyExists',
      desc: '',
      args: [],
    );
  }

  /// `Operation failed because it relies on missing data.`
  String get missingRelatedData {
    return Intl.message(
      'Operation failed because it relies on missing data.',
      name: 'missingRelatedData',
      desc: '',
      args: [],
    );
  }

  /// `You do not have permission to perform this action.`
  String get permissionDenied {
    return Intl.message(
      'You do not have permission to perform this action.',
      name: 'permissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `The server took too long to respond. Please try again.`
  String get serverTimeout {
    return Intl.message(
      'The server took too long to respond. Please try again.',
      name: 'serverTimeout',
      desc: '',
      args: [],
    );
  }

  /// `We encountered a problem saving your data.`
  String get saveDataFailed {
    return Intl.message(
      'We encountered a problem saving your data.',
      name: 'saveDataFailed',
      desc: '',
      args: [],
    );
  }

  /// `Procedure Error`
  String get procedureError {
    return Intl.message(
      'Procedure Error',
      name: 'procedureError',
      desc: '',
      args: [],
    );
  }

  /// `You do not have enough funds to complete this action.`
  String get insufficientFunds {
    return Intl.message(
      'You do not have enough funds to complete this action.',
      name: 'insufficientFunds',
      desc: '',
      args: [],
    );
  }

  /// `The operation cannot proceed due to an invalid state.`
  String get invalidOperationState {
    return Intl.message(
      'The operation cannot proceed due to an invalid state.',
      name: 'invalidOperationState',
      desc: '',
      args: [],
    );
  }

  /// `The requested server function could not be found.`
  String get serverFunctionNotFound {
    return Intl.message(
      'The requested server function could not be found.',
      name: 'serverFunctionNotFound',
      desc: '',
      args: [],
    );
  }

  /// `You lack the necessary permissions to run this procedure.`
  String get procedurePermissionDenied {
    return Intl.message(
      'You lack the necessary permissions to run this procedure.',
      name: 'procedurePermissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `The background process took too long. Please try again.`
  String get backgroundProcessTimeout {
    return Intl.message(
      'The background process took too long. Please try again.',
      name: 'backgroundProcessTimeout',
      desc: '',
      args: [],
    );
  }

  /// `We encountered a problem while executing the requested procedure.`
  String get procedureExecutionFailed {
    return Intl.message(
      'We encountered a problem while executing the requested procedure.',
      name: 'procedureExecutionFailed',
      desc: '',
      args: [],
    );
  }

  /// `Upload Error`
  String get uploadError {
    return Intl.message(
      'Upload Error',
      name: 'uploadError',
      desc: '',
      args: [],
    );
  }

  /// `The requested file could not be found.`
  String get fileNotFound {
    return Intl.message(
      'The requested file could not be found.',
      name: 'fileNotFound',
      desc: '',
      args: [],
    );
  }

  /// `The file is too large. Please upload a smaller file.`
  String get fileTooLarge {
    return Intl.message(
      'The file is too large. Please upload a smaller file.',
      name: 'fileTooLarge',
      desc: '',
      args: [],
    );
  }

  /// `This file format is not supported.`
  String get unsupportedFileFormat {
    return Intl.message(
      'This file format is not supported.',
      name: 'unsupportedFileFormat',
      desc: '',
      args: [],
    );
  }

  /// `Failed to upload the file. Please check your connection.`
  String get fileUploadFailed {
    return Intl.message(
      'Failed to upload the file. Please check your connection.',
      name: 'fileUploadFailed',
      desc: '',
      args: [],
    );
  }

  /// `System Error`
  String get systemError {
    return Intl.message(
      'System Error',
      name: 'systemError',
      desc: '',
      args: [],
    );
  }

  /// `The service you are looking for is currently unavailable.`
  String get serviceUnavailable {
    return Intl.message(
      'The service you are looking for is currently unavailable.',
      name: 'serviceUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `The operation timed out. Please try again.`
  String get operationTimeout {
    return Intl.message(
      'The operation timed out. Please try again.',
      name: 'operationTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Our servers are having trouble right now. We are working on it.`
  String get serverTrouble {
    return Intl.message(
      'Our servers are having trouble right now. We are working on it.',
      name: 'serverTrouble',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong while processing your request.`
  String get requestProcessingFailed {
    return Intl.message(
      'Something went wrong while processing your request.',
      name: 'requestProcessingFailed',
      desc: '',
      args: [],
    );
  }

  /// `Connection Error`
  String get connectionError {
    return Intl.message(
      'Connection Error',
      name: 'connectionError',
      desc: '',
      args: [],
    );
  }

  /// `We cannot reach the server. Please check your internet connection and try again.`
  String get serverUnreachable {
    return Intl.message(
      'We cannot reach the server. Please check your internet connection and try again.',
      name: 'serverUnreachable',
      desc: '',
      args: [],
    );
  }

  /// `Request Timed Out`
  String get requestTimedOut {
    return Intl.message(
      'Request Timed Out',
      name: 'requestTimedOut',
      desc: '',
      args: [],
    );
  }

  /// `The operation took too long to complete. Please check your connection speed or try again later.`
  String get requestTooSlow {
    return Intl.message(
      'The operation took too long to complete. Please check your connection speed or try again later.',
      name: 'requestTooSlow',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected Error`
  String get unexpectedError {
    return Intl.message(
      'Unexpected Error',
      name: 'unexpectedError',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred. Please try again later.`
  String get unexpectedErrorDescription {
    return Intl.message(
      'An unexpected error occurred. Please try again later.',
      name: 'unexpectedErrorDescription',
      desc: '',
      args: [],
    );
  }

  /// `Preferred Language`
  String get preferedLanguage {
    return Intl.message(
      'Preferred Language',
      name: 'preferedLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Choose the preferred language for your app experience`
  String get preferedLanguageDescription {
    return Intl.message(
      'Choose the preferred language for your app experience',
      name: 'preferedLanguageDescription',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Select Date and Time`
  String get SelectDateAndTime {
    return Intl.message(
      'Select Date and Time',
      name: 'SelectDateAndTime',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this item? \nThis action cannot be undone.`
  String get deleteItemConfirmation {
    return Intl.message(
      'Are you sure you want to delete this item? \nThis action cannot be undone.',
      name: 'deleteItemConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `You will need to log in again to access your dashboard.`
  String get signoutDescription {
    return Intl.message(
      'You will need to log in again to access your dashboard.',
      name: 'signoutDescription',
      desc: '',
      args: [],
    );
  }

  /// `Limited Time Offer (Optional)`
  String get limitedTimeOffer {
    return Intl.message(
      'Limited Time Offer (Optional)',
      name: 'limitedTimeOffer',
      desc: '',
      args: [],
    );
  }

  /// `Set a start and end date for this offer`
  String get setDateTimeForOffer {
    return Intl.message(
      'Set a start and end date for this offer',
      name: 'setDateTimeForOffer',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
