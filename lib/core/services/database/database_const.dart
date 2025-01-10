
import '../../config/app_Details.dart';

class DatabaseDetails {
  static String databaseName = AppDetails.appName;
  static int dbVersion = 1;

  ///
  static String categoryListTable = "CategoryListTable";
  static String catagory = "Catagory";
  static String amount = "Amount";


  //Company Details Table
  static String companyListTable = "CompanyListTable";
  static String companyDBName = "DbName";
  static String companyName = "CompanyName";
  static String ledgerCode = "LedgerCode";
  static String auth = "Auth";
  static String post = "Post";
  static String initial = "Initial";
  static String startDate = "StartDate";
  static String endDate = "EndDate";
  static String companyAddress = "CompanyAddress";
  static String phoneNo = "PhoneNo";
  static String vatNo = "VatNo";
  static String email = "Email";
  static String aliasName = "AliasName";

 //Product Database
  static String productListTable = "ProductListTable";
  static String productName = "ProductName";
  static String productQuantity = "ProductQuantity";
  static String purchaseRate = "PurchaseRate";
  static String salesRate = "SalesRate";
  static String unit = "Unit";
  static String productImage = "ProductImage";

  //The data of the product using the API
  static String productCreateTable = "ProductCreateTable";
  static String id = "Id";
  static String pCode = "PCode";
  static String pDesc = "PDesc";
  static String pShortName = "PShortName";
  static String grpName = "GroupName";
  static String subGrpName = "SubGroupName";
  static String group1 = "Group1";
  static String group2 = "Group2";
  static String buyRate = "BuyRate";
  static String mrp = "MRP";
  static String tradeRate = "TradeRate";
  static String discountPercent = "Discount Percentage";
  static String imageName = "Image Name";
  static String pImage = "PImage";
  static String imageFolderName = "Image Folder Name";
  static String offerDiscount = "Offer Discount";
  static String stockStatus = "StockStatus";
  static String stockQty = "StockQty";

  //Sales Report Table
  static String  salesReportTable = "SalesReportTable";
  static String billDate = "BillDate";
  static String  billNo ="BillNo";
  static String salesType ="SalesType";
  static String netAmount ="NetAmount";
  static String glDesc ="GlDesc";

  //Sales Bill Report Table
  static String salesBillReportListTable = "SalesBillReportListTable";
  static String hVno = "HVno";
  static String hDate = "HDate";
  static String hMiti = "HMiti";
  static String hGlDesc = "HGlDesc";
  static String hGlCode = "HGlCode";
  static String hPanNo = "HPanNo";
  static String hMobileNo = "HMobileNo";
  static String hAgent = "HAgent";
  static String dSno = "DSno";
  static String dPDesc = "DPDesc";
  static String dQty = "DQty";
  static String dAltQty = "DAltQty";
  static String dLocalRate = "DLocalRate";
  static String dBasicAmt = "DBasicAmt";
  static String dTermAMt = "DTermAMt";
  static String dNetAmt = "DNetAmt";
  static String unitCode = "UnitCode";
  static String altUnitCode = "AltUnitCode";
  static String Address = "Address";
  static String hTermAMt = "HTermAMt";
  static String hBasicAMt = "HBasicAMt";
  static String hNetAmt = "HNetAmt";
  static String balanceAmt = "BalanceAmt";

  static String customerListTable = "CustomerListTable";
  static String category = "Catagory";
  static String glCode = "GlCode";
  static String accountGroup = "AccountGroup";
  static String accountSubGroup = "AccountSubGroup";
  static String glShortName = "Glshortname";
  static String address = "Address";
  static String mobileno = "MobileNo";
  static String panNo = "PanNo";

}
