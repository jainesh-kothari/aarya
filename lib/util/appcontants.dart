

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConstants {

  static final List BLUE_COLOR = [0xff00ADEF, 0xff8FD5EF,0xff0093fe,0xff006bfd,0xFF17ead9,0xFF6078ea];
  static final List GRAY_COLOR = [0xffe0e0e0, 0xff828282, 0xff9d9fa0,0xffe8e3e3,0xffedf0f4,0xffcedff6,0xffb8c7cb];
  static final List ORANGE_COLOR = [0xffff9900];
  static final List YELLOW_COLOR = [0xfffdcd03,0xfff9e3c9,0xffffe36a,0xfffde78b,0xffdddd08];
  static final List GREEN_COLOR = [0xffd3eed7];

  static final String RUPEE_SYMBOL = "\u20B9" ;

  LinearGradient gradient() {
    return const LinearGradient(colors: [Color(0xFF17ead9), Color(0xFF6078ea)]);
  }

  // Live url
  // static final String API_SERVICE_LINK = "https://www.gaadistand.com/api/";

  // Staging url
  static final String API_SERVICE_LINK = "http://sandbox.gaadistand.com/api/";

  static final String SAVE_USER = API_SERVICE_LINK + "save-user";
  static final String SAVE_DEVICE_DATA = API_SERVICE_LINK + "save-device-data"; // 1 FOR ANDROID AND 2 FOR IOS
  static final String SAVE_DEVICE_DATA_LOGIN = API_SERVICE_LINK + "save-device-data-login"; // 1 FOR ANDROID AND 2 FOR IOS
  static final String LIST_FEED = API_SERVICE_LINK + "list-feed";
  static final String LIST_FEED_LOGIN = API_SERVICE_LINK + "list-feed-login";
  static final String VERIFY_OTP = API_SERVICE_LINK + "verify-otp";
  static final String CREATE_FEED = API_SERVICE_LINK + "create-feed";
  static final String LIST_USER_FEED = API_SERVICE_LINK + "list-user-feed";
  static final String DISMISS_FEED = API_SERVICE_LINK + "dismiss-feed";
  static final String SHARE_WHATSAPP = API_SERVICE_LINK + "share-whatsapp";
  static final String CUSTOMER_CONTACT = API_SERVICE_LINK + "customer-contact";
  static final String VEHICLE_TYPES = API_SERVICE_LINK + "vehicle-types";
  static final String APP_UPDATE = API_SERVICE_LINK + "app-update";
  static final String COPY_FEED = API_SERVICE_LINK + "copy-feed";
  static final String OPTION_FEED = API_SERVICE_LINK + "option-feed";
  static final String APP_VERBIAGE = API_SERVICE_LINK + "app-verbiage";
  static final String INVITE_CODE_USE = API_SERVICE_LINK + "invite-code-use";
  static final String USER_REWARD_DETAIL = API_SERVICE_LINK + "user-reward-detail";
  static final String SAVE_USER_BANK_INFO = API_SERVICE_LINK + "save-user-bankinfo";
  static final String GET_USER_BANK_INFO = API_SERVICE_LINK + "get-user-bankinfo";
  static final String APP_BANK_INFO = API_SERVICE_LINK + "app-bank-info";
  static final String REDEEM_APPLY = API_SERVICE_LINK + "redeem-apply";
  static final String REDEEM_DETAIL = API_SERVICE_LINK + "get-redeem-detail";
  static final String ACCOUNT_HISTORY = API_SERVICE_LINK + "account-history";
  static final String NOTIFICATION_LIST = API_SERVICE_LINK + "get-user-pushnotification";
  static final String WELCOME_MESSAGE = API_SERVICE_LINK + "welcome-message";
  static final String USER_INVITE_SEND = API_SERVICE_LINK + "user-invite-send";
  static final String IMPORTANT_MESSAGE_SEARCHPOST = API_SERVICE_LINK + "important-message-searchpost";
  static final String REWARD_ICON_CLICK = API_SERVICE_LINK + "reward-icon-click";
  static final String USER_INVITE_CODE = API_SERVICE_LINK + "user-invite-code";
  static final String SAVE_SUPPLIER_PREFERRED_LOCATION = API_SERVICE_LINK + "save-supplier-preferred-location";
  static final String SUPPLIER_PREFERRED_LOCATION = API_SERVICE_LINK + "supplier-preferred-location";

  // shared_preferences values
  static const String KEY_IS_LOGGEDIN = "isLoggedIn";
  static const String LOGIN_AS = "login_as";
  static const String IS_ARYA = "IS_ARYA";
  static const String IS_GNM = "IS_GNM";
  static const String TOKEN = "token";


  static final String IS_FIRST_TIME_LOGIN = "is_first_time_login";
  static final String IS_FIRST_TIME_OPEN = "is_first_time_login";
  static final String INVITE_CODE = "invite_code";
  static final String SELECTED_LANGUAGE = "language ";
  static final String MOBILE_NUMBER = "mobile_number ";
  static final String IS_LOYALTY = "is_loyalty";

  static final String CREATE_POST_TAG = "create_post_tag";
  static final String CREATE_POST_TAG_HINDI = "create_post_tag_hi";
  static final String CREATE_POST_MSG = "create_post_msg";
  static final String CREATE_POST_POINT = "create_post_points";

  static final String SEARCH_POST_TAG = "search_post_tag";
  static final String SEARCH_POST_TAG_HINDI = "search_post_tag_hi";
  static final String SEARCH_POST_MSG = "search_post_msg";

  static final String INVITE_SCREEN_MSG_EN = "invite_screen_msg_en";
  static final String INVITE_SCREEN_MSG_HI = "invite_screen_msg_hi";
  static final String INVITE_FRIEND_MSG = "invite_friend_message";
  static final String INVITE_FRIEND_MSG_HINDI = "invite_friend_message_hi";

  static final String TUTORIAL_VIDEO_LINK = "youtube_link";
  static final String MISCELLANEOUS_LINK = "miscellaneous_link";
  static final String IMPORTANT_UPDATE = "important_update";
  static final String APPLICATION_TYPE = "application_type";

  static final String APP_STORE_URL = "https://apps.apple.com/in/app/gaadistand/id1546042513";
  static final String PLAY_STORE_URL = "https://play.google.com/store/apps/details?id=com.gaadistand.app";

}