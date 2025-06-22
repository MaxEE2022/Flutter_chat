import 'package:dio/dio.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/infrastructure/models/yes_no_model.dart';

class GetYesNoAnswer {
  final _dio = Dio();

  Future<Message> getAnswer() async {
    Response response;
    String url = 'https://yesno.wtf/api';
    response = await _dio.get(url);
    final data = response.data;
    final yesNoModel = YesNoModel.fromJsonMap(data);

    return yesNoModel.toMessageEntity();
  }
}
