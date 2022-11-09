class AppConstants {
  static const ENDPOINT = "http://192.168.0.149:3000/api/";
  //static const ENDPOINT = "http://13.233.130.85:3000/api/";
  static const HASOPENEDBEFORE = "ISFIRSTTIME";

  static String USERID = "USERID";
  static String DISPLAYID = "DISPLAYID";
  static String MOBILE = "MOBILE";
  static String EMAIL = "EMAIL";
  static String DIALCODE = "DIALCODE";
  static String ISACTIVE = "ISACTIVE";
  static String REGISTRATIONSTEP = "REGISTRATIONSTEP";
  static String DATEOFBIRTH = "DATEOFBIRTH";
  static String HEIGHT = "HEIGHT";
  static String MARITALSTATUS = "MARITALSTATUS";
  static String COUNTRYMODELNAME = "COUNTRYMODELNAME";
  static String COUNTRYMODELSHORTNAME = "COUNTRYMODELSHORTNAME";
  static String COUNTRYMODELID = "COUNTRYMODELID";
  static String RELIGIONID = "RELIGIONID";
  static String RELIGIONTITLE = "RELIGIONTITLE";
  static String MOTHERTONGUEID = "MOTHERTONGUEID";
  static String MOTHERTONGUETITLE = "MOTHERTONGUETITLE";
  static String ABILITYSTATUS = "ABILITYSTATUS";
  static String RELATIONSHIP = "RELATIONSHIP";

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
  static final SERVERDATETIMEFORMAT = 'yyyy-MM-dd hh:mm';

  static final PUBLICIMAGEBASEURL =
      "https://mmm-user-image.s3.ap-south-1.amazonaws.com/";
}
