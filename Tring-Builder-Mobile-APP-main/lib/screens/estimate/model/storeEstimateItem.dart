
class storeEstimateItem {
  int? squareFeet;
  int? pricePerSquareFeet;
  int? basicAmount;
  int? gst;
  int? flatId;
  OtherCharges? otherCharges;

  storeEstimateItem(
      {this.squareFeet,
        this.pricePerSquareFeet,
        this.basicAmount,
        this.gst,
        this.flatId,
        this.otherCharges});

  storeEstimateItem.fromJson(Map<String, dynamic> json) {
    squareFeet = json['squareFeet'];
    pricePerSquareFeet = json['pricePerSquareFeet'];
    basicAmount = json['basicAmount'];
    gst = json['gst'];
    flatId = json['flatId'];
    otherCharges = json['otherCharges'] != null
        ? new OtherCharges.fromJson(json['otherCharges'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['squareFeet'] = this.squareFeet;
    data['pricePerSquareFeet'] = this.pricePerSquareFeet;
    data['basicAmount'] = this.basicAmount;
    data['gst'] = this.gst;
    data['flatId'] = this.flatId;
    if (this.otherCharges != null) {
      data['otherCharges'] = this.otherCharges!.toJson();
    }
    return data;
  }
}

class OtherCharges {
  int? parking;
  int? maintenanceDeposite;
  int? preferentialLocationCharges;
  int? registrationFee;
  int? stampDuty;
  int? brokerageCharges;
  int? titleSalesDeedCharges;
  int? notaryFrankingCharges;
  int? mortgageCharges;
  int? otherCharges;
  int? clubMembership;
  int? civicAmenitiesCharges;
  int? externalDevelopmentCharges;
  int? infrastructureDevelopmentCharges;
  int? overheadCharges;
  int? insuranceFee;
  int? utilityCharges;
  int? homeInspectionCost;
  int? interiors;
  int? plumbing;
  int? furniture;
  int? electricWork;
  int? miscellaneousCharges;
  int? loanAmount;
  int? interestCharges;
  int? loanProcessingFee;
  int? prepaymentCharges;
  int? latePaymentCharges;
  int? applicationProcessingFee;

  OtherCharges(
      {this.parking,
        this.maintenanceDeposite,
        this.preferentialLocationCharges,
        this.registrationFee,
        this.stampDuty,
        this.brokerageCharges,
        this.titleSalesDeedCharges,
        this.notaryFrankingCharges,
        this.mortgageCharges,
        this.otherCharges,
        this.clubMembership,
        this.civicAmenitiesCharges,
        this.externalDevelopmentCharges,
        this.infrastructureDevelopmentCharges,
        this.overheadCharges,
        this.insuranceFee,
        this.utilityCharges,
        this.homeInspectionCost,
        this.interiors,
        this.plumbing,
        this.furniture,
        this.electricWork,
        this.miscellaneousCharges,
        this.loanAmount,
        this.interestCharges,
        this.loanProcessingFee,
        this.prepaymentCharges,
        this.latePaymentCharges,
        this.applicationProcessingFee});

  OtherCharges.fromJson(Map<String, dynamic> json) {
    parking = json['parking'];
    maintenanceDeposite = json['maintenanceDeposite'];
    preferentialLocationCharges = json['preferentialLocationCharges'];
    registrationFee = json['registrationFee'];
    stampDuty = json['stampDuty'];
    brokerageCharges = json['brokerageCharges'];
    titleSalesDeedCharges = json['titleSalesDeedCharges'];
    notaryFrankingCharges = json['notaryFrankingCharges'];
    mortgageCharges = json['mortgageCharges'];
    otherCharges = json['otherCharges'];
    clubMembership = json['clubMembership'];
    civicAmenitiesCharges = json['civicAmenitiesCharges'];
    externalDevelopmentCharges = json['externalDevelopmentCharges'];
    infrastructureDevelopmentCharges = json['infrastructureDevelopmentCharges'];
    overheadCharges = json['overheadCharges'];
    insuranceFee = json['insuranceFee'];
    utilityCharges = json['utilityCharges'];
    homeInspectionCost = json['homeInspectionCost'];
    interiors = json['interiors'];
    plumbing = json['plumbing'];
    furniture = json['furniture'];
    electricWork = json['electricWork'];
    miscellaneousCharges = json['miscellaneousCharges'];
    loanAmount = json['loanAmount'];
    interestCharges = json['interestCharges'];
    loanProcessingFee = json['loanProcessingFee'];
    prepaymentCharges = json['prepaymentCharges'];
    latePaymentCharges = json['latePaymentCharges'];
    applicationProcessingFee = json['applicationProcessingFee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parking'] = this.parking;
    data['maintenanceDeposite'] = this.maintenanceDeposite;
    data['preferentialLocationCharges'] = this.preferentialLocationCharges;
    data['registrationFee'] = this.registrationFee;
    data['stampDuty'] = this.stampDuty;
    data['brokerageCharges'] = this.brokerageCharges;
    data['titleSalesDeedCharges'] = this.titleSalesDeedCharges;
    data['notaryFrankingCharges'] = this.notaryFrankingCharges;
    data['mortgageCharges'] = this.mortgageCharges;
    data['otherCharges'] = this.otherCharges;
    data['clubMembership'] = this.clubMembership;
    data['civicAmenitiesCharges'] = this.civicAmenitiesCharges;
    data['externalDevelopmentCharges'] = this.externalDevelopmentCharges;
    data['infrastructureDevelopmentCharges'] =
        this.infrastructureDevelopmentCharges;
    data['overheadCharges'] = this.overheadCharges;
    data['insuranceFee'] = this.insuranceFee;
    data['utilityCharges'] = this.utilityCharges;
    data['homeInspectionCost'] = this.homeInspectionCost;
    data['interiors'] = this.interiors;
    data['plumbing'] = this.plumbing;
    data['furniture'] = this.furniture;
    data['electricWork'] = this.electricWork;
    data['miscellaneousCharges'] = this.miscellaneousCharges;
    data['loanAmount'] = this.loanAmount;
    data['interestCharges'] = this.interestCharges;
    data['loanProcessingFee'] = this.loanProcessingFee;
    data['prepaymentCharges'] = this.prepaymentCharges;
    data['latePaymentCharges'] = this.latePaymentCharges;
    data['applicationProcessingFee'] = this.applicationProcessingFee;
    return data;
  }
}