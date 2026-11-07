// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ja';

  static String m0(count) => "反応：${count}";

  static String m1(count) => "${count} 回のクリック";

  static String m2(price) => "現在の価格：${price}";

  static String m3(value) => "割引率：${value}%";

  static String m4(date) => "終了：${date}";

  static String m5(date) => "有効期限：${date}";

  static String m6(message) => "商品の読み込みに失敗しました：${message}";

  static String m7(count) => "${count} 個";

  static String m8(index) => "材料 ${index}";

  static String m9(count) => "${count} 個の材料";

  static String m10(count) => "${count} 回の閲覧";

  static String m11(count) => "${count} 個の商品";

  static String m12(count) => "合計 ${count} 回のクリック";

  static String m13(version) => "RestoQR ${version}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "SelectDateAndTime": MessageLookupByLibrary.simpleMessage("日付と時刻を選択"),
    "account": MessageLookupByLibrary.simpleMessage("アカウント"),
    "accountCreated": MessageLookupByLibrary.simpleMessage("アカウントを作成しました！"),
    "accountCreatedDescription": MessageLookupByLibrary.simpleMessage(
      "ようこそ！レストランのデジタルメニューを作成・管理する準備が整いました。",
    ),
    "accountInfo": MessageLookupByLibrary.simpleMessage("アカウント情報"),
    "accountNotFound": MessageLookupByLibrary.simpleMessage(
      "このメールアドレスのアカウントが見つかりません。",
    ),
    "accountSettings": MessageLookupByLibrary.simpleMessage("アカウント設定"),
    "accountSettingsDescription": MessageLookupByLibrary.simpleMessage(
      "プロフィール、通知、設定を管理",
    ),
    "actionButton": MessageLookupByLibrary.simpleMessage("アクションボタン"),
    "actions": MessageLookupByLibrary.simpleMessage("アクション"),
    "active": MessageLookupByLibrary.simpleMessage("有効"),
    "activeBanners": MessageLookupByLibrary.simpleMessage("有効なバナー"),
    "activeBannersDescription": MessageLookupByLibrary.simpleMessage(
      "公開中のプロモーションバナーのパフォーマンス",
    ),
    "activityNotifications": MessageLookupByLibrary.simpleMessage("アクティビティ通知"),
    "addAtLeastOneItem": MessageLookupByLibrary.simpleMessage(
      "少なくとも1つの商品を追加してください",
    ),
    "addBanner": MessageLookupByLibrary.simpleMessage("バナーを追加"),
    "addCategoriesDescription": MessageLookupByLibrary.simpleMessage(
      "カテゴリーを追加してメニューを作成し、商品を整理しましょう",
    ),
    "addCategory": MessageLookupByLibrary.simpleMessage("カテゴリーを追加"),
    "addIngredient": MessageLookupByLibrary.simpleMessage("材料を追加"),
    "addIngredients": MessageLookupByLibrary.simpleMessage("材料を追加"),
    "addItem": MessageLookupByLibrary.simpleMessage("商品を追加"),
    "addItems": MessageLookupByLibrary.simpleMessage("商品を追加"),
    "addNewBanner": MessageLookupByLibrary.simpleMessage("新しいバナーを追加"),
    "addNewItem": MessageLookupByLibrary.simpleMessage("新しい商品を追加"),
    "addNewOffer": MessageLookupByLibrary.simpleMessage("新しいオファーを追加"),
    "addOffersDescription": MessageLookupByLibrary.simpleMessage(
      "オファーをメニューに追加してお客様に宣伝しましょう",
    ),
    "addRestaurantDescription": MessageLookupByLibrary.simpleMessage(
      "レストランについて簡単な説明を追加してください",
    ),
    "addRestaurantDetails": MessageLookupByLibrary.simpleMessage(
      "お客様がレストランを見つけられるよう、店舗情報を追加してください。",
    ),
    "adjustCardCorners": MessageLookupByLibrary.simpleMessage("商品カードの角の丸みを調整"),
    "applyDiscount": MessageLookupByLibrary.simpleMessage("割引を適用"),
    "atLeastEightCharacters": MessageLookupByLibrary.simpleMessage("8文字以上"),
    "atLeastOneNumber": MessageLookupByLibrary.simpleMessage("数字を1つ以上"),
    "atLeastOneSpecialCharacter": MessageLookupByLibrary.simpleMessage(
      "特殊文字を1つ以上",
    ),
    "authenticationError": MessageLookupByLibrary.simpleMessage("認証エラー"),
    "availability": MessageLookupByLibrary.simpleMessage("提供状況"),
    "backgroundColor": MessageLookupByLibrary.simpleMessage("背景色"),
    "backgroundColorPreview": MessageLookupByLibrary.simpleMessage("背景色のプレビュー"),
    "backgroundColorPreviewDescription": MessageLookupByLibrary.simpleMessage(
      "選択した色をページの背景に適用した状態を確認できます",
    ),
    "backgroundProcessTimeout": MessageLookupByLibrary.simpleMessage(
      "バックグラウンド処理に時間がかかりすぎています。もう一度お試しください。",
    ),
    "bannerAdded": MessageLookupByLibrary.simpleMessage("バナーを追加しました"),
    "bannerAddedDescription": MessageLookupByLibrary.simpleMessage(
      "バナーが正常に追加されました。",
    ),
    "bannerDeleted": MessageLookupByLibrary.simpleMessage("バナーを削除しました"),
    "bannerDeletedDescription": MessageLookupByLibrary.simpleMessage(
      "バナーが正常に削除されました。",
    ),
    "bannerExpirationDateOptional": MessageLookupByLibrary.simpleMessage(
      "有効期限（任意）",
    ),
    "bannerInteractions": m0,
    "bannerToggled": MessageLookupByLibrary.simpleMessage("バナーの状態を変更しました"),
    "bannerToggledDescription": MessageLookupByLibrary.simpleMessage(
      "バナーの状態が正常に更新されました。",
    ),
    "bannerUpdated": MessageLookupByLibrary.simpleMessage("バナーを更新しました"),
    "bannerUpdatedDescription": MessageLookupByLibrary.simpleMessage(
      "バナーが正常に更新されました。",
    ),
    "brandPrimaryColor": MessageLookupByLibrary.simpleMessage("ブランドのメインカラー"),
    "buildYourMenu": MessageLookupByLibrary.simpleMessage("メニューを作成"),
    "buildYourMenuDescription": MessageLookupByLibrary.simpleMessage(
      "メニューを魅力的なデジタル体験に変えましょう",
    ),
    "business": MessageLookupByLibrary.simpleMessage("店舗"),
    "businessDetails": MessageLookupByLibrary.simpleMessage("店舗詳細"),
    "businessDetailsDescription": MessageLookupByLibrary.simpleMessage(
      "レストラン情報を更新",
    ),
    "businessEmail": MessageLookupByLibrary.simpleMessage("店舗用メールアドレス"),
    "businessInfo": MessageLookupByLibrary.simpleMessage("店舗情報"),
    "cancel": MessageLookupByLibrary.simpleMessage("キャンセル"),
    "cardElevation": MessageLookupByLibrary.simpleMessage("カードの浮き上がり"),
    "cardRadius": MessageLookupByLibrary.simpleMessage("カードの角の丸み"),
    "cardRadiusPreview": MessageLookupByLibrary.simpleMessage("カードの角のプレビュー"),
    "cardRadiusPreviewDescription": MessageLookupByLibrary.simpleMessage(
      "選択した設定で商品カードがどのように見えるか確認できます",
    ),
    "cardsRadius": MessageLookupByLibrary.simpleMessage("カードの角の丸み"),
    "categories": MessageLookupByLibrary.simpleMessage("カテゴリー"),
    "categoryAdded": MessageLookupByLibrary.simpleMessage("カテゴリーを追加しました"),
    "categoryAddedDescription": MessageLookupByLibrary.simpleMessage(
      "カテゴリーをメニューに追加しました",
    ),
    "categoryDeleted": MessageLookupByLibrary.simpleMessage("カテゴリーを削除しました"),
    "categoryDeletedDescription": MessageLookupByLibrary.simpleMessage(
      "カテゴリーをメニューから削除しました",
    ),
    "categoryDetails": MessageLookupByLibrary.simpleMessage("カテゴリー詳細"),
    "categoryDetailsDescription": MessageLookupByLibrary.simpleMessage(
      "例：ピザ、サラダのように、名前は短く分かりやすくしてください",
    ),
    "categoryFailed": MessageLookupByLibrary.simpleMessage("カテゴリーの処理に失敗しました"),
    "categoryImage": MessageLookupByLibrary.simpleMessage("カテゴリー画像"),
    "categoryImageDescription": MessageLookupByLibrary.simpleMessage(
      "高品質な写真は、お客様がこのカテゴリーを認識するのに役立ちます",
    ),
    "categoryInfo": MessageLookupByLibrary.simpleMessage(
      "カテゴリーはお客様がメニューを見やすくするのに役立ちます。カテゴリー名は短くし、高品質な写真を使用することをおすすめします。",
    ),
    "categoryItems": MessageLookupByLibrary.simpleMessage("カテゴリー内の商品"),
    "categoryName": MessageLookupByLibrary.simpleMessage("カテゴリー名"),
    "categoryNameHint": MessageLookupByLibrary.simpleMessage("例：ピザ、パスタなど"),
    "categoryToggled": MessageLookupByLibrary.simpleMessage("カテゴリーの状態を変更しました"),
    "categoryUpdated": MessageLookupByLibrary.simpleMessage("カテゴリーを更新しました"),
    "categoryUpdatedDescription": MessageLookupByLibrary.simpleMessage(
      "カテゴリーをメニューで更新しました",
    ),
    "categoryVisibilityDescription": MessageLookupByLibrary.simpleMessage(
      "このカテゴリーをお客様に表示するかどうかを設定します",
    ),
    "change": MessageLookupByLibrary.simpleMessage("変更"),
    "changePassword": MessageLookupByLibrary.simpleMessage("パスワードを変更"),
    "changePasswordDescription": MessageLookupByLibrary.simpleMessage(
      "安全性を高めるため、以下の条件を満たす新しいパスワードを入力してください",
    ),
    "checkInternetConnection": MessageLookupByLibrary.simpleMessage(
      "インターネット接続を確認してください。",
    ),
    "chooseBackgroundColor": MessageLookupByLibrary.simpleMessage(
      "ウェブサイトのページ背景色を選択してください",
    ),
    "choosePrimaryColor": MessageLookupByLibrary.simpleMessage(
      "ブランドのメインカラーを選択してください",
    ),
    "chooseTypography": MessageLookupByLibrary.simpleMessage(
      "レストランのスタイルに合うタイポグラフィを選択してください",
    ),
    "clicks": m1,
    "completed": MessageLookupByLibrary.simpleMessage("完了"),
    "components": MessageLookupByLibrary.simpleMessage("コンポーネント"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("パスワードの確認"),
    "connectionError": MessageLookupByLibrary.simpleMessage("接続エラー"),
    "controlShadowDepth": MessageLookupByLibrary.simpleMessage("カード下の影の深さを調整"),
    "createAnAccount": MessageLookupByLibrary.simpleMessage(" アカウントを作成"),
    "createLoginCredentials": MessageLookupByLibrary.simpleMessage(
      "レストランのメニューを管理するためのログイン情報を作成してください。",
    ),
    "currentPrice": m2,
    "currentSelection": MessageLookupByLibrary.simpleMessage("現在の選択"),
    "customizeBrandPrimaryColor": MessageLookupByLibrary.simpleMessage(
      "ブランドのメインカラーをカスタマイズ",
    ),
    "customizeCardRadius": MessageLookupByLibrary.simpleMessage(
      "商品カードの角の丸みをカスタマイズ",
    ),
    "customizeWebsiteBackground": MessageLookupByLibrary.simpleMessage(
      "ウェブサイトの背景色をカスタマイズ",
    ),
    "customizeWebsiteFont": MessageLookupByLibrary.simpleMessage(
      "ウェブサイトのフォントスタイルをカスタマイズ",
    ),
    "darkMode": MessageLookupByLibrary.simpleMessage("ダークモード"),
    "darkModeDescription": MessageLookupByLibrary.simpleMessage(
      "見やすいダークテーマを有効にする",
    ),
    "dataDrivenDecisions": MessageLookupByLibrary.simpleMessage("データに基づく意思決定"),
    "dataDrivenDecisionsDescription": MessageLookupByLibrary.simpleMessage(
      "お客様が何を求めているかを把握しましょう。メニューの閲覧数や人気商品を追跡して、収益を最大化します",
    ),
    "dataError": MessageLookupByLibrary.simpleMessage("データエラー"),
    "defaultLanguage": MessageLookupByLibrary.simpleMessage("デフォルト"),
    "delete": MessageLookupByLibrary.simpleMessage("削除"),
    "deleteBanner": MessageLookupByLibrary.simpleMessage("バナーを削除"),
    "deleteBannerConfirmation": MessageLookupByLibrary.simpleMessage(
      "このバナーを削除してもよろしいですか？",
    ),
    "deleteExpiredBannerConfirmation": MessageLookupByLibrary.simpleMessage(
      "期限切れのバナーを完全に削除してもよろしいですか？",
    ),
    "deleteItem": MessageLookupByLibrary.simpleMessage("商品を削除"),
    "deleteItemConfirmation": MessageLookupByLibrary.simpleMessage(
      "この商品を削除してもよろしいですか？\nこの操作は元に戻すことができません。",
    ),
    "deleteOffer": MessageLookupByLibrary.simpleMessage("オファーを削除"),
    "deleteOfferConfirmation": MessageLookupByLibrary.simpleMessage(
      "このオファーを削除してもよろしいですか？ \nこの操作は取り消せません。",
    ),
    "deleteOfferConfirmationTitle": MessageLookupByLibrary.simpleMessage(
      "オファーを削除",
    ),
    "description": MessageLookupByLibrary.simpleMessage("説明"),
    "descriptionHint": MessageLookupByLibrary.simpleMessage(
      "材料、アレルゲン、調理方法などを説明してください...",
    ),
    "descriptionOptional": MessageLookupByLibrary.simpleMessage("説明（任意）"),
    "differentPrice": MessageLookupByLibrary.simpleMessage("異なる価格を入力してください"),
    "discountLessThanOriginal": MessageLookupByLibrary.simpleMessage(
      "割引後の価格は元の価格より低くする必要があります",
    ),
    "discountPercentage": m3,
    "discountedPrice": MessageLookupByLibrary.simpleMessage("割引後の価格"),
    "discountedPriceHint": MessageLookupByLibrary.simpleMessage(
      "新しい価格を入力（例：19.99）",
    ),
    "displaySetting": MessageLookupByLibrary.simpleMessage("表示設定"),
    "dynamicContentDescription": MessageLookupByLibrary.simpleMessage(
      "動的なコンテンツでお客様を引きつけましょう",
    ),
    "edit": MessageLookupByLibrary.simpleMessage("編集"),
    "editBanner": MessageLookupByLibrary.simpleMessage("バナーを編集"),
    "editCategory": MessageLookupByLibrary.simpleMessage("カテゴリーを編集"),
    "editItem": MessageLookupByLibrary.simpleMessage("商品を編集"),
    "editItemDetails": MessageLookupByLibrary.simpleMessage("商品詳細を編集"),
    "editOffer": MessageLookupByLibrary.simpleMessage("オファーを編集"),
    "editOfferTitle": MessageLookupByLibrary.simpleMessage("オファーを編集"),
    "email": MessageLookupByLibrary.simpleMessage("メールアドレス"),
    "emailAlreadyRegistered": MessageLookupByLibrary.simpleMessage(
      "このメールアドレスのアカウントはすでに存在します。",
    ),
    "emailNotConfirmed": MessageLookupByLibrary.simpleMessage(
      "ログインする前にメールアドレスを確認してください。",
    ),
    "emailNotFound": MessageLookupByLibrary.simpleMessage("メールアドレスが見つかりません"),
    "emailNotFoundDescription": MessageLookupByLibrary.simpleMessage(
      "メールアドレスが見つかりませんでした",
    ),
    "emailRequired": MessageLookupByLibrary.simpleMessage("メールアドレスは必須です"),
    "enableShadow": MessageLookupByLibrary.simpleMessage("影を有効にする"),
    "endDate": MessageLookupByLibrary.simpleMessage("終了日"),
    "ended": m4,
    "enterCategoryName": MessageLookupByLibrary.simpleMessage(
      "カテゴリー名を入力してください",
    ),
    "enterCountryNameOrCode": MessageLookupByLibrary.simpleMessage(
      "国名または国コードを入力してください",
    ),
    "enterDescription": MessageLookupByLibrary.simpleMessage("説明を入力してください"),
    "enterDiscountedPrice": MessageLookupByLibrary.simpleMessage(
      "割引後の価格を入力してください",
    ),
    "enterItemName": MessageLookupByLibrary.simpleMessage("商品名を入力してください"),
    "enterOfferName": MessageLookupByLibrary.simpleMessage("オファー名を入力してください"),
    "enterPrice": MessageLookupByLibrary.simpleMessage("価格を入力してください"),
    "enterRestaurantAddress": MessageLookupByLibrary.simpleMessage(
      "レストランの住所を入力してください",
    ),
    "enterRestaurantName": MessageLookupByLibrary.simpleMessage(
      "レストラン名を入力してください",
    ),
    "enterVerificationCode": MessageLookupByLibrary.simpleMessage(
      "認証コードを入力してください",
    ),
    "enterYourEmail": MessageLookupByLibrary.simpleMessage("メールアドレスを入力してください"),
    "enterYourFullName": MessageLookupByLibrary.simpleMessage("氏名を入力してください"),
    "enterYourPassword": MessageLookupByLibrary.simpleMessage("パスワードを入力してください"),
    "enterYourPhoneNumber": MessageLookupByLibrary.simpleMessage(
      "電話番号を入力してください",
    ),
    "error": MessageLookupByLibrary.simpleMessage("エラー"),
    "errorLoadingBanners": MessageLookupByLibrary.simpleMessage("バナーの読み込みエラー"),
    "errorLoadingTopItems": MessageLookupByLibrary.simpleMessage(
      "人気商品の読み込みに失敗しました",
    ),
    "expirationDateOptional": MessageLookupByLibrary.simpleMessage(
      "有効期限日時（任意）",
    ),
    "expired": MessageLookupByLibrary.simpleMessage("期限切れ"),
    "expires": m5,
    "failedToLoadBanners": MessageLookupByLibrary.simpleMessage(
      "バナーの読み込みに失敗しました",
    ),
    "failedToLoadCategories": MessageLookupByLibrary.simpleMessage(
      "カテゴリーの読み込みに失敗しました",
    ),
    "failedToLoadCustomizations": MessageLookupByLibrary.simpleMessage(
      "カスタマイズの読み込みに失敗しました",
    ),
    "failedToLoadItems": m6,
    "fileNotFound": MessageLookupByLibrary.simpleMessage(
      "要求されたファイルが見つかりませんでした。",
    ),
    "fileTooLarge": MessageLookupByLibrary.simpleMessage(
      "ファイルが大きすぎます。小さいファイルをアップロードしてください。",
    ),
    "fileUploadFailed": MessageLookupByLibrary.simpleMessage(
      "ファイルのアップロードに失敗しました。接続を確認してください。",
    ),
    "fillItemDetails": MessageLookupByLibrary.simpleMessage(
      "名前、価格、簡単な説明を入力してください",
    ),
    "fontClean": MessageLookupByLibrary.simpleMessage("シンプル"),
    "fontElegant": MessageLookupByLibrary.simpleMessage("エレガント"),
    "fontModern": MessageLookupByLibrary.simpleMessage("モダン"),
    "fontStyle": MessageLookupByLibrary.simpleMessage("フォントスタイル"),
    "fontStylePreview": MessageLookupByLibrary.simpleMessage("フォントスタイルのプレビュー"),
    "fontStylePreviewDescription": MessageLookupByLibrary.simpleMessage(
      "選択したフォントをメニュー上で確認できます",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("パスワードをお忘れですか？"),
    "forgotPasswordDescription": MessageLookupByLibrary.simpleMessage(
      "メールアドレスを入力すると、パスワードリセット用のOTPコードを送信します。",
    ),
    "forgotPasswordTitle": MessageLookupByLibrary.simpleMessage("パスワードをお忘れですか"),
    "generateQrCodes": MessageLookupByLibrary.simpleMessage("QRコードを生成"),
    "generateQrCodesDescription": MessageLookupByLibrary.simpleMessage(
      "お客様がすぐにスキャンしてアクセスできる、メニュー専用のQRコードを作成します",
    ),
    "getStarted": MessageLookupByLibrary.simpleMessage("始める"),
    "goToDashboard": MessageLookupByLibrary.simpleMessage("ダッシュボードへ"),
    "goToLogin": MessageLookupByLibrary.simpleMessage("ログイン"),
    "grilledSalmon": MessageLookupByLibrary.simpleMessage("グリルサーモン — \$18.99"),
    "hidden": MessageLookupByLibrary.simpleMessage("非表示"),
    "home": MessageLookupByLibrary.simpleMessage("ホーム"),
    "imageMustBeLessThanFiveMb": MessageLookupByLibrary.simpleMessage(
      "画像は5MB未満である必要があります",
    ),
    "imagesRequired": MessageLookupByLibrary.simpleMessage("画像が必要です"),
    "incorrectCredentials": MessageLookupByLibrary.simpleMessage(
      "メールアドレスまたはパスワードが正しくありません。もう一度お試しください。",
    ),
    "ingredientCount": m7,
    "ingredientHint": MessageLookupByLibrary.simpleMessage("例：鶏肉、米、野菜"),
    "ingredientLabel": m8,
    "ingredientPerLine": MessageLookupByLibrary.simpleMessage(
      "見やすいメニューにするため、材料は1行に1つ入力してください。",
    ),
    "ingredientsCount": m9,
    "ingredientsDescription": MessageLookupByLibrary.simpleMessage(
      "食事制限やアレルギーのあるお客様のために主な材料を記載してください",
    ),
    "ingredientsOptional": MessageLookupByLibrary.simpleMessage("材料（任意）"),
    "ingredientsTip": MessageLookupByLibrary.simpleMessage(
      "ヒント：入力を省略する場合は項目を空欄にしてください。",
    ),
    "insufficientFunds": MessageLookupByLibrary.simpleMessage(
      "この操作を完了するための残高が不足しています。",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("無効なメールアドレスです"),
    "invalidNumber": MessageLookupByLibrary.simpleMessage("無効な番号です"),
    "invalidOperationState": MessageLookupByLibrary.simpleMessage(
      "無効な状態のため操作を続行できません。",
    ),
    "itemAdded": MessageLookupByLibrary.simpleMessage("商品を追加しました"),
    "itemAddedDescription": MessageLookupByLibrary.simpleMessage(
      "商品がメニューに正常に追加されました。",
    ),
    "itemDeleted": MessageLookupByLibrary.simpleMessage("商品を削除しました"),
    "itemDeletedDescription": MessageLookupByLibrary.simpleMessage(
      "商品がメニューから正常に削除されました。",
    ),
    "itemDetails": MessageLookupByLibrary.simpleMessage("商品詳細"),
    "itemImages": MessageLookupByLibrary.simpleMessage("商品画像"),
    "itemInstructions": MessageLookupByLibrary.simpleMessage(
      "商品をタップして詳細を表示または変更",
    ),
    "itemName": MessageLookupByLibrary.simpleMessage("商品名"),
    "itemNameHint": MessageLookupByLibrary.simpleMessage("例：チキンアルフレドパスタ"),
    "itemUpdated": MessageLookupByLibrary.simpleMessage("商品を更新しました"),
    "itemUpdatedDescription": MessageLookupByLibrary.simpleMessage(
      "商品がメニューで正常に更新されました。",
    ),
    "itemViews": MessageLookupByLibrary.simpleMessage("商品閲覧数"),
    "itemViewsCount": m10,
    "itemVisibilityDescription": MessageLookupByLibrary.simpleMessage(
      "この商品をお客様に表示するかどうかを設定します",
    ),
    "itemVisibleToCustomers": MessageLookupByLibrary.simpleMessage("商品をお客様に表示"),
    "items": MessageLookupByLibrary.simpleMessage("商品"),
    "itemsCount": m11,
    "language": MessageLookupByLibrary.simpleMessage("言語"),
    "later": MessageLookupByLibrary.simpleMessage("後で"),
    "leaderboard": MessageLookupByLibrary.simpleMessage("ランキング"),
    "leaderboardDescription": MessageLookupByLibrary.simpleMessage(
      "メニュー全体の閲覧数でランキングされた商品",
    ),
    "limitedTimeOffer": MessageLookupByLibrary.simpleMessage("期間限定オファー（任意）"),
    "live": MessageLookupByLibrary.simpleMessage("公開中"),
    "login": MessageLookupByLibrary.simpleMessage("ログイン"),
    "loginFailed": MessageLookupByLibrary.simpleMessage("ログインに失敗しました"),
    "logoRequired": MessageLookupByLibrary.simpleMessage("ロゴが必要です"),
    "makeBannerLive": MessageLookupByLibrary.simpleMessage("今すぐバナーを公開しますか？"),
    "manageItem": MessageLookupByLibrary.simpleMessage("商品を管理"),
    "manageMultipleBranches": MessageLookupByLibrary.simpleMessage("複数店舗を管理"),
    "manageMultipleBranchesDescription": MessageLookupByLibrary.simpleMessage(
      "すべての店舗のメニュー、価格、QRコードを1つのダッシュボードから管理できます。",
    ),
    "manageNotificationPreferences": MessageLookupByLibrary.simpleMessage(
      "通知設定を管理",
    ),
    "manageOffer": MessageLookupByLibrary.simpleMessage("オファーを管理"),
    "managePromotionalBanners": MessageLookupByLibrary.simpleMessage(
      "プロモーションバナーと広告を管理",
    ),
    "mandatoryUpdateDescription": MessageLookupByLibrary.simpleMessage(
      "RestoQRの新しいバージョンが利用可能です。引き続きアプリを使用するにはアップデートしてください。",
    ),
    "marketingAndPromotions": MessageLookupByLibrary.simpleMessage(
      "マーケティングとプロモーション",
    ),
    "menuCategoriesDescription": MessageLookupByLibrary.simpleMessage(
      "メニューのカテゴリーと商品を管理",
    ),
    "menuInteractionsDescription": MessageLookupByLibrary.simpleMessage(
      "メニューへの反応を把握しましょう",
    ),
    "menuUrlCopied": MessageLookupByLibrary.simpleMessage(
      "メニューURLをクリップボードにコピーしました",
    ),
    "missingRelatedData": MessageLookupByLibrary.simpleMessage(
      "必要な関連データがないため、操作に失敗しました。",
    ),
    "moreComponentsInfo": MessageLookupByLibrary.simpleMessage(
      "今後のアップデートでさらにコンポーネントが追加されます！",
    ),
    "myMenu": MessageLookupByLibrary.simpleMessage("マイメニュー"),
    "newMenuVisits": MessageLookupByLibrary.simpleMessage("新しいメニュー訪問"),
    "newToRestoQr": MessageLookupByLibrary.simpleMessage("RestoQRを初めてご利用ですか？"),
    "next": MessageLookupByLibrary.simpleMessage("次へ"),
    "noActiveBanners": MessageLookupByLibrary.simpleMessage("有効なバナーはありません"),
    "noActiveBannersDescription": MessageLookupByLibrary.simpleMessage(
      "現在、有効なバナーはありません。",
    ),
    "noActiveBannersTitle": MessageLookupByLibrary.simpleMessage(
      "有効なバナーはありません",
    ),
    "noBanners": MessageLookupByLibrary.simpleMessage("バナーはありません"),
    "noBannersDescription": MessageLookupByLibrary.simpleMessage(
      "現在バナーはありません。メニュー項目を宣伝するために追加しましょう！",
    ),
    "noCategoriesFound": MessageLookupByLibrary.simpleMessage("カテゴリーが見つかりません"),
    "noCategoriesYet": MessageLookupByLibrary.simpleMessage("カテゴリーはまだありません"),
    "noCompletedBanners": MessageLookupByLibrary.simpleMessage("完了したバナーはありません"),
    "noCompletedBannersDescription": MessageLookupByLibrary.simpleMessage(
      "期限切れのバナーがここに表示されます。",
    ),
    "noDiscount": MessageLookupByLibrary.simpleMessage("割引なし"),
    "noExpiration": MessageLookupByLibrary.simpleMessage("有効期限なし"),
    "noExpirationDate": MessageLookupByLibrary.simpleMessage("有効期限なし"),
    "noItems": MessageLookupByLibrary.simpleMessage("商品はありません"),
    "noItemsAvailable": MessageLookupByLibrary.simpleMessage(
      "このオファーに追加できる商品はありません。",
    ),
    "noItemsFound": MessageLookupByLibrary.simpleMessage("商品が見つかりません"),
    "noItemsInCategory": MessageLookupByLibrary.simpleMessage(
      "このカテゴリーに商品が見つかりません",
    ),
    "noItemsToDisplay": MessageLookupByLibrary.simpleMessage("表示する商品がありません。"),
    "noOffersYet": MessageLookupByLibrary.simpleMessage("オファーはまだありません"),
    "noRedirect": MessageLookupByLibrary.simpleMessage("リダイレクトなし"),
    "noRedirectLink": MessageLookupByLibrary.simpleMessage("リダイレクトリンクなし"),
    "notificationSettings": MessageLookupByLibrary.simpleMessage("通知設定"),
    "notificationSettingsDescription": MessageLookupByLibrary.simpleMessage(
      "ここでの変更は、この端末の通知にのみ適用されます。",
    ),
    "offerActivatedDescription": MessageLookupByLibrary.simpleMessage(
      "オファーを正常に有効化しました",
    ),
    "offerAddedDescription": MessageLookupByLibrary.simpleMessage(
      "オファーを正常に追加しました",
    ),
    "offerDeactivatedDescription": MessageLookupByLibrary.simpleMessage(
      "オファーを正常に無効化しました",
    ),
    "offerDeletedDescription": MessageLookupByLibrary.simpleMessage(
      "オファーを正常に削除しました",
    ),
    "offerDetails": MessageLookupByLibrary.simpleMessage("オファー詳細"),
    "offerDetailsDescription": MessageLookupByLibrary.simpleMessage(
      "このオファーについてお客様が知る必要のある詳細を追加してください",
    ),
    "offerInstructions": MessageLookupByLibrary.simpleMessage(
      "オファーをタップして詳細を表示または変更",
    ),
    "offerItems": MessageLookupByLibrary.simpleMessage("オファーの商品"),
    "offerItemsDescription": MessageLookupByLibrary.simpleMessage(
      "オファーに含まれる商品を記載してください",
    ),
    "offerName": MessageLookupByLibrary.simpleMessage("オファー名"),
    "offerNameHint": MessageLookupByLibrary.simpleMessage("例：ビッグミールコンボ"),
    "offerUpdatedDescription": MessageLookupByLibrary.simpleMessage(
      "オファーを正常に更新しました",
    ),
    "offers": MessageLookupByLibrary.simpleMessage("オファー"),
    "operationTimeout": MessageLookupByLibrary.simpleMessage(
      "操作がタイムアウトしました。もう一度お試しください。",
    ),
    "optionalUpdateDescription": MessageLookupByLibrary.simpleMessage(
      "RestoQRの新しいバージョンが利用可能です。アップデートしますか？",
    ),
    "orderNow": MessageLookupByLibrary.simpleMessage("今すぐ注文"),
    "otpRequired": MessageLookupByLibrary.simpleMessage("OTPは必須です"),
    "otpSent": MessageLookupByLibrary.simpleMessage("OTPを送信しました"),
    "otpSentToEmail": MessageLookupByLibrary.simpleMessage(
      "OTPをメールアドレスに送信しました",
    ),
    "password": MessageLookupByLibrary.simpleMessage("パスワード"),
    "passwordChanged": MessageLookupByLibrary.simpleMessage("パスワードを変更しました"),
    "passwordChangedDescription": MessageLookupByLibrary.simpleMessage(
      "アカウントのパスワードが変更されました。新しいパスワードでアカウントにアクセスできます。",
    ),
    "passwordConfirmationRequired": MessageLookupByLibrary.simpleMessage(
      "パスワードの確認は必須です",
    ),
    "passwordRequired": MessageLookupByLibrary.simpleMessage("パスワードは必須です"),
    "passwordTooShort": MessageLookupByLibrary.simpleMessage(
      "パスワードは6文字以上である必要があります。",
    ),
    "passwordsNotIdentical": MessageLookupByLibrary.simpleMessage(
      "パスワードが一致しません",
    ),
    "permissionDenied": MessageLookupByLibrary.simpleMessage(
      "この操作を実行する権限がありません。",
    ),
    "personalizeMenuDescription": MessageLookupByLibrary.simpleMessage(
      "お客様に表示されるデジタルメニューの見た目をカスタマイズします",
    ),
    "phoneNumber": MessageLookupByLibrary.simpleMessage("電話番号"),
    "phoneRequired": MessageLookupByLibrary.simpleMessage("電話番号は必須です"),
    "pickAColor": MessageLookupByLibrary.simpleMessage("色を選択"),
    "platformUpdatesDescription": MessageLookupByLibrary.simpleMessage(
      "プラットフォームのアップデートとパフォーマンス改善",
    ),
    "pleaseEnterYourName": MessageLookupByLibrary.simpleMessage("名前を入力してください"),
    "preferedLanguage": MessageLookupByLibrary.simpleMessage("優先言語"),
    "preferedLanguageDescription": MessageLookupByLibrary.simpleMessage(
      "アプリで使用する言語を選択してください",
    ),
    "preview": MessageLookupByLibrary.simpleMessage("プレビュー"),
    "previewBackgroundColor": MessageLookupByLibrary.simpleMessage("背景色のプレビュー"),
    "price": MessageLookupByLibrary.simpleMessage("価格"),
    "priceHint": MessageLookupByLibrary.simpleMessage("例：12.99"),
    "priceTag": MessageLookupByLibrary.simpleMessage("価格タグ"),
    "primaryColorPreview": MessageLookupByLibrary.simpleMessage("メインカラーのプレビュー"),
    "primaryColorPreviewDescription": MessageLookupByLibrary.simpleMessage(
      "主要な要素でブランドカラーがどのように見えるか確認できます",
    ),
    "print": MessageLookupByLibrary.simpleMessage("印刷"),
    "printFailed": MessageLookupByLibrary.simpleMessage("印刷に失敗しました"),
    "procedureError": MessageLookupByLibrary.simpleMessage("プロシージャエラー"),
    "procedureExecutionFailed": MessageLookupByLibrary.simpleMessage(
      "要求されたプロシージャの実行中に問題が発生しました。",
    ),
    "procedurePermissionDenied": MessageLookupByLibrary.simpleMessage(
      "このプロシージャを実行するために必要な権限がありません。",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("プロフィール"),
    "profileDetails": MessageLookupByLibrary.simpleMessage("プロフィール詳細"),
    "profileDetailsDescription": MessageLookupByLibrary.simpleMessage(
      "プロフィール情報を表示・編集",
    ),
    "profileSettings": MessageLookupByLibrary.simpleMessage("プロフィール設定"),
    "profileUpdated": MessageLookupByLibrary.simpleMessage("プロフィールを更新しました"),
    "profileUpdatedDescription": MessageLookupByLibrary.simpleMessage(
      "プロフィール情報が正常に更新されました。",
    ),
    "promoClicks": MessageLookupByLibrary.simpleMessage("プロモーションのクリック数"),
    "promotionalBanners": MessageLookupByLibrary.simpleMessage("プロモーションバナー"),
    "qrCode": MessageLookupByLibrary.simpleMessage("QRコード"),
    "qrCodeActionsDescription": MessageLookupByLibrary.simpleMessage(
      "QRコードを共有または保存してメニューを宣伝しましょう",
    ),
    "qrCodeInfo": MessageLookupByLibrary.simpleMessage(
      "スキャンすると、お客様をレストランのデジタルメニューへ直接案内します",
    ),
    "qrPrintErrorDescription": MessageLookupByLibrary.simpleMessage(
      "QRコードの印刷中にエラーが発生しました。もう一度お試しください。",
    ),
    "qrScanNotificationsDescription": MessageLookupByLibrary.simpleMessage(
      "誰かがQRコードをスキャンしたときに通知を受け取ります",
    ),
    "qrShareErrorDescription": MessageLookupByLibrary.simpleMessage(
      "QRコードURLの共有中にエラーが発生しました。もう一度お試しください。",
    ),
    "quickBrownFox": MessageLookupByLibrary.simpleMessage("素早い茶色のキツネ"),
    "recordAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "このレコードはすでに存在します。別のものを使用してください。",
    ),
    "redirectToItemOptional": MessageLookupByLibrary.simpleMessage(
      "商品へのリダイレクト（任意）",
    ),
    "reenterTheSamePassword": MessageLookupByLibrary.simpleMessage(
      "同じパスワードをもう一度入力してください",
    ),
    "registerRestaurant": MessageLookupByLibrary.simpleMessage("レストランを登録"),
    "registerRestaurantDescription": MessageLookupByLibrary.simpleMessage(
      "数千の店舗に加わりましょう。プロフィールを設定し、ロゴをアップロードして、デジタルでのサービスを始めましょう。",
    ),
    "removeDiscount": MessageLookupByLibrary.simpleMessage("割引を削除"),
    "removeDiscountConfirmation": MessageLookupByLibrary.simpleMessage(
      "この商品の割引を削除してもよろしいですか？",
    ),
    "removeDiscountTitle": MessageLookupByLibrary.simpleMessage("割引を削除"),
    "republishBanner": MessageLookupByLibrary.simpleMessage("バナーを再公開"),
    "requestProcessingFailed": MessageLookupByLibrary.simpleMessage(
      "リクエストの処理中に問題が発生しました。",
    ),
    "requestTimedOut": MessageLookupByLibrary.simpleMessage("リクエストがタイムアウトしました"),
    "requestTooSlow": MessageLookupByLibrary.simpleMessage(
      "操作の完了に時間がかかりすぎています。接続速度を確認するか、後でもう一度お試しください。",
    ),
    "resendCode": MessageLookupByLibrary.simpleMessage("コードを再送信"),
    "resendCodeIn": MessageLookupByLibrary.simpleMessage("コードを再送信できるまで："),
    "restQrTagline": MessageLookupByLibrary.simpleMessage(
      "あなたのレストランが、ワンスキャンで身近に。",
    ),
    "restaurantAddress": MessageLookupByLibrary.simpleMessage("レストランの住所"),
    "restaurantAddressRequired": MessageLookupByLibrary.simpleMessage(
      "レストランの住所は必須です",
    ),
    "restaurantLocation": MessageLookupByLibrary.simpleMessage("レストランの位置情報"),
    "restaurantLocationRequired": MessageLookupByLibrary.simpleMessage(
      "レストランの位置情報は必須です",
    ),
    "restaurantName": MessageLookupByLibrary.simpleMessage("レストラン名"),
    "restaurantNameHint": MessageLookupByLibrary.simpleMessage(
      "レストラン名を入力してください",
    ),
    "restaurantNameRequired": MessageLookupByLibrary.simpleMessage(
      "レストラン名は必須です",
    ),
    "salmonDescription": MessageLookupByLibrary.simpleMessage(
      "レモンバターソースを添えた新鮮なアトランティックサーモンの切り身。",
    ),
    "save": MessageLookupByLibrary.simpleMessage("保存"),
    "saveCategory": MessageLookupByLibrary.simpleMessage("カテゴリーを保存"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("変更を保存"),
    "saveDataFailed": MessageLookupByLibrary.simpleMessage(
      "データの保存中に問題が発生しました。",
    ),
    "saveItem": MessageLookupByLibrary.simpleMessage("商品を保存"),
    "saveOffer": MessageLookupByLibrary.simpleMessage("オファーを保存"),
    "saveToGallery": MessageLookupByLibrary.simpleMessage("ギャラリーに保存"),
    "savedToGalleryDescription": MessageLookupByLibrary.simpleMessage(
      "QRコード画像が端末のギャラリーに保存されました。",
    ),
    "searchCountry": MessageLookupByLibrary.simpleMessage("国を検索"),
    "secureAccountAccess": MessageLookupByLibrary.simpleMessage("安全なアカウントアクセス"),
    "securityPlatformUpdates": MessageLookupByLibrary.simpleMessage(
      "セキュリティとプラットフォームのアップデート",
    ),
    "selectDateTime": MessageLookupByLibrary.simpleMessage("日時を選択"),
    "selectFont": MessageLookupByLibrary.simpleMessage("フォントを選択"),
    "selectMenuItem": MessageLookupByLibrary.simpleMessage("メニュー項目を選択"),
    "selectOfferItems": MessageLookupByLibrary.simpleMessage("このオファーの商品を選択"),
    "selectRestaurantLocation": MessageLookupByLibrary.simpleMessage(
      "タップしてレストランの位置を選択してください",
    ),
    "serverFunctionNotFound": MessageLookupByLibrary.simpleMessage(
      "要求されたサーバー関数が見つかりませんでした。",
    ),
    "serverTimeout": MessageLookupByLibrary.simpleMessage(
      "サーバーからの応答に時間がかかりすぎています。もう一度お試しください。",
    ),
    "serverTrouble": MessageLookupByLibrary.simpleMessage(
      "現在、サーバーで問題が発生しています。対応中です。",
    ),
    "serverUnreachable": MessageLookupByLibrary.simpleMessage(
      "サーバーに接続できません。インターネット接続を確認して、もう一度お試しください。",
    ),
    "serviceUnavailable": MessageLookupByLibrary.simpleMessage(
      "現在、利用しようとしているサービスを利用できません。",
    ),
    "setDateTimeForOffer": MessageLookupByLibrary.simpleMessage(
      "このオファーの開始日と終了日を設定してください",
    ),
    "share": MessageLookupByLibrary.simpleMessage("共有"),
    "shareFailed": MessageLookupByLibrary.simpleMessage("共有に失敗しました"),
    "shareQrCodeImage": MessageLookupByLibrary.simpleMessage("QRコード画像を共有"),
    "shareUrl": MessageLookupByLibrary.simpleMessage("URLを共有"),
    "showAll": MessageLookupByLibrary.simpleMessage("すべて表示"),
    "signInFailed": MessageLookupByLibrary.simpleMessage(
      "ログインできませんでした。後でもう一度お試しください。",
    ),
    "signInToContinue": MessageLookupByLibrary.simpleMessage(
      "レストランの管理を続けるにはログインしてください。",
    ),
    "signOut": MessageLookupByLibrary.simpleMessage("サインアウト"),
    "signOutConfirmation": MessageLookupByLibrary.simpleMessage(
      "サインアウトしてもよろしいですか？",
    ),
    "signUpFailed": MessageLookupByLibrary.simpleMessage("登録に失敗しました"),
    "signoutDescription": MessageLookupByLibrary.simpleMessage(
      "ダッシュボードにアクセスするには、再度ログインする必要があります。",
    ),
    "startDate": MessageLookupByLibrary.simpleMessage("開始日"),
    "success": MessageLookupByLibrary.simpleMessage("成功"),
    "supportedImageFormats": MessageLookupByLibrary.simpleMessage(
      "対応形式：JPG、PNG、JPEG",
    ),
    "systemAndGrowth": MessageLookupByLibrary.simpleMessage("システムと成長"),
    "systemError": MessageLookupByLibrary.simpleMessage("システムエラー"),
    "systemUpdates": MessageLookupByLibrary.simpleMessage("システムアップデート"),
    "thisMonth": MessageLookupByLibrary.simpleMessage("今月"),
    "thisWeek": MessageLookupByLibrary.simpleMessage("今週"),
    "today": MessageLookupByLibrary.simpleMessage("今日"),
    "topCategories": MessageLookupByLibrary.simpleMessage("人気カテゴリー"),
    "topCategoriesDescription": MessageLookupByLibrary.simpleMessage(
      "メニューカテゴリーの概要",
    ),
    "topItems": MessageLookupByLibrary.simpleMessage("人気商品"),
    "topItemsDescription": MessageLookupByLibrary.simpleMessage(
      "今週、メニュー全体で最も閲覧された商品",
    ),
    "totalClicks": m12,
    "totalMenuViews": MessageLookupByLibrary.simpleMessage("メニュー総閲覧数"),
    "totalMenuVisits": MessageLookupByLibrary.simpleMessage("メニュー総訪問数"),
    "unexpectedError": MessageLookupByLibrary.simpleMessage("予期しないエラー"),
    "unexpectedErrorDescription": MessageLookupByLibrary.simpleMessage(
      "予期しないエラーが発生しました。後でもう一度お試しください。",
    ),
    "unsupportedFileFormat": MessageLookupByLibrary.simpleMessage(
      "このファイル形式には対応していません。",
    ),
    "updateAvailable": MessageLookupByLibrary.simpleMessage("アップデートがあります"),
    "updateBanner": MessageLookupByLibrary.simpleMessage("バナーを更新"),
    "updateDiscount": MessageLookupByLibrary.simpleMessage("割引を更新"),
    "updateLogo": MessageLookupByLibrary.simpleMessage("ロゴを更新"),
    "updateLogoDescription": MessageLookupByLibrary.simpleMessage(
      "鉛筆アイコンをタップしてロゴを更新してください",
    ),
    "updateNow": MessageLookupByLibrary.simpleMessage("今すぐアップデート"),
    "updating": MessageLookupByLibrary.simpleMessage("更新中..."),
    "uploadBannerImage": MessageLookupByLibrary.simpleMessage("バナー画像をアップロード"),
    "uploadCategoryImage": MessageLookupByLibrary.simpleMessage(
      "カテゴリー画像をアップロード",
    ),
    "uploadClearPhotos": MessageLookupByLibrary.simpleMessage(
      "お客様を引きつける鮮明な写真をアップロードしてください",
    ),
    "uploadError": MessageLookupByLibrary.simpleMessage("アップロードエラー"),
    "uploadFoodImages": MessageLookupByLibrary.simpleMessage("料理の画像をアップロード"),
    "uploadOfferImage": MessageLookupByLibrary.simpleMessage("オファー画像をアップロード"),
    "uploadRestaurantLogo": MessageLookupByLibrary.simpleMessage(
      "レストランのロゴをアップロード",
    ),
    "userName": MessageLookupByLibrary.simpleMessage("ユーザー名"),
    "username": MessageLookupByLibrary.simpleMessage("ユーザー名"),
    "usernameHint": MessageLookupByLibrary.simpleMessage("ユーザー名を入力してください"),
    "verificationCodeIntro": MessageLookupByLibrary.simpleMessage(
      "4桁のコードを次のアドレスに送信しました：\n",
    ),
    "verify": MessageLookupByLibrary.simpleMessage("確認"),
    "verifyEmail": MessageLookupByLibrary.simpleMessage("メールアドレスを確認"),
    "version": m13,
    "versionLoading": MessageLookupByLibrary.simpleMessage("RestoQRを読み込み中..."),
    "visibleToCustomers": MessageLookupByLibrary.simpleMessage("お客様に表示"),
    "visibleToCustomersDescription": MessageLookupByLibrary.simpleMessage(
      "デジタルメニューにすぐ公開",
    ),
    "website": MessageLookupByLibrary.simpleMessage("ウェブサイト"),
    "websiteChangesSaved": MessageLookupByLibrary.simpleMessage(
      "変更内容が保存され、まもなくデジタルメニューに反映されます。",
    ),
    "websiteCustomization": MessageLookupByLibrary.simpleMessage(
      "ウェブサイトのカスタマイズ",
    ),
    "websiteUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "ウェブサイトを更新しました！",
    ),
    "weekly": MessageLookupByLibrary.simpleMessage("今週"),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("おかえりなさい"),
    "welcomeBackHome": MessageLookupByLibrary.simpleMessage("おかえりなさい"),
  };
}
