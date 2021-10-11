class AppConstants {
  static const ENDPOINT = "http://13.233.190.102:3000/api/";

  static const HASOPENEDBEFORE = "ISFIRSTTIME";

  static String USERID = "USERID";
  static String MOBILE = "MOBILE";
  static String EMAIL = "EMAIL";
  static String DIALCODE = "DIALCODE";
  static String ISACTIVE = "ISACTIVE";
  static String REGISTRATIONSTEP = "REGISTRATIONSTEP";
  static String ACTIVATIONSTATUS = "ACTIVATIONSTATUS";
  static String LIFECYCLESTATUS = "LIFECYCLESTATUS";
  static String GENDER = "GENDER";
  static final EMAILREGEXP =
      r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
  static final PASSWORDREGEXP =
      r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&#]{8,16}$";

  static final SUCCESS = "SUCCESS";
  static final FAILURE = "FAILURE";
  static final DATEFORMAT = 'dd MMM yyyy';
  static final SERVERDATEFORMAT = 'yyyy-MM-dd';

  static final PUBLICIMAGEBASEURL = "https://mmm-user-image.s3.ap-south-1.amazonaws.com/";
}
