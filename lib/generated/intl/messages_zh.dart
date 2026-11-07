// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
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
  String get localeName => 'zh';

  static String m0(count) => "互动次数：${count}";

  static String m1(count) => "${count} 次点击";

  static String m2(price) => "当前价格：${price}";

  static String m3(value) => "折扣百分比：${value}%";

  static String m4(date) => "结束时间：${date}";

  static String m5(date) => "到期时间：${date}";

  static String m6(message) => "加载商品失败：${message}";

  static String m7(count) => "${count} 项";

  static String m8(index) => "食材 ${index}";

  static String m9(count) => "${count} 种食材";

  static String m10(count) => "${count} 次浏览";

  static String m11(count) => "${count} 件商品";

  static String m12(count) => "共 ${count} 次点击";

  static String m13(version) => "RestoQR ${version}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "SelectDateAndTime": MessageLookupByLibrary.simpleMessage("选择日期和时间"),
    "account": MessageLookupByLibrary.simpleMessage("账户"),
    "accountCreated": MessageLookupByLibrary.simpleMessage("账户创建成功！"),
    "accountCreatedDescription": MessageLookupByLibrary.simpleMessage(
      "欢迎加入！您现在可以创建和管理餐厅的数字菜单了。",
    ),
    "accountInfo": MessageLookupByLibrary.simpleMessage("账户信息"),
    "accountNotFound": MessageLookupByLibrary.simpleMessage("未找到使用此电子邮箱的账户。"),
    "accountSettings": MessageLookupByLibrary.simpleMessage("账户设置"),
    "accountSettingsDescription": MessageLookupByLibrary.simpleMessage(
      "管理您的个人资料、通知和偏好设置",
    ),
    "actionButton": MessageLookupByLibrary.simpleMessage("操作按钮"),
    "actions": MessageLookupByLibrary.simpleMessage("操作"),
    "active": MessageLookupByLibrary.simpleMessage("启用"),
    "activeBanners": MessageLookupByLibrary.simpleMessage("启用的横幅"),
    "activeBannersDescription": MessageLookupByLibrary.simpleMessage(
      "正在发布的促销横幅效果",
    ),
    "activityNotifications": MessageLookupByLibrary.simpleMessage("活动通知"),
    "addAtLeastOneItem": MessageLookupByLibrary.simpleMessage("请至少添加一个商品"),
    "addBanner": MessageLookupByLibrary.simpleMessage("添加横幅"),
    "addCategoriesDescription": MessageLookupByLibrary.simpleMessage(
      "添加分类来构建菜单并整理商品",
    ),
    "addCategory": MessageLookupByLibrary.simpleMessage("添加分类"),
    "addIngredient": MessageLookupByLibrary.simpleMessage("添加食材"),
    "addIngredients": MessageLookupByLibrary.simpleMessage("添加食材"),
    "addItem": MessageLookupByLibrary.simpleMessage("添加商品"),
    "addItems": MessageLookupByLibrary.simpleMessage("添加商品"),
    "addNewBanner": MessageLookupByLibrary.simpleMessage("添加新横幅"),
    "addNewItem": MessageLookupByLibrary.simpleMessage("添加新商品"),
    "addNewOffer": MessageLookupByLibrary.simpleMessage("添加新优惠"),
    "addOffersDescription": MessageLookupByLibrary.simpleMessage(
      "将优惠添加到菜单并推广给顾客",
    ),
    "addRestaurantDescription": MessageLookupByLibrary.simpleMessage(
      "添加关于您餐厅的简短描述",
    ),
    "addRestaurantDetails": MessageLookupByLibrary.simpleMessage(
      "添加餐厅详情，让顾客能够找到您。",
    ),
    "adjustCardCorners": MessageLookupByLibrary.simpleMessage("调整商品卡片的圆角"),
    "applyDiscount": MessageLookupByLibrary.simpleMessage("应用折扣"),
    "atLeastEightCharacters": MessageLookupByLibrary.simpleMessage("至少8个字符"),
    "atLeastOneNumber": MessageLookupByLibrary.simpleMessage("至少包含一个数字"),
    "atLeastOneSpecialCharacter": MessageLookupByLibrary.simpleMessage(
      "至少包含一个特殊字符",
    ),
    "authenticationError": MessageLookupByLibrary.simpleMessage("身份验证错误"),
    "availability": MessageLookupByLibrary.simpleMessage("供应状态"),
    "backgroundColor": MessageLookupByLibrary.simpleMessage("背景颜色"),
    "backgroundColorPreview": MessageLookupByLibrary.simpleMessage("背景颜色预览"),
    "backgroundColorPreviewDescription": MessageLookupByLibrary.simpleMessage(
      "查看所选颜色作为页面背景的效果",
    ),
    "backgroundProcessTimeout": MessageLookupByLibrary.simpleMessage(
      "后台处理耗时过长。请重试。",
    ),
    "bannerAdded": MessageLookupByLibrary.simpleMessage("横幅已添加"),
    "bannerAddedDescription": MessageLookupByLibrary.simpleMessage(
      "您的横幅已成功添加。",
    ),
    "bannerDeleted": MessageLookupByLibrary.simpleMessage("横幅已删除"),
    "bannerDeletedDescription": MessageLookupByLibrary.simpleMessage(
      "您的横幅已成功删除。",
    ),
    "bannerExpirationDateOptional": MessageLookupByLibrary.simpleMessage(
      "到期日期（可选）",
    ),
    "bannerInteractions": m0,
    "bannerToggled": MessageLookupByLibrary.simpleMessage("横幅状态已切换"),
    "bannerToggledDescription": MessageLookupByLibrary.simpleMessage(
      "您的横幅状态已成功更新。",
    ),
    "bannerUpdated": MessageLookupByLibrary.simpleMessage("横幅已更新"),
    "bannerUpdatedDescription": MessageLookupByLibrary.simpleMessage(
      "您的横幅已成功更新。",
    ),
    "brandPrimaryColor": MessageLookupByLibrary.simpleMessage("品牌主色"),
    "buildYourMenu": MessageLookupByLibrary.simpleMessage("创建菜单"),
    "buildYourMenuDescription": MessageLookupByLibrary.simpleMessage(
      "将您的菜单转化为精彩的数字体验",
    ),
    "business": MessageLookupByLibrary.simpleMessage("商家"),
    "businessDetails": MessageLookupByLibrary.simpleMessage("商家详情"),
    "businessDetailsDescription": MessageLookupByLibrary.simpleMessage(
      "更新您的餐厅信息",
    ),
    "businessEmail": MessageLookupByLibrary.simpleMessage("商家电子邮箱"),
    "businessInfo": MessageLookupByLibrary.simpleMessage("商家信息"),
    "cancel": MessageLookupByLibrary.simpleMessage("取消"),
    "cardElevation": MessageLookupByLibrary.simpleMessage("卡片阴影"),
    "cardRadius": MessageLookupByLibrary.simpleMessage("卡片圆角"),
    "cardRadiusPreview": MessageLookupByLibrary.simpleMessage("卡片圆角预览"),
    "cardRadiusPreviewDescription": MessageLookupByLibrary.simpleMessage(
      "查看商品卡片应用所选设置后的效果",
    ),
    "cardsRadius": MessageLookupByLibrary.simpleMessage("卡片圆角"),
    "categories": MessageLookupByLibrary.simpleMessage("分类"),
    "categoryAdded": MessageLookupByLibrary.simpleMessage("分类已添加"),
    "categoryAddedDescription": MessageLookupByLibrary.simpleMessage(
      "分类已添加到您的菜单",
    ),
    "categoryDeleted": MessageLookupByLibrary.simpleMessage("分类已删除"),
    "categoryDeletedDescription": MessageLookupByLibrary.simpleMessage(
      "分类已从您的菜单中删除",
    ),
    "categoryDetails": MessageLookupByLibrary.simpleMessage("分类详情"),
    "categoryDetailsDescription": MessageLookupByLibrary.simpleMessage(
      "保持名称简短且具有描述性，例如：披萨、沙拉",
    ),
    "categoryFailed": MessageLookupByLibrary.simpleMessage("分类操作失败"),
    "categoryImage": MessageLookupByLibrary.simpleMessage("分类图片"),
    "categoryImageDescription": MessageLookupByLibrary.simpleMessage(
      "高质量的照片有助于顾客识别此分类",
    ),
    "categoryInfo": MessageLookupByLibrary.simpleMessage(
      "分类可以帮助顾客浏览菜单。建议分类名称保持简短，并使用高质量的照片。",
    ),
    "categoryItems": MessageLookupByLibrary.simpleMessage("分类商品"),
    "categoryName": MessageLookupByLibrary.simpleMessage("分类名称"),
    "categoryNameHint": MessageLookupByLibrary.simpleMessage("例如：披萨、意面等"),
    "categoryToggled": MessageLookupByLibrary.simpleMessage("分类状态已切换"),
    "categoryUpdated": MessageLookupByLibrary.simpleMessage("分类已更新"),
    "categoryUpdatedDescription": MessageLookupByLibrary.simpleMessage(
      "分类已在您的菜单中更新",
    ),
    "categoryVisibilityDescription": MessageLookupByLibrary.simpleMessage(
      "控制顾客是否可以看到此分类",
    ),
    "change": MessageLookupByLibrary.simpleMessage("修改"),
    "changePassword": MessageLookupByLibrary.simpleMessage("修改密码"),
    "changePasswordDescription": MessageLookupByLibrary.simpleMessage(
      "请输入符合以下安全要求的新密码",
    ),
    "checkInternetConnection": MessageLookupByLibrary.simpleMessage(
      "请检查您的网络连接。",
    ),
    "chooseBackgroundColor": MessageLookupByLibrary.simpleMessage(
      "选择网站页面的背景颜色",
    ),
    "choosePrimaryColor": MessageLookupByLibrary.simpleMessage("选择品牌主色"),
    "chooseTypography": MessageLookupByLibrary.simpleMessage(
      "选择与您餐厅风格相匹配的字体排版",
    ),
    "clicks": m1,
    "completed": MessageLookupByLibrary.simpleMessage("已完成"),
    "components": MessageLookupByLibrary.simpleMessage("组件"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("确认密码"),
    "connectionError": MessageLookupByLibrary.simpleMessage("连接错误"),
    "controlShadowDepth": MessageLookupByLibrary.simpleMessage("调整卡片下方阴影的深度"),
    "createAnAccount": MessageLookupByLibrary.simpleMessage(" 创建账户"),
    "createLoginCredentials": MessageLookupByLibrary.simpleMessage(
      "创建登录凭据，以管理您的餐厅菜单。",
    ),
    "currentPrice": m2,
    "currentSelection": MessageLookupByLibrary.simpleMessage("当前选择"),
    "customizeBrandPrimaryColor": MessageLookupByLibrary.simpleMessage(
      "自定义品牌主色",
    ),
    "customizeCardRadius": MessageLookupByLibrary.simpleMessage("自定义商品卡片的圆角"),
    "customizeWebsiteBackground": MessageLookupByLibrary.simpleMessage(
      "自定义网站背景颜色",
    ),
    "customizeWebsiteFont": MessageLookupByLibrary.simpleMessage("自定义网站字体样式"),
    "darkMode": MessageLookupByLibrary.simpleMessage("深色模式"),
    "darkModeDescription": MessageLookupByLibrary.simpleMessage(
      "启用深色主题以获得更好的视觉体验",
    ),
    "dataDrivenDecisions": MessageLookupByLibrary.simpleMessage("数据驱动决策"),
    "dataDrivenDecisionsDescription": MessageLookupByLibrary.simpleMessage(
      "了解顾客想吃什么。跟踪菜单浏览量和热门商品，最大化您的收入",
    ),
    "dataError": MessageLookupByLibrary.simpleMessage("数据错误"),
    "defaultLanguage": MessageLookupByLibrary.simpleMessage("默认"),
    "delete": MessageLookupByLibrary.simpleMessage("删除"),
    "deleteBanner": MessageLookupByLibrary.simpleMessage("删除横幅"),
    "deleteBannerConfirmation": MessageLookupByLibrary.simpleMessage(
      "确定要删除此横幅吗？",
    ),
    "deleteExpiredBannerConfirmation": MessageLookupByLibrary.simpleMessage(
      "确定要永久删除此过期横幅吗？",
    ),
    "deleteItem": MessageLookupByLibrary.simpleMessage("删除商品"),
    "deleteItemConfirmation": MessageLookupByLibrary.simpleMessage(
      "确定要删除此商品吗？\n此操作无法撤销。",
    ),
    "deleteOffer": MessageLookupByLibrary.simpleMessage("删除优惠"),
    "deleteOfferConfirmation": MessageLookupByLibrary.simpleMessage(
      "确定要删除此优惠吗？ \n此操作无法撤销。",
    ),
    "deleteOfferConfirmationTitle": MessageLookupByLibrary.simpleMessage(
      "删除优惠",
    ),
    "description": MessageLookupByLibrary.simpleMessage("描述"),
    "descriptionHint": MessageLookupByLibrary.simpleMessage("描述食材、过敏原或制作方式..."),
    "descriptionOptional": MessageLookupByLibrary.simpleMessage("描述（可选）"),
    "differentPrice": MessageLookupByLibrary.simpleMessage("请输入不同的价格"),
    "discountLessThanOriginal": MessageLookupByLibrary.simpleMessage(
      "折后价格必须低于原价",
    ),
    "discountPercentage": m3,
    "discountedPrice": MessageLookupByLibrary.simpleMessage("折后价格"),
    "discountedPriceHint": MessageLookupByLibrary.simpleMessage(
      "输入新价格（例如：19.99）",
    ),
    "displaySetting": MessageLookupByLibrary.simpleMessage("显示设置"),
    "dynamicContentDescription": MessageLookupByLibrary.simpleMessage(
      "通过动态内容吸引顾客",
    ),
    "edit": MessageLookupByLibrary.simpleMessage("编辑"),
    "editBanner": MessageLookupByLibrary.simpleMessage("编辑横幅"),
    "editCategory": MessageLookupByLibrary.simpleMessage("编辑分类"),
    "editItem": MessageLookupByLibrary.simpleMessage("编辑商品"),
    "editItemDetails": MessageLookupByLibrary.simpleMessage("编辑商品详情"),
    "editOffer": MessageLookupByLibrary.simpleMessage("编辑优惠"),
    "editOfferTitle": MessageLookupByLibrary.simpleMessage("编辑优惠"),
    "email": MessageLookupByLibrary.simpleMessage("电子邮箱"),
    "emailAlreadyRegistered": MessageLookupByLibrary.simpleMessage(
      "此电子邮箱已注册账户。",
    ),
    "emailNotConfirmed": MessageLookupByLibrary.simpleMessage(
      "登录前请验证您的电子邮箱地址。",
    ),
    "emailNotFound": MessageLookupByLibrary.simpleMessage("未找到电子邮箱"),
    "emailNotFoundDescription": MessageLookupByLibrary.simpleMessage(
      "未找到您的电子邮箱",
    ),
    "emailRequired": MessageLookupByLibrary.simpleMessage("电子邮箱为必填项"),
    "enableShadow": MessageLookupByLibrary.simpleMessage("启用阴影"),
    "endDate": MessageLookupByLibrary.simpleMessage("结束日期"),
    "ended": m4,
    "enterCategoryName": MessageLookupByLibrary.simpleMessage("请输入分类名称"),
    "enterCountryNameOrCode": MessageLookupByLibrary.simpleMessage(
      "请输入国家名称或代码",
    ),
    "enterDescription": MessageLookupByLibrary.simpleMessage("请输入描述"),
    "enterDiscountedPrice": MessageLookupByLibrary.simpleMessage("请输入折后价格"),
    "enterItemName": MessageLookupByLibrary.simpleMessage("请输入商品名称"),
    "enterOfferName": MessageLookupByLibrary.simpleMessage("请输入优惠名称"),
    "enterPrice": MessageLookupByLibrary.simpleMessage("请输入价格"),
    "enterRestaurantAddress": MessageLookupByLibrary.simpleMessage("请输入您的餐厅地址"),
    "enterRestaurantName": MessageLookupByLibrary.simpleMessage("请输入您的餐厅名称"),
    "enterVerificationCode": MessageLookupByLibrary.simpleMessage("请输入验证码"),
    "enterYourEmail": MessageLookupByLibrary.simpleMessage("请输入您的电子邮箱"),
    "enterYourFullName": MessageLookupByLibrary.simpleMessage("请输入您的姓名"),
    "enterYourPassword": MessageLookupByLibrary.simpleMessage("请输入您的密码"),
    "enterYourPhoneNumber": MessageLookupByLibrary.simpleMessage("请输入您的电话号码"),
    "error": MessageLookupByLibrary.simpleMessage("错误"),
    "errorLoadingBanners": MessageLookupByLibrary.simpleMessage("加载横幅时出错"),
    "errorLoadingTopItems": MessageLookupByLibrary.simpleMessage("加载热门商品失败"),
    "expirationDateOptional": MessageLookupByLibrary.simpleMessage(
      "到期日期和时间（可选）",
    ),
    "expired": MessageLookupByLibrary.simpleMessage("已过期"),
    "expires": m5,
    "failedToLoadBanners": MessageLookupByLibrary.simpleMessage("加载横幅失败"),
    "failedToLoadCategories": MessageLookupByLibrary.simpleMessage("加载分类失败"),
    "failedToLoadCustomizations": MessageLookupByLibrary.simpleMessage(
      "加载自定义设置失败",
    ),
    "failedToLoadItems": m6,
    "fileNotFound": MessageLookupByLibrary.simpleMessage("找不到请求的文件。"),
    "fileTooLarge": MessageLookupByLibrary.simpleMessage("文件太大。请上传较小的文件。"),
    "fileUploadFailed": MessageLookupByLibrary.simpleMessage(
      "文件上传失败。请检查您的网络连接。",
    ),
    "fillItemDetails": MessageLookupByLibrary.simpleMessage("填写名称、价格和简短描述"),
    "fontClean": MessageLookupByLibrary.simpleMessage("简洁"),
    "fontElegant": MessageLookupByLibrary.simpleMessage("优雅"),
    "fontModern": MessageLookupByLibrary.simpleMessage("现代"),
    "fontStyle": MessageLookupByLibrary.simpleMessage("字体样式"),
    "fontStylePreview": MessageLookupByLibrary.simpleMessage("字体样式预览"),
    "fontStylePreviewDescription": MessageLookupByLibrary.simpleMessage(
      "查看所选字体在菜单上的效果",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("忘记密码？"),
    "forgotPasswordDescription": MessageLookupByLibrary.simpleMessage(
      "输入您的电子邮箱，我们会向您发送用于重置密码的OTP验证码。",
    ),
    "forgotPasswordTitle": MessageLookupByLibrary.simpleMessage("忘记密码"),
    "generateQrCodes": MessageLookupByLibrary.simpleMessage("生成二维码"),
    "generateQrCodesDescription": MessageLookupByLibrary.simpleMessage(
      "为您的菜单创建独特的二维码，让顾客扫描后即可立即访问",
    ),
    "getStarted": MessageLookupByLibrary.simpleMessage("开始使用"),
    "goToDashboard": MessageLookupByLibrary.simpleMessage("前往控制面板"),
    "goToLogin": MessageLookupByLibrary.simpleMessage("登录"),
    "grilledSalmon": MessageLookupByLibrary.simpleMessage("烤三文鱼 — \$18.99"),
    "hidden": MessageLookupByLibrary.simpleMessage("已隐藏"),
    "home": MessageLookupByLibrary.simpleMessage("首页"),
    "imageMustBeLessThanFiveMb": MessageLookupByLibrary.simpleMessage(
      "图片必须小于5 MB",
    ),
    "imagesRequired": MessageLookupByLibrary.simpleMessage("需要图片"),
    "incorrectCredentials": MessageLookupByLibrary.simpleMessage(
      "电子邮箱或密码不正确。请重试。",
    ),
    "ingredientCount": m7,
    "ingredientHint": MessageLookupByLibrary.simpleMessage("例如：鸡肉、米饭、蔬菜"),
    "ingredientLabel": m8,
    "ingredientPerLine": MessageLookupByLibrary.simpleMessage(
      "每行填写一种食材，让菜单更清晰。",
    ),
    "ingredientsCount": m9,
    "ingredientsDescription": MessageLookupByLibrary.simpleMessage(
      "列出主要食材，帮助有饮食偏好或过敏的顾客",
    ),
    "ingredientsOptional": MessageLookupByLibrary.simpleMessage("食材（可选）"),
    "ingredientsTip": MessageLookupByLibrary.simpleMessage("提示：不需要填写的项目可以留空。"),
    "insufficientFunds": MessageLookupByLibrary.simpleMessage("余额不足，无法完成此操作。"),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("电子邮箱无效"),
    "invalidNumber": MessageLookupByLibrary.simpleMessage("号码无效"),
    "invalidOperationState": MessageLookupByLibrary.simpleMessage(
      "由于状态无效，无法继续操作。",
    ),
    "itemAdded": MessageLookupByLibrary.simpleMessage("商品已添加"),
    "itemAddedDescription": MessageLookupByLibrary.simpleMessage(
      "商品已成功添加到您的菜单。",
    ),
    "itemDeleted": MessageLookupByLibrary.simpleMessage("商品已删除"),
    "itemDeletedDescription": MessageLookupByLibrary.simpleMessage(
      "商品已成功从您的菜单中删除。",
    ),
    "itemDetails": MessageLookupByLibrary.simpleMessage("商品详情"),
    "itemImages": MessageLookupByLibrary.simpleMessage("商品图片"),
    "itemInstructions": MessageLookupByLibrary.simpleMessage("点击商品以查看详情或进行修改"),
    "itemName": MessageLookupByLibrary.simpleMessage("商品名称"),
    "itemNameHint": MessageLookupByLibrary.simpleMessage("例如：鸡肉阿尔弗雷多意面"),
    "itemUpdated": MessageLookupByLibrary.simpleMessage("商品已更新"),
    "itemUpdatedDescription": MessageLookupByLibrary.simpleMessage(
      "商品已成功更新到您的菜单。",
    ),
    "itemViews": MessageLookupByLibrary.simpleMessage("商品浏览量"),
    "itemViewsCount": m10,
    "itemVisibilityDescription": MessageLookupByLibrary.simpleMessage(
      "控制顾客是否可以看到此商品",
    ),
    "itemVisibleToCustomers": MessageLookupByLibrary.simpleMessage("商品对顾客可见"),
    "items": MessageLookupByLibrary.simpleMessage("商品"),
    "itemsCount": m11,
    "language": MessageLookupByLibrary.simpleMessage("语言"),
    "later": MessageLookupByLibrary.simpleMessage("稍后"),
    "leaderboard": MessageLookupByLibrary.simpleMessage("排行榜"),
    "leaderboardDescription": MessageLookupByLibrary.simpleMessage(
      "按菜单总浏览量排名的商品",
    ),
    "limitedTimeOffer": MessageLookupByLibrary.simpleMessage("限时优惠（可选）"),
    "live": MessageLookupByLibrary.simpleMessage("已发布"),
    "login": MessageLookupByLibrary.simpleMessage("登录"),
    "loginFailed": MessageLookupByLibrary.simpleMessage("登录失败"),
    "logoRequired": MessageLookupByLibrary.simpleMessage("需要标志"),
    "makeBannerLive": MessageLookupByLibrary.simpleMessage("立即发布横幅？"),
    "manageItem": MessageLookupByLibrary.simpleMessage("管理商品"),
    "manageMultipleBranches": MessageLookupByLibrary.simpleMessage("管理多个分店"),
    "manageMultipleBranchesDescription": MessageLookupByLibrary.simpleMessage(
      "从一个控制面板管理所有门店的菜单、价格和二维码。",
    ),
    "manageNotificationPreferences": MessageLookupByLibrary.simpleMessage(
      "管理通知偏好",
    ),
    "manageOffer": MessageLookupByLibrary.simpleMessage("管理优惠"),
    "managePromotionalBanners": MessageLookupByLibrary.simpleMessage(
      "管理促销横幅和广告",
    ),
    "mandatoryUpdateDescription": MessageLookupByLibrary.simpleMessage(
      "RestoQR的新版本已发布。请更新后继续使用应用。",
    ),
    "marketingAndPromotions": MessageLookupByLibrary.simpleMessage("营销与促销"),
    "menuCategoriesDescription": MessageLookupByLibrary.simpleMessage(
      "管理菜单分类及其商品",
    ),
    "menuInteractionsDescription": MessageLookupByLibrary.simpleMessage(
      "及时了解顾客与菜单的互动",
    ),
    "menuUrlCopied": MessageLookupByLibrary.simpleMessage("菜单网址已复制到剪贴板"),
    "missingRelatedData": MessageLookupByLibrary.simpleMessage(
      "由于缺少相关数据，操作失败。",
    ),
    "moreComponentsInfo": MessageLookupByLibrary.simpleMessage("未来更新将加入更多组件！"),
    "myMenu": MessageLookupByLibrary.simpleMessage("我的菜单"),
    "newMenuVisits": MessageLookupByLibrary.simpleMessage("新的菜单访问"),
    "newToRestoQr": MessageLookupByLibrary.simpleMessage("刚开始使用 RestoQR？"),
    "next": MessageLookupByLibrary.simpleMessage("下一步"),
    "noActiveBanners": MessageLookupByLibrary.simpleMessage("暂无启用的横幅"),
    "noActiveBannersDescription": MessageLookupByLibrary.simpleMessage(
      "您目前没有启用的横幅。",
    ),
    "noActiveBannersTitle": MessageLookupByLibrary.simpleMessage("暂无启用的横幅"),
    "noBanners": MessageLookupByLibrary.simpleMessage("暂无横幅"),
    "noBannersDescription": MessageLookupByLibrary.simpleMessage(
      "您目前没有横幅。添加一些横幅来推广菜单商品吧！",
    ),
    "noCategoriesFound": MessageLookupByLibrary.simpleMessage("未找到分类"),
    "noCategoriesYet": MessageLookupByLibrary.simpleMessage("暂无分类"),
    "noCompletedBanners": MessageLookupByLibrary.simpleMessage("暂无已完成的横幅"),
    "noCompletedBannersDescription": MessageLookupByLibrary.simpleMessage(
      "已过期的横幅会显示在这里。",
    ),
    "noDiscount": MessageLookupByLibrary.simpleMessage("无折扣"),
    "noExpiration": MessageLookupByLibrary.simpleMessage("无期限"),
    "noExpirationDate": MessageLookupByLibrary.simpleMessage("无到期日期"),
    "noItems": MessageLookupByLibrary.simpleMessage("暂无商品"),
    "noItemsAvailable": MessageLookupByLibrary.simpleMessage("没有可添加到此优惠的商品。"),
    "noItemsFound": MessageLookupByLibrary.simpleMessage("未找到商品"),
    "noItemsInCategory": MessageLookupByLibrary.simpleMessage("此分类中未找到商品"),
    "noItemsToDisplay": MessageLookupByLibrary.simpleMessage("没有可显示的商品。"),
    "noOffersYet": MessageLookupByLibrary.simpleMessage("暂无优惠"),
    "noRedirect": MessageLookupByLibrary.simpleMessage("不跳转"),
    "noRedirectLink": MessageLookupByLibrary.simpleMessage("无跳转链接"),
    "notificationSettings": MessageLookupByLibrary.simpleMessage("通知设置"),
    "notificationSettingsDescription": MessageLookupByLibrary.simpleMessage(
      "此处的更改仅影响此设备上的通知。",
    ),
    "offerActivatedDescription": MessageLookupByLibrary.simpleMessage(
      "优惠已成功启用",
    ),
    "offerAddedDescription": MessageLookupByLibrary.simpleMessage("优惠已成功添加"),
    "offerDeactivatedDescription": MessageLookupByLibrary.simpleMessage(
      "优惠已成功停用",
    ),
    "offerDeletedDescription": MessageLookupByLibrary.simpleMessage("优惠已成功删除"),
    "offerDetails": MessageLookupByLibrary.simpleMessage("优惠详情"),
    "offerDetailsDescription": MessageLookupByLibrary.simpleMessage(
      "添加顾客需要了解的优惠详情",
    ),
    "offerInstructions": MessageLookupByLibrary.simpleMessage("点击优惠以查看详情或进行修改"),
    "offerItems": MessageLookupByLibrary.simpleMessage("优惠商品"),
    "offerItemsDescription": MessageLookupByLibrary.simpleMessage("列出优惠中包含的商品"),
    "offerName": MessageLookupByLibrary.simpleMessage("优惠名称"),
    "offerNameHint": MessageLookupByLibrary.simpleMessage("例如：超值套餐"),
    "offerUpdatedDescription": MessageLookupByLibrary.simpleMessage("优惠已成功更新"),
    "offers": MessageLookupByLibrary.simpleMessage("优惠"),
    "operationTimeout": MessageLookupByLibrary.simpleMessage("操作超时。请重试。"),
    "optionalUpdateDescription": MessageLookupByLibrary.simpleMessage(
      "RestoQR的新版本已发布。您想要更新吗？",
    ),
    "orderNow": MessageLookupByLibrary.simpleMessage("立即点餐"),
    "otpRequired": MessageLookupByLibrary.simpleMessage("OTP为必填项"),
    "otpSent": MessageLookupByLibrary.simpleMessage("OTP已发送"),
    "otpSentToEmail": MessageLookupByLibrary.simpleMessage("OTP已发送至您的电子邮箱"),
    "password": MessageLookupByLibrary.simpleMessage("密码"),
    "passwordChanged": MessageLookupByLibrary.simpleMessage("密码已修改"),
    "passwordChangedDescription": MessageLookupByLibrary.simpleMessage(
      "恭喜您，账户密码已修改。现在您可以使用新密码访问账户了",
    ),
    "passwordConfirmationRequired": MessageLookupByLibrary.simpleMessage(
      "确认密码为必填项",
    ),
    "passwordRequired": MessageLookupByLibrary.simpleMessage("密码为必填项"),
    "passwordTooShort": MessageLookupByLibrary.simpleMessage("您的密码必须至少包含6个字符。"),
    "passwordsNotIdentical": MessageLookupByLibrary.simpleMessage("两次输入的密码不一致"),
    "permissionDenied": MessageLookupByLibrary.simpleMessage("您没有执行此操作的权限。"),
    "personalizeMenuDescription": MessageLookupByLibrary.simpleMessage(
      "自定义顾客看到的数字菜单外观",
    ),
    "phoneNumber": MessageLookupByLibrary.simpleMessage("电话号码"),
    "phoneRequired": MessageLookupByLibrary.simpleMessage("电话号码为必填项"),
    "pickAColor": MessageLookupByLibrary.simpleMessage("选择颜色"),
    "platformUpdatesDescription": MessageLookupByLibrary.simpleMessage(
      "平台更新与性能改进",
    ),
    "pleaseEnterYourName": MessageLookupByLibrary.simpleMessage("请输入您的姓名"),
    "preferedLanguage": MessageLookupByLibrary.simpleMessage("首选语言"),
    "preferedLanguageDescription": MessageLookupByLibrary.simpleMessage(
      "选择应用使用的首选语言",
    ),
    "preview": MessageLookupByLibrary.simpleMessage("预览"),
    "previewBackgroundColor": MessageLookupByLibrary.simpleMessage("背景颜色预览"),
    "price": MessageLookupByLibrary.simpleMessage("价格"),
    "priceHint": MessageLookupByLibrary.simpleMessage("例如：12.99"),
    "priceTag": MessageLookupByLibrary.simpleMessage("价格标签"),
    "primaryColorPreview": MessageLookupByLibrary.simpleMessage("主色预览"),
    "primaryColorPreviewDescription": MessageLookupByLibrary.simpleMessage(
      "查看品牌颜色在关键元素上的效果",
    ),
    "print": MessageLookupByLibrary.simpleMessage("打印"),
    "printFailed": MessageLookupByLibrary.simpleMessage("打印失败"),
    "procedureError": MessageLookupByLibrary.simpleMessage("过程错误"),
    "procedureExecutionFailed": MessageLookupByLibrary.simpleMessage(
      "执行请求的过程时遇到问题。",
    ),
    "procedurePermissionDenied": MessageLookupByLibrary.simpleMessage(
      "您没有运行此过程所需的权限。",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("个人资料"),
    "profileDetails": MessageLookupByLibrary.simpleMessage("个人资料详情"),
    "profileDetailsDescription": MessageLookupByLibrary.simpleMessage(
      "查看和编辑您的个人资料信息",
    ),
    "profileSettings": MessageLookupByLibrary.simpleMessage("个人资料设置"),
    "profileUpdated": MessageLookupByLibrary.simpleMessage("个人资料已更新"),
    "profileUpdatedDescription": MessageLookupByLibrary.simpleMessage(
      "您的个人资料信息已成功更新。",
    ),
    "promoClicks": MessageLookupByLibrary.simpleMessage("促销点击量"),
    "promotionalBanners": MessageLookupByLibrary.simpleMessage("促销横幅"),
    "qrCode": MessageLookupByLibrary.simpleMessage("二维码"),
    "qrCodeActionsDescription": MessageLookupByLibrary.simpleMessage(
      "分享或保存二维码来推广您的菜单",
    ),
    "qrCodeInfo": MessageLookupByLibrary.simpleMessage("扫描后可将顾客直接带到您餐厅的数字菜单"),
    "qrPrintErrorDescription": MessageLookupByLibrary.simpleMessage(
      "打印二维码时发生错误。请重试。",
    ),
    "qrScanNotificationsDescription": MessageLookupByLibrary.simpleMessage(
      "有人扫描二维码时接收通知",
    ),
    "qrShareErrorDescription": MessageLookupByLibrary.simpleMessage(
      "分享二维码网址时发生错误。请重试。",
    ),
    "quickBrownFox": MessageLookupByLibrary.simpleMessage("敏捷的棕色狐狸"),
    "recordAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "此记录已存在。请使用其他记录。",
    ),
    "redirectToItemOptional": MessageLookupByLibrary.simpleMessage("跳转至商品（可选）"),
    "reenterTheSamePassword": MessageLookupByLibrary.simpleMessage(
      "请再次输入相同的密码",
    ),
    "registerRestaurant": MessageLookupByLibrary.simpleMessage("注册餐厅"),
    "registerRestaurantDescription": MessageLookupByLibrary.simpleMessage(
      "加入数千家商户。设置您的资料，上传标志，准备开始数字化服务。",
    ),
    "removeDiscount": MessageLookupByLibrary.simpleMessage("移除折扣"),
    "removeDiscountConfirmation": MessageLookupByLibrary.simpleMessage(
      "确定要移除此商品的折扣吗？",
    ),
    "removeDiscountTitle": MessageLookupByLibrary.simpleMessage("移除折扣"),
    "republishBanner": MessageLookupByLibrary.simpleMessage("重新发布横幅"),
    "requestProcessingFailed": MessageLookupByLibrary.simpleMessage(
      "处理请求时发生错误。",
    ),
    "requestTimedOut": MessageLookupByLibrary.simpleMessage("请求超时"),
    "requestTooSlow": MessageLookupByLibrary.simpleMessage(
      "操作完成时间过长。请检查网络速度或稍后重试。",
    ),
    "resendCode": MessageLookupByLibrary.simpleMessage("重新发送验证码"),
    "resendCodeIn": MessageLookupByLibrary.simpleMessage("重新发送验证码倒计时："),
    "restQrTagline": MessageLookupByLibrary.simpleMessage("您的餐厅，一扫即达。"),
    "restaurantAddress": MessageLookupByLibrary.simpleMessage("餐厅地址"),
    "restaurantAddressRequired": MessageLookupByLibrary.simpleMessage(
      "餐厅地址为必填项",
    ),
    "restaurantLocation": MessageLookupByLibrary.simpleMessage("餐厅位置"),
    "restaurantLocationRequired": MessageLookupByLibrary.simpleMessage(
      "餐厅位置为必填项",
    ),
    "restaurantName": MessageLookupByLibrary.simpleMessage("餐厅名称"),
    "restaurantNameHint": MessageLookupByLibrary.simpleMessage("请输入您的餐厅名称"),
    "restaurantNameRequired": MessageLookupByLibrary.simpleMessage("餐厅名称为必填项"),
    "salmonDescription": MessageLookupByLibrary.simpleMessage(
      "新鲜的大西洋三文鱼排，配柠檬黄油酱。",
    ),
    "save": MessageLookupByLibrary.simpleMessage("保存"),
    "saveCategory": MessageLookupByLibrary.simpleMessage("保存分类"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("保存更改"),
    "saveDataFailed": MessageLookupByLibrary.simpleMessage("保存数据时遇到问题。"),
    "saveItem": MessageLookupByLibrary.simpleMessage("保存商品"),
    "saveOffer": MessageLookupByLibrary.simpleMessage("保存优惠"),
    "saveToGallery": MessageLookupByLibrary.simpleMessage("保存到图库"),
    "savedToGalleryDescription": MessageLookupByLibrary.simpleMessage(
      "二维码图片已保存到您设备的图库。",
    ),
    "searchCountry": MessageLookupByLibrary.simpleMessage("搜索国家"),
    "secureAccountAccess": MessageLookupByLibrary.simpleMessage("安全访问账户"),
    "securityPlatformUpdates": MessageLookupByLibrary.simpleMessage("安全与平台更新"),
    "selectDateTime": MessageLookupByLibrary.simpleMessage("选择日期和时间"),
    "selectFont": MessageLookupByLibrary.simpleMessage("选择字体"),
    "selectMenuItem": MessageLookupByLibrary.simpleMessage("选择菜单商品"),
    "selectOfferItems": MessageLookupByLibrary.simpleMessage("选择此优惠中的商品"),
    "selectRestaurantLocation": MessageLookupByLibrary.simpleMessage(
      "点击选择您的餐厅位置",
    ),
    "serverFunctionNotFound": MessageLookupByLibrary.simpleMessage(
      "找不到请求的服务器函数。",
    ),
    "serverTimeout": MessageLookupByLibrary.simpleMessage("服务器响应时间过长。请重试。"),
    "serverTrouble": MessageLookupByLibrary.simpleMessage(
      "我们的服务器目前遇到问题，正在处理中。",
    ),
    "serverUnreachable": MessageLookupByLibrary.simpleMessage(
      "无法连接到服务器。请检查网络连接后重试。",
    ),
    "serviceUnavailable": MessageLookupByLibrary.simpleMessage("您要使用的服务当前不可用。"),
    "setDateTimeForOffer": MessageLookupByLibrary.simpleMessage(
      "为此优惠设置开始和结束日期",
    ),
    "share": MessageLookupByLibrary.simpleMessage("分享"),
    "shareFailed": MessageLookupByLibrary.simpleMessage("分享失败"),
    "shareQrCodeImage": MessageLookupByLibrary.simpleMessage("分享二维码图片"),
    "shareUrl": MessageLookupByLibrary.simpleMessage("分享网址"),
    "showAll": MessageLookupByLibrary.simpleMessage("显示全部"),
    "signInFailed": MessageLookupByLibrary.simpleMessage("无法登录。请稍后重试。"),
    "signInToContinue": MessageLookupByLibrary.simpleMessage("登录后继续管理您的餐厅。"),
    "signOut": MessageLookupByLibrary.simpleMessage("退出登录"),
    "signOutConfirmation": MessageLookupByLibrary.simpleMessage("确定要退出登录吗？"),
    "signUpFailed": MessageLookupByLibrary.simpleMessage("注册失败"),
    "signoutDescription": MessageLookupByLibrary.simpleMessage(
      "您需要重新登录才能访问您的控制面板。",
    ),
    "startDate": MessageLookupByLibrary.simpleMessage("开始日期"),
    "success": MessageLookupByLibrary.simpleMessage("成功"),
    "supportedImageFormats": MessageLookupByLibrary.simpleMessage(
      "支持的格式：JPG、PNG、JPEG",
    ),
    "systemAndGrowth": MessageLookupByLibrary.simpleMessage("系统与增长"),
    "systemError": MessageLookupByLibrary.simpleMessage("系统错误"),
    "systemUpdates": MessageLookupByLibrary.simpleMessage("系统更新"),
    "thisMonth": MessageLookupByLibrary.simpleMessage("本月"),
    "thisWeek": MessageLookupByLibrary.simpleMessage("本周"),
    "today": MessageLookupByLibrary.simpleMessage("今天"),
    "topCategories": MessageLookupByLibrary.simpleMessage("热门分类"),
    "topCategoriesDescription": MessageLookupByLibrary.simpleMessage("菜单分类概览"),
    "topItems": MessageLookupByLibrary.simpleMessage("热门商品"),
    "topItemsDescription": MessageLookupByLibrary.simpleMessage(
      "本周菜单中浏览量最高的商品",
    ),
    "totalClicks": m12,
    "totalMenuViews": MessageLookupByLibrary.simpleMessage("菜单总浏览量"),
    "totalMenuVisits": MessageLookupByLibrary.simpleMessage("菜单总访问量"),
    "unexpectedError": MessageLookupByLibrary.simpleMessage("意外错误"),
    "unexpectedErrorDescription": MessageLookupByLibrary.simpleMessage(
      "发生意外错误。请稍后重试。",
    ),
    "unsupportedFileFormat": MessageLookupByLibrary.simpleMessage("不支持此文件格式。"),
    "updateAvailable": MessageLookupByLibrary.simpleMessage("有可用更新"),
    "updateBanner": MessageLookupByLibrary.simpleMessage("更新横幅"),
    "updateDiscount": MessageLookupByLibrary.simpleMessage("更新折扣"),
    "updateLogo": MessageLookupByLibrary.simpleMessage("更新标志"),
    "updateLogoDescription": MessageLookupByLibrary.simpleMessage(
      "点击铅笔图标更新您的标志",
    ),
    "updateNow": MessageLookupByLibrary.simpleMessage("立即更新"),
    "updating": MessageLookupByLibrary.simpleMessage("更新中..."),
    "uploadBannerImage": MessageLookupByLibrary.simpleMessage("上传横幅图片"),
    "uploadCategoryImage": MessageLookupByLibrary.simpleMessage("上传分类图片"),
    "uploadClearPhotos": MessageLookupByLibrary.simpleMessage(
      "上传清晰的照片来吸引顾客关注此商品",
    ),
    "uploadError": MessageLookupByLibrary.simpleMessage("上传错误"),
    "uploadFoodImages": MessageLookupByLibrary.simpleMessage("上传菜品图片"),
    "uploadOfferImage": MessageLookupByLibrary.simpleMessage("上传优惠图片"),
    "uploadRestaurantLogo": MessageLookupByLibrary.simpleMessage("上传餐厅标志"),
    "userName": MessageLookupByLibrary.simpleMessage("用户名"),
    "username": MessageLookupByLibrary.simpleMessage("用户名"),
    "usernameHint": MessageLookupByLibrary.simpleMessage("请输入您的用户名"),
    "verificationCodeIntro": MessageLookupByLibrary.simpleMessage(
      "我们已向以下地址发送4位验证码：\n",
    ),
    "verify": MessageLookupByLibrary.simpleMessage("验证"),
    "verifyEmail": MessageLookupByLibrary.simpleMessage("验证电子邮箱"),
    "version": m13,
    "versionLoading": MessageLookupByLibrary.simpleMessage("RestoQR加载中..."),
    "visibleToCustomers": MessageLookupByLibrary.simpleMessage("对顾客可见"),
    "visibleToCustomersDescription": MessageLookupByLibrary.simpleMessage(
      "立即发布到您的数字菜单",
    ),
    "website": MessageLookupByLibrary.simpleMessage("网站"),
    "websiteChangesSaved": MessageLookupByLibrary.simpleMessage(
      "您的更改已保存，很快就会显示在数字菜单中。",
    ),
    "websiteCustomization": MessageLookupByLibrary.simpleMessage("网站自定义"),
    "websiteUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "网站更新成功！",
    ),
    "weekly": MessageLookupByLibrary.simpleMessage("本周"),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("欢迎回来"),
    "welcomeBackHome": MessageLookupByLibrary.simpleMessage("欢迎回来"),
  };
}
