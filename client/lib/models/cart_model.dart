class CartModel {
  int id;
  int total;
  bool isComplit;
  String date;
  int user;
  List<Cartbooks> cartbooks;

  CartModel(
      {this.id,
      this.total,
      this.isComplit,
      this.date,
      this.user,
      this.cartbooks});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    isComplit = json['isComplit'];
    date = json['date'];
    user = json['user'];
    if (json['cartbooks'] != null) {
      cartbooks = new List<Cartbooks>();
      json['cartbooks'].forEach((v) {
        cartbooks.add(new Cartbooks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total'] = this.total;
    data['isComplit'] = this.isComplit;
    data['date'] = this.date;
    data['user'] = this.user;
    if (this.cartbooks != null) {
      data['cartbooks'] = this.cartbooks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cartbooks {
  int id;
  int price;
  int quantity;
  int subtotal;
  Cart cart;
  List<Book> book;

  Cartbooks(
      {this.id,
      this.price,
      this.quantity,
      this.subtotal,
      this.cart,
      this.book});

  Cartbooks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    quantity = json['quantity'];
    subtotal = json['subtotal'];
    cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
    if (json['book'] != null) {
      book = new List<Book>();
      json['book'].forEach((v) {
        book.add(new Book.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['subtotal'] = this.subtotal;
    if (this.cart != null) {
      data['cart'] = this.cart.toJson();
    }
    if (this.book != null) {
      data['book'] = this.book.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cart {
  int id;
  int total;
  bool isComplit;
  String date;
  int user;

  Cart({this.id, this.total, this.isComplit, this.date, this.user});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    isComplit = json['isComplit'];
    date = json['date'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total'] = this.total;
    data['isComplit'] = this.isComplit;
    data['date'] = this.date;
    data['user'] = this.user;
    return data;
  }
}

class Book {
  int id;
  String title;
  String data;
  String image;
  int marcketPrice;
  int sellingPrice;
  String description;
  int category;

  Book(
      {this.id,
      this.title,
      this.data,
      this.image,
      this.marcketPrice,
      this.sellingPrice,
      this.description,
      this.category});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    data = json['data'];
    image = json['image'];
    marcketPrice = json['marcket_price'];
    sellingPrice = json['selling_price'];
    description = json['description'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['data'] = this.data;
    data['image'] = this.image;
    data['marcket_price'] = this.marcketPrice;
    data['selling_price'] = this.sellingPrice;
    data['description'] = this.description;
    data['category'] = this.category;
    return data;
  }
}
