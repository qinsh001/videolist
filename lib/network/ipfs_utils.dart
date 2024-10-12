import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:videolist/local/constant.dart';

class IpfsUtils {
  final String _baseUrl = 'https://ipfs.infura.io:5001/api/v0';
  final Map<String, String> _headers = {
    'Authorization': 'Bearer ${ConstantS.apiKey}'
  };

  Future<List<int>?> getByIpfsHash(String ipfsHash) async {
    final url = Uri.parse('$_baseUrl/cat?arg=$ipfsHash');
    final response = await http.post(url, headers: _headers);

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      print('Failed to get IPFS content: ${response.statusCode}');
      return null;
    }
  }

  Future<String?> uploadImageToIPFS(String imagePath, String apiToken) async {
    try {
      final url = Uri.parse('$_baseUrl/add');
      final request = http.MultipartRequest('POST', url)
        ..headers.addAll(_headers)
        ..files.add(await http.MultipartFile.fromPath('file', imagePath));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData['Hash'];
      } else {
        print('Failed to upload image to IPFS: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error uploading image to IPFS: $e');
      return null;
    }
  }
}