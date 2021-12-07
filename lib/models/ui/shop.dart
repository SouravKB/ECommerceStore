class Shop {
  final String shopId;
  final String? shopPicUrl;
  final String type;
  final List<String> emailIds;
  final List<String> phoneNos;
  final String address;
  final int openTime;
  final int closeTime;
  final bool isOpen;

  Shop({
    required this.shopId,
    required this.shopPicUrl,
    required this.type,
    required this.emailIds,
    required this.phoneNos,
    required this.address,
    required this.openTime,
    required this.closeTime,
    required this.isOpen,
  });
}
