abstract class ApiInterface {
  static const baseUrl = "https://web-production-2a3d.up.railway.app/";
  // static const baseUrl = "http://localhost:8000/";

  Future post(url, data);
  Future delete(url, data);
  Future put(url, data);
  Future get(url);
}
