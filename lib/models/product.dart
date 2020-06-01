class Product {
  String type;
  String name;
  String description;
  String photoURL;
  String barCode;
  String qrCode;
  Product(this.barCode,this.description,this.name,this.photoURL,this.qrCode,this.type);
}


Product product1 = new Product('1','Hamburger','Hamburger','https://www.foodiesfeed.com/wp-content/uploads/2016/08/tiny-pickles-on-top-of-burger-1-413x275.jpg','1','Food');
Product product2 = new Product('1','Hamburger','Hamburger','https://www.foodiesfeed.com/wp-content/uploads/2016/08/tiny-pickles-on-top-of-burger-1-413x275.jpg','1','Food');
List <Product> products = [product1,product2];