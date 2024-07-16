import '../../../application/common/app_text.dart';
import '../../../application/common/custom_string_convertible.dart';

enum Tag implements CustomStringConvertible {
  concert, // 콘서트
  afterParty, // 뒷풀이
  giveAway; // 현장나눔

  @override
  String toCustomString() {
    switch (this) {
      case Tag.concert:
        return TagText.concert;
      case Tag.afterParty:
        return TagText.afterParty;
      case Tag.giveAway:
        return TagText.giveAway;
    }
  }
}
