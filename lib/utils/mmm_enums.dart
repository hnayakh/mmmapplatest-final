enum Gender {
  Male,
  Female,
  Other,
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

enum AbilityStatus {
  Normal,
  PhysicallyChallenged,
}
enum NoOfChildren { One, Two, ThreeOrMore }
enum ChildrenStatus { No, YesLivingTogether, YesNotLivingTogether }

enum EatingHabit {
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

enum FamilyType { Nuclear, Joint, Other }

enum FamilyValues { Traditional, Moderate, Liberal }

enum FamilyAfluenceLevel {
  Rich,
  UpperMiddleClass,
  MiddleClass,
  LowerMiddleClass
}

enum FatherOccupation { Employed, Business, Retired, NotEmployed, PassedAway }

enum MotherOccupation { HomeMaker, Employed, Business, Retired, PassedAway }
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
  Habit,
  Religion,
  Career,
  FamilyBackground,
  FamilyDetail,
  BioWithImages,
  PendingVerification,
  Completed,
}

enum OtpType {
  Registration,
  Login,
  ForgotPassword,
}
enum Manglik { Yes, No, NotApplicable }
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
