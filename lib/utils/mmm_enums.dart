enum Gender {
  Male,
  Female,
  Other,
}


enum CallType {
  audioCall,
  videoCall
}

extension CallTypeExtension on CallType {


  String get label {
    switch(this){

      case CallType.audioCall:
        {
          return "Audio";
        }
      case CallType.videoCall:
        {
          return "Video";
        }
    }
  }
}

enum Relationship { Self, Son, Daughter, Sister, Brother, Friend, Relative }

enum MaritalStatus { NeverMarried, Divorced, Widowed, AwaitingDivorce }

enum MaritalStatusFilter {
  DoesnotMatter,
  NeverMarried,
  Divorced,
  Widowed,
  AwaitingDivorce
}

enum ProfileActivationStatus { Pending, Verified }

enum AbilityStatus {
  Normal,
  PhysicallyChallenged,
}

enum NoOfChildren { One, Two, ThreeOrMore }

enum ChildrenStatus { No, YesLivingTogether, YesNotLivingTogether }
enum ProposalStatus { Sent, Accepted, Rejected, Reverted, Received }

enum EatingHabit {
  Notspecified,
  Vegetarrian,
  Eggitarrian,
  Nonvegetarrian,
}

enum EatingHabitFilter {
  DoesnotMatter,
  Vegetarrian,
  Eggitarrian,
  Nonvegetarrian,
}

enum SmokingHabit {
  Notspecified,
  Smoker,
  NonSmoker,
  Occasionally,
}

enum SmokingHabitFilter {
  DoesnotMatter,
  Smoker,
  NonSmoker,
  Occasionally,
}

enum DrinkingHabit {
  Notspecified,
  Alcoholic,
  Nonalcoholic,
  Occasionally,
}

enum DrinkingHabitFilter {
  DoesnotMatter,
  Alcoholic,
  Nonalcoholic,
  Occasionally,
}

enum IdProofType { Passport, VoterIdCard, AadharCard, DrivingLicence, PanCard }

enum FamilyType { Nuclear, Joint, Other, Notmentioned }

enum FamilyValues {Orthodox ,  Conservative, Moderate, Liberal, NotMentioned }

enum FamilyAfluenceLevel {
  Rich,
  UpperMiddleClass,
  MiddleClass,
  LowerMiddleClass,
  NotMentioned
}

enum FatherOccupation {
  Employed,
  Business,
  Retired,
  NotEmployed,
  PassedAway,
  NotMentioned
}

enum MotherOccupation {
  HomeMaker,
  Employed,
  Business,
  Retired,
  PassedAway,
  NotMentioned
}

enum HeightStatus {
  lessthan5feet,
  lessthan5andhalffeet,
  lessthan6feet,
  greaterthan6feet
}

enum ProfileUpdationStatus {
  Current,
  Pending,
  Archived,
}

enum ActivationStatus {
  Pending,
  Verified,
  Rejected,
}

enum LifecycleStatus {
  Active,
  Blocked,
}

enum RegistrationSteps {
  Basic,
  About,
  Religion,
  Career,
  FamilyBackground,
  FamilyDetail,
  Habit,
  BioWithImages,
  PendingVerification,
  Completed,
}

enum OtpType {
  Registration,
  Login,
  ForgotPassword,
}

enum Manglik { Yes('Yes'), No('No'), NotApplicable('Not Applicable');

final String label;
const Manglik(this.label);
}

enum ManglikFilter { DoesnotMatter, Yes, No, NotApplicable }

enum EmployeedInFilter {
  DoesnotMatter,
  PrivateJob,
  BusinessOrSelfEmployeed,
  GovernmentJob
}

enum InterestFilter {
  DoesnotMatter,
  Sports,
  Travel,
  Photography,
  Gaming,
  Singing,
  Dance,
  Food,
  Music,
  Art,
  Cooking,
  Fashion,
  vblogging,
  Animals,
  Nature,
  Tech,
  Social
}

enum AnnualIncome {
  NoIncome,
  LessThanOneLacs,
  OneToTwoLacs,
  TwoToThreeLacs,
  ThreeToFourLacs,
  FourToFiveLacs,
  FiveToSevenPointFiveLacs,
  SevenPointFiveToTenLacs,
  TenToFifteenLacs,
  FifteenToTwentyLacs,
  TwentyToTwentyFivelacs,
  TwentyFiveToThirtyFiveLacs,
  ThirtyFiveToFiftyLacs,
  FiftyToSeventyFiveLacs,
  SeventyFiveLacToOneCrore,
  MoreThanOneCrore,
  NotMentioned
}

enum Index { test }
