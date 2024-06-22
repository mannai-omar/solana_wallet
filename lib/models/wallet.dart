class Wallet {
  final String walletName;
  final String userPin;
  final String network;
  final String publicKey;
  final List<int> secretKey; 

  Wallet({
    required this.walletName,
    required this.userPin,
    required this.network,
    required this.publicKey,
    required this.secretKey,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      walletName: json['walletName'],
      userPin: json['userPin'],
      network: json['network'],
      publicKey: json['publicKey'],
      secretKey: List<int>.from(json['secretKey']),
    );
  }
}
