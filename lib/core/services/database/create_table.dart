import 'package:sqflite/sqflite.dart';
import 'database_const.dart';

class CreateTable {
  Database db;
  CreateTable(this.db);

  /// Category List Table
  categoryListTable() async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${DatabaseDetails.categoryListTable} (
        ${DatabaseDetails.catagory} TEXT,
        ${DatabaseDetails.amount} TEXT
      )
    ''');
  }

  //Login Company Data
  companyListTable() async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${DatabaseDetails.companyListTable} (
        ${DatabaseDetails.companyDBName} TEXT,
        ${DatabaseDetails.companyName} TEXT,
        ${DatabaseDetails.ledgerCode} TEXT,
        ${DatabaseDetails.auth} TEXT,
        ${DatabaseDetails.post} TEXT,
        ${DatabaseDetails.initial} TEXT,
        ${DatabaseDetails.startDate} TEXT,
        ${DatabaseDetails.endDate} TEXT,
        ${DatabaseDetails.companyAddress} TEXT,
        ${DatabaseDetails.phoneNo} TEXT,
        ${DatabaseDetails.vatNo} TEXT,
        ${DatabaseDetails.email} TEXT,
        ${DatabaseDetails.aliasName} TEXT
      )
    ''');
  }

  //Product Create Table
  productListTable() async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${DatabaseDetails.productListTable} (
        ${DatabaseDetails.productName} TEXT,
        ${DatabaseDetails.productQuantity} TEXT,
        ${DatabaseDetails.purchaseRate} TEXT,
        ${DatabaseDetails.salesRate} TEXT,
        ${DatabaseDetails.unit} TEXT, 
        ${DatabaseDetails.productImage} TEXT
      )
    ''');
  }

  productCreateTable() async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS ${DatabaseDetails.productCreateTable} (
      ${DatabaseDetails.pCode} TEXT,      
                                                ${DatabaseDetails.pDesc} TEXT,      
                                                ${DatabaseDetails.pShortName} TEXT,      
                                                ${DatabaseDetails.grpName} TEXT,      
                                                ${DatabaseDetails.subGrpName} TEXT,      
                                                ${DatabaseDetails.group1} TEXT,      
                                                ${DatabaseDetails.group2} TEXT,      
                                                ${DatabaseDetails.unit} TEXT,
                                                ${DatabaseDetails.buyRate} TEXT,
                                                ${DatabaseDetails.salesRate} TEXT,
                                                ${DatabaseDetails.mrp} TEXT,
                                                ${DatabaseDetails.tradeRate} TEXT,
                                                [${DatabaseDetails.discountPercent}] TEXT,
                                                [${DatabaseDetails.imageName}] TEXT,
                                                ${DatabaseDetails.pImage} TEXT,
                                                [${DatabaseDetails.imageFolderName}] TEXT,
                                                [${DatabaseDetails.offerDiscount}] TEXT,
                                                ${DatabaseDetails.stockStatus} TEXT,
                                                ${DatabaseDetails.stockQty} TEXT
   )
  ''');
  }

  //Sales Bill List Table
  salesReportTable() async {
    await db.execute(
        ''' CREATE TABLE if not exists ${DatabaseDetails.salesReportTable} (
                                                ${DatabaseDetails.billDate} TEXT,
                                                ${DatabaseDetails.billNo} TEXT,
                                                ${DatabaseDetails.glDesc} TEXT,
                                                ${DatabaseDetails.salesType} TEXT,
                                                ${DatabaseDetails.netAmount} TEXT
                                              ) ''');
  }

  //Sales Bill Report Table for the Individual Bill
  salesBillReportListTable() async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${DatabaseDetails.salesBillReportListTable} (
        ${DatabaseDetails.hVno} TEXT,
        ${DatabaseDetails.hDate} TEXT,
        ${DatabaseDetails.hMiti} TEXT,
        ${DatabaseDetails.hGlDesc} TEXT,
        ${DatabaseDetails.hGlCode} TEXT,
        ${DatabaseDetails.hPanNo} TEXT,
        ${DatabaseDetails.hMobileNo} TEXT,
        ${DatabaseDetails.hAgent} TEXT,
        ${DatabaseDetails.dSno} TEXT,
        ${DatabaseDetails.dPDesc} TEXT,
        ${DatabaseDetails.dQty} TEXT,
        ${DatabaseDetails.dAltQty} TEXT,
        ${DatabaseDetails.dLocalRate} TEXT,
        ${DatabaseDetails.dBasicAmt} TEXT,
        ${DatabaseDetails.dTermAMt} TEXT,
        ${DatabaseDetails.dNetAmt} TEXT,
        ${DatabaseDetails.unitCode} TEXT,
        ${DatabaseDetails.altUnitCode} TEXT,
        ${DatabaseDetails.Address} TEXT,
        ${DatabaseDetails.hTermAMt} TEXT,
        ${DatabaseDetails.hBasicAMt} TEXT,
        ${DatabaseDetails.hNetAmt} TEXT,
        ${DatabaseDetails.balanceAmt} TEXT
      )
    ''');
  }

  customerListTable() async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${DatabaseDetails.customerListTable} (
        ${DatabaseDetails.category} TEXT,
        ${DatabaseDetails.glDesc} TEXT,
        ${DatabaseDetails.glCode} TEXT,
        ${DatabaseDetails.accountGroup} TEXT,
        ${DatabaseDetails.accountSubGroup} TEXT,
        ${DatabaseDetails.glShortName} TEXT,
        ${DatabaseDetails.amount} TEXT,
        ${DatabaseDetails.address} TEXT,
        ${DatabaseDetails.mobileno} TEXT,
        ${DatabaseDetails.panNo} TEXT
      )
    ''');
  }

}



