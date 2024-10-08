const _root = "assets";
const _cards = "cards";
const _icons = "icons";
const _images = "images";

class AppImages {
  const AppImages._();

  static const _imagesPath = "$_root/$_images";

  static const barcode = "$_imagesPath/barcode.png";
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
  static const bookingDone = "$_iconsPath/booking_done.svg";
}

class AppFonts {
  AppFonts._();

  static const primaryFamily = "BasierCircle";
}
