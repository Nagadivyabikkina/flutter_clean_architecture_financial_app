// ignore: import_of_legacy_library_into_null_safe
import 'package:card_scanner/card_scanner.dart';
import 'package:clean_framework/clean_framework.dart';

class CardScannerPlugin extends ExternalDependency {
  Future<dynamic> scanCard() async {
    try {
      CardScanOptions scanOptions = CardScanOptions(
        scanCardHolderName: true,
        validCardsToScanBeforeFinishingScan: 2,
        possibleCardHolderNamePositions: [
          CardHolderNameScanPosition.belowCardNumber,
        ],
      );
      CardDetails cardDetails =
          await CardScanner.scanCard(scanOptions: scanOptions);

      if (cardDetails.expiryDate != null || cardDetails.cardNumber != null) {
        return cardDetails;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
