import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:resto_qr/Core/Utils/assets.dart';

abstract class PrintService {
  Future<void> print(Uint8List data);
}

class QrPrinter extends PrintService {
  @override
  Future<void> print(Uint8List qrImageData) async {
    try {
      final doc = pw.Document();

      final String svgRaw = await rootBundle.loadString(Assets.imagesLogo);

      final fontData = await rootBundle.load(
        "assets/fonts/Roboto/Roboto_Condensed-Regular.ttf",
      );

      final ttf = pw.Font.ttf(fontData);

      doc.addPage(
        pw.Page(
          pageFormat: .a4,
          build: (context) {
            return pw.Column(
              mainAxisAlignment: .center,
              children: [
                pw.Expanded(
                  child: pw.Image(pw.MemoryImage(qrImageData)),
                ),

                pw.Row(
                  mainAxisAlignment: .center,
                  children: [
                    pw.SvgImage(svg: svgRaw, width: 40, height: 40),

                    pw.SizedBox(width: 16),

                    pw.RichText(
                      text: pw.TextSpan(
                        text: 'Powered by ',
                        style: pw.TextStyle(
                          fontSize: 24,
                          color: PdfColors.black,
                          font: ttf,
                        ),
                        children: [
                          pw.TextSpan(
                            text: 'RestoQR',
                            style: pw.TextStyle(
                              fontSize: 24,
                              fontWeight: .bold,
                              color: PdfColors.black,
                              font: ttf,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );

      await Printing.layoutPdf(
        onLayout: (format) async => await doc.save(),
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
