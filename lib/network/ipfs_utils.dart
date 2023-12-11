import 'package:dio/dio.dart';
import 'package:videolist/local/constant.dart';

class IpfsUtils {
  var dioClient = Dio()
    ..options =
        BaseOptions(headers: {'Authorization': 'Bearer ${ConstantS.apiKey}'});

  String ipfs = 'https://ipfs.infura.io:5001/api/v0/add?pin=false';

  Future<List<int>?> getByIpfsHash(String ipfsHash) async {
    List<int>? image;
    await dioClient.post('https://ipfs.infura.io:5001/api/v0/cat?arg=$ipfsHash',
        options: Options(
      responseDecoder: (responseBytes, options, responseBody) {
        image = responseBytes;
      },
    ));
    return image;
  }

  Future<String?> uploadImageToIPFS(String imagePath, String apiToken) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imagePath),
      });
      // 设置IPFS API请求头
      // 发起上传请求
      final response = await dioClient
          .post('https://ipfs.infura.io:5001/api/v0/add', data: formData);
      // 提取上传后的CID（内容识别码）
      final cid = response.data['Hash'];
      return cid;
    } catch (e) {
      // 处理错误
      print('上传图片到IPFS时出错：$e');
      return null;
    }
  }
}
