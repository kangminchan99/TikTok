// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
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
  String get localeName => 'ko';

  static String m0(commentCount) => "${commentCount}";

  static String m1(value, value2) =>
      "${value} ${Intl.plural(value2, zero: '댓글', one: '댓글들', other: '댓글들')}";

  static String m2(likeCount) => "${likeCount}";

  static String m3(gender) => "로그인";

  static String m5(videoCount) =>
      "프로필을 만들고, 다른 계정을 팔로우하고, 자신의 동영상을 만들고, 그 이상을 해보세요.";

  static String m6(nameOfTheApp, when) => "${nameOfTheApp}에 가입하세요 ${when}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "alreadyHaveAnAccount": MessageLookupByLibrary.simpleMessage("이미 계정이 있나요?"),
    "appleButton": MessageLookupByLibrary.simpleMessage("Apple로 계속하기"),
    "commentCount": m0,
    "commentTitle": m1,
    "emailPasswordButton": MessageLookupByLibrary.simpleMessage(
      "이메일 & 비밀번호 사용",
    ),
    "likeCount": m2,
    "logIn": m3,
    "signUpSubtitle": m5,
    "signUpTitle": m6,
  };
}
