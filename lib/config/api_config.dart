
const baseURL = "https://idtm-media.s3.amazonaws.com/programming-test/api";
class APIConfig{

  apiHeader(String accessToken){
    return{'Authorization':'Bearer $accessToken'};
  }

  static getPlatformExceptionErrorResult(e) {
    if (e.response != null) {
      throw Exception(e.toString());
    } else {
     throw Exception();
    }
  }
}
