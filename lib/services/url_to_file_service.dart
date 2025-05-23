import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

Future<File?> urlToFile({required String imageUrl}) async {
  // 1. URL'den resmi indir
  final response = await http.get(Uri.parse(imageUrl));

  // 2. Geçici klasörü al
  final tempDir = await getTemporaryDirectory();

  // 3. Dosya adını URL'den al
  final fileName = basename(imageUrl);

  // 4. Dosya yolu oluştur
  final filePath = '${tempDir.path}/$fileName';

  // 5. Veriyi dosyaya yaz
  final file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);

  return file;
}
