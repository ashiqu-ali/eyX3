import 'dart:convert';
import 'package:http/http.dart' as http;

class IPFSService {
  final String _pinataApiKey = 'YOUR_PINATA_API_KEY';
  final String _pinataSecretApiKey = 'YOUR_PINATA_SECRET_API_KEY';
  final String _pinataUrl = 'https://api.pinata.cloud/pinning/pinJSONToIPFS';

  Future<String?> uploadJson(Map<String, dynamic> json,
      {required String name}) async {
    try {
      final response = await http.post(
        Uri.parse(_pinataUrl),
        headers: {
          'Content-Type': 'application/json',
          'pinata_api_key': _pinataApiKey,
          'pinata_secret_api_key': _pinataSecretApiKey,
        },
        body: jsonEncode({
          'pinataOptions': {'cidVersion': 1},
          'pinataMetadata': {'name': name},
          'pinataContent': json,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['IpfsHash'];
      } else {
        print('Error uploading JSON: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error uploading JSON: $e');
      return null;
    }
  }
}
