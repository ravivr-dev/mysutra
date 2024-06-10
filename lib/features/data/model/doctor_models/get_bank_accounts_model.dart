class GetBankAccountsModel {

  int? count;
  List<BankAccountModel>? items;

  GetBankAccountsModel({ this.count, this.items});

  GetBankAccountsModel.fromJson(Map<String, dynamic> json) {

    count = json['count'];
    if (json['data'] != null) {
      items = <BankAccountModel>[];
      json['data'].forEach((v) {
        items!.add(BankAccountModel.fromJson(v));
      });
    }
  }
}

class BankAccountModel {
  String? id;
  String? entity;
  String? contactId;
  String? accountType;
  BankAccount? bankAccount;
  String? batchId;
  bool? active;
  int? createdAt;
  Vpa? vpa;

  BankAccountModel(
      {this.id,
      this.entity,
      this.contactId,
      this.accountType,
      this.bankAccount,
      this.batchId,
      this.active,
      this.createdAt,
      this.vpa});

  BankAccountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entity = json['entity'];
    contactId = json['contact_id'];
    accountType = json['account_type'];
    bankAccount = json['bank_account'] != null
        ? BankAccount.fromJson(json['bank_account'])
        : null;
    batchId = json['batch_id'];
    active = json['active'];
    createdAt = json['created_at'];
    vpa = json['vpa'] != null ? Vpa.fromJson(json['vpa']) : null;
  }
}

class BankAccount {
  String? ifsc;
  String? bankName;
  String? name;
  // List<String>? notes;
  String? accountNumber;

  BankAccount({this.ifsc, this.bankName, this.name, this.accountNumber});

  BankAccount.fromJson(Map<String, dynamic> json) {
    ifsc = json['ifsc'];
    bankName = json['bank_name'];
    name = json['name'];
    // if (json['notes'] != null) {
    //   notes = <Null>[];
    //   json['notes'].forEach((v) {
    //     notes!.add(Null.fromJson(v));
    //   });
    // }
    accountNumber = json['account_number'];
  }
}

class Vpa {
  String? username;
  String? handle;
  String? address;

  Vpa({this.username, this.handle, this.address});

  Vpa.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    handle = json['handle'];
    address = json['address'];
  }
}
