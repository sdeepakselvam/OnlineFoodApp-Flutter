class ProductListResponse {
  bool success;
  int statusCode;
  String timestamp;
  ProductData data;

  ProductListResponse(
      {this.success, this.statusCode, this.timestamp, this.data});

  ProductListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    timestamp = json['timestamp'];
    data = json['data'] != null ? new ProductData.fromJson(json['data']) : null;
  }
}

class ProductData {
  int items;
  List<Products> products;
  DateHub dateHub;

  ProductData({this.items, this.products, this.dateHub});

  ProductData.fromJson(Map<String, dynamic> json) {
    items = json['items'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    dateHub = json['hub'] != null ? new DateHub.fromJson(json['hub']) : null;
  }
}

class Products {
  int id;
  String name;
  int sellingPrice;
  int maximumRetailPrice;
  int maximumOrderQuantity;
  List<String> badgeTags;
  bool onlyPreorder;
  String deliveryCategory;
  Unit unit;
  List<ProductVariants> productVariants;
  Hub category;
  Image icon;
  Image image;
  List<String> availableSlots;
  bool isFavorite;
  List<String> promotions;
  bool isPrimary;
  int expressDeliveryIn;

  Products(
      {this.id,
      this.name,
      this.sellingPrice,
      this.maximumRetailPrice,
      this.maximumOrderQuantity,
      this.badgeTags,
      this.onlyPreorder,
      this.deliveryCategory,
      this.unit,
      this.productVariants,
      this.category,
      this.icon,
      this.image,
      this.availableSlots,
      this.isFavorite,
      this.promotions,
      this.isPrimary,
      this.expressDeliveryIn});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sellingPrice = json['sellingPrice'];
    maximumRetailPrice = json['maximumRetailPrice'];
    maximumOrderQuantity = json['maximumOrderQuantity'];
    // badgeTags = json['badgeTags'].cast<String>();
    onlyPreorder = json['onlyPreorder'];
    deliveryCategory = json['deliveryCategory'];
    unit = json['unit'] != null ? new Unit.fromJson(json['unit']) : null;
    if (json['productVariants'] != null) {
      productVariants = new List<ProductVariants>();
      json['productVariants'].forEach((v) {
        productVariants.add(new ProductVariants.fromJson(v));
      });
    }
    category =
        json['category'] != null ? new Hub.fromJson(json['category']) : null;
    icon = json['icon'] != null ? new Image.fromJson(json['icon']) : null;
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    // if (json['availableSlots'] != null) {
    //   availableSlots = new List<String>();
    //   json['availableSlots'].forEach((v) { availableSlots.add(new Null.fromJson(v)); });
    // }
    isFavorite = json['isFavorite'];
    promotions = json['promotions'].cast<String>();
    isPrimary = json['isPrimary'];
    expressDeliveryIn = json['expressDeliveryIn'];
  }
}

class Unit {
  String code;
  String name;

  Unit({this.code, this.name});

  Unit.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
  }
}

class ProductVariants {
  int id;
  String name;
  String description;
  int maximumRetailPrice;
  int unitValue;
  int grossWeightValue;
  String noOfPieces;
  Image image;
  HubInformation hubInformation;

  ProductVariants(
      {this.id,
      this.name,
      this.description,
      this.maximumRetailPrice,
      this.unitValue,
      this.grossWeightValue,
      this.noOfPieces,
      this.image,
      this.hubInformation});

  ProductVariants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    maximumRetailPrice = json['maximumRetailPrice'];
    unitValue = json['unitValue'];
    grossWeightValue = json['grossWeightValue'];
    noOfPieces = json['noOfPieces'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    hubInformation = json['hubInformation'] != null
        ? new HubInformation.fromJson(json['hubInformation'])
        : null;
  }
}

class Image {
  int id;
  bool imageDefault;
  File file;

  Image({this.id, this.imageDefault, this.file});

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageDefault = json['default'];
    file = json['file'] != null ? new File.fromJson(json['file']) : null;
  }
}

class File {
  String filename;
  String mimetype;
  String previewUrl;

  File({this.filename, this.mimetype, this.previewUrl});

  File.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    mimetype = json['mimetype'];
    previewUrl = json['previewUrl'];
  }
}

class HubInformation {
  int id;
  bool inStock;
  int currentStock;
  int maximumRetailPrice;
  int mbq;
  Hub hub;

  HubInformation(
      {this.id,
      this.inStock,
      this.currentStock,
      this.maximumRetailPrice,
      this.mbq,
      this.hub});

  HubInformation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inStock = json['inStock'];
    currentStock = json['currentStock'];
    maximumRetailPrice = json['maximumRetailPrice'];
    mbq = json['mbq'];
    hub = json['hub'] != null ? new Hub.fromJson(json['hub']) : null;
  }
}

class Hub {
  int id;
  String name;

  Hub({this.id, this.name});

  Hub.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class DateHub {
  int id;
  String name;
  String code;
  String gstin;
  String openingTime;
  String closingTime;
  bool isOperating;

  DateHub(
      {this.id,
      this.name,
      this.code,
      this.gstin,
      this.openingTime,
      this.closingTime,
      this.isOperating});

  DateHub.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    gstin = json['gstin'];
    openingTime = json['openingTime'];
    closingTime = json['closingTime'];
    isOperating = json['isOperating'];
  }
}
