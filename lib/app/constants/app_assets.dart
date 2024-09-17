const _root = "assets";
const _cards = "cards";
const _icons = "icons";

class AppImages {
  const AppImages._();
}

class SvgAssets {
  const SvgAssets._();

  static const _cardsPath = "$_root/$_cards";
  static const _iconsPath = "$_root/$_icons";

  static const card1 = "$_cardsPath/card_1.svg";
  static const card2 = "$_cardsPath/card_2.svg";
  static const card3 = "$_cardsPath/card_3.svg";
  static const card4 = "$_cardsPath/card_4.svg";

  static const backArrow = "$_iconsPath/back_arrow.svg";
  static const bus = "$_iconsPath/bus.svg";
  static const person = "$_iconsPath/person.svg";
  static const rightArrow = "$_iconsPath/right_arrow.svg";
}

class AppFonts {
  AppFonts._();

  static const primaryFamily = "BasierCircle";
}
