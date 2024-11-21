class LoanReqEntity{
  String? typeOfLoan;
  String? loanAmount;
  String? loanPeriod;
  String? monthlyIncome;
  String? title;
  String? fName;
  String? lName;
  String? nicNumber;
  String? address1;
  String? address2;
  String? address3;

  LoanReqEntity(
      {this.typeOfLoan,
        this.loanAmount,
        this.loanPeriod,
        this.monthlyIncome,
        this.title,
        this.fName,
        this.lName,
        this.nicNumber,
        this.address1,
        this.address2,
        this.address3});
}