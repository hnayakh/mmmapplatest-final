class AppConstants {
  static const ENDPOINT = "http://13.233.244.229/api/";

  static const HASOPENEDBEFORE = "ISFIRSTTIME";

  static String USERID = "USERID";
  static final EMAILREGEXP =
      r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
  static final PASSWORDREGEXP =
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d$@$!%*?&]{8,20}$";

  static final SUCCESS = "SUCCESS";
  static final FAILURE = "FAILURE";
}
