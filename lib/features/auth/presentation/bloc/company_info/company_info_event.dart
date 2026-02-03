abstract class CompanyInfoEvent {}

class CompanyNameChangedEvent extends CompanyInfoEvent {
  final String companyName;
  CompanyNameChangedEvent(this.companyName);
}

class FirstNameChangedEvent extends CompanyInfoEvent {
  final String firstName;
  FirstNameChangedEvent(this.firstName);
}

class LastNameChangedEvent extends CompanyInfoEvent {
  final String lastName;
  LastNameChangedEvent(this.lastName);
}

class SubmitCompanyInfoEvent extends CompanyInfoEvent {}
