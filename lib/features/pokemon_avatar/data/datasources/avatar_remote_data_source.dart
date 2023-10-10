import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pokemon_clean_architecture/core/constants/constants.dart';
import 'package:pokemon_clean_architecture/core/params/params.dart';
import 'package:pokemon_clean_architecture/features/pokemon_avatar/data/models/avatar_image_model.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../core/errors/exceptions.dart';
import 'package:path_provider/path_provider.dart';

abstract class AvatarImageRemoteDataSource {
  Future<AvatarImageModel> getAvatarImage({required PokemonAvatarParams avatarImageParams});
}

class AvatarImageRemoteDataSourceImpl implements AvatarImageRemoteDataSource {
  final Dio dio;

  AvatarImageRemoteDataSourceImpl({required this.dio});

  @override
  Future<AvatarImageModel> getAvatarImage({required PokemonAvatarParams avatarImageParams}) async {
    ///Get and delete the files saved in the directory first;
    var pathFile = '';

    if (Platform.isIOS) {
      final dir = await getApplicationDocumentsDirectory();
      dir.deleteSync(recursive: true);
      pathFile = '${dir.path}/${avatarImageParams.name}.png';
    }
    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        status = await Permission.storage.request();
      }
      if (status.isGranted) {
        var dir = await getExternalStorageDirectory();
        dir?.deleteSync(recursive: true);
        pathFile = '${dir?.path}/${avatarImageParams.name}.png';
      } 
    }

    //Get the response from the api call
    final response = await dio.download(
      avatarImageParams.imageUrl,
      pathFile
    );

    ///Directly saving the path of the avatarImage
    if (response.statusCode == 200) {
      return AvatarImageModel.fromJson(json: {kPath : pathFile});
    } else {
      throw ServerException();
    }
  }
}
