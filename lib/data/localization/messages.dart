import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'play_button': 'Play',
          'inventory_button': 'Inventory',
          'market_button': 'Market',
          'settings_button': 'Settings',
        },
        'tr_TR': {
          'play_button': 'Oyna',
          'inventory_button': 'Envanter',
          'market_button': 'Mağaza',
          'settings_button': 'Ayarlar',
        },
      };
}
