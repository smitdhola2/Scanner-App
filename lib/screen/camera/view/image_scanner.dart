import 'dart:io';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class ImageScanner {
  static Future<String?> scanImage(File imageFile) async {
    final scanner = BarcodeScanner(formats: [BarcodeFormat.all]);
    final inputImage = InputImage.fromFile(imageFile);
    final barcodes = await scanner.processImage(inputImage);
    await scanner.close();

    if (barcodes.isNotEmpty) {
      return barcodes.first.rawValue ?? 'No data found';
    } else {
      return null;
    }
  }
}
