abstract class ApiInterface {
  static const baseUrl = "https://web-production-77a4.up.railway.app/";

  Future post(url, data);
  Future delete(url, data);
  Future put(url, data);
  Future get(url);
}
