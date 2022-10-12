import 'package:flutter/material.dart';

class IconsMap {

  static final Map<String, IconData> _map = {
    'account_balance_wallet': Icons.account_balance_wallet_rounded,
    "apartment": Icons.apartment_rounded,
    "approval": Icons.approval_rounded,
    "autorenew": Icons.autorenew,
    "badge": Icons.badge_outlined,
    'collections_bookmark': Icons.collections_bookmark_rounded,
    "corporate_fare": Icons.corporate_fare_rounded,
    "dialpad": Icons.dialpad_rounded,
    "domain": Icons.domain_rounded,
    "directions_car": Icons.directions_car_rounded,
    'history': Icons.history_rounded,
    "history_edu": Icons.history_edu_rounded,
    "home": Icons.home_rounded,
    "home_repair_service": Icons.home_repair_service_rounded,
    'list_alt': Icons.list_alt_rounded,
    'monetization_on': Icons.monetization_on_rounded,
    'money_rounded': Icons.money_rounded,
    'fact_check': Icons.fact_check_outlined,
    'tag': Icons.tag_rounded,
    'language': Icons.language_rounded,
    "request_page": Icons.request_page_rounded,
    "money": Icons.money_rounded,
    "request_quote": Icons.request_quote_rounded,
    "local_atm": Icons.local_atm_rounded,
    "redeem": Icons.redeem_rounded,
    "recent_actors": Icons.recent_actors_rounded,
    "feed": Icons.feed_rounded,
    "storefront": Icons.storefront_rounded,
    "toll": Icons.toll_rounded,
    "grid_goldenratio": Icons.grid_goldenratio_rounded,
    "meeting_room": Icons.meeting_room_rounded,
    "first_page": Icons.first_page_rounded,
    "forward_10": Icons.forward_10_rounded,
    'paid': Icons.paid_rounded,
    'password': Icons.password_rounded,
    'payment': Icons.payment_rounded,
    "pin": Icons.pin_outlined,
    'price_change': Icons.price_change_rounded,
    'swap_horizontal_circle': Icons.swap_horizontal_circle_rounded,
    // "density_small": Icons.density
  };

  static IconData? get(String? name) {
    if (name == null)
      return null;
    return _map[name];
  }

}
