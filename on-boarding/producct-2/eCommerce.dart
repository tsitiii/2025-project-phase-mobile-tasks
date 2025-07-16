import 'dart:io';

class Product {
  int? id;
  String? name;
  String? description;
  double? price;

  Product(this.id, this.name, this.description, this.price);

  @override
  String toString() {
    return 'Product(id:$id, Name: $name, Price: $price)';
  }
}

class ProductManager {
  List<Product> products = [];

  void addNewProduct(Product product) {
    products.add(product);
  }

  void viewAllProduct() {
    if (products.isEmpty) {
      print("No Products avaialabe!");
    } else {
      print("*****List of products ******");
      for (var pro in products) {
        print(pro);
      }
    }

    return;
  }

  void editProduct(int id, {String? name, double? price, String? description}) {
    for (var pro in products) {
      if (pro.id == id) {
        if (name != null) {
          pro.name = name;
        }
        if (price != null) {
          pro.price = price;
        }
        if (description != null) {
          pro.description = description;
        }

        print("Product info update!");
        return;
      }
    }
  }

  void deleteProdcut(int id) {
    int initialLength = products.length;
    products.removeWhere((product) => product.id == id);
    if (products.length < initialLength) {
      print("🗑️ Product with ID $id deleted.");
    } else {
      print("Product with ID $id not found.");
    }
  }
}

void main() {
  ProductManager manager = ProductManager();

  // Add initial products
  manager.addNewProduct(
    Product(1, "Nike shoe", "A new trending shoe, with reasonable price", 2500),
  );
  manager.addNewProduct(
    Product(2, "Puma shoe", "A new trending shoe, with reasonable price", 2000),
  );
  manager.addNewProduct(
    Product(
      3,
      "Airmask shoe",
      "A new trending shoe, with reasonable price",
      3000,
    ),
  );

  while (true) {
    print('\n========== eCommerce Product Manager ==========');
    print('1. View all products');
    print('2. Add new product');
    print('3. Edit product');
    print('4. Delete product');
    print('5. Exit');
    print('================================================');

    stdout.write('Enter your choice (1-5): ');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        manager.viewAllProduct();
        break;

      case '2':
        stdout.write("Enter product id: ");
        String? idInput = stdin.readLineSync();
        int? id = int.tryParse(idInput ?? '') ?? 0;

        stdout.write("Enter product name: ");
        String? name = stdin.readLineSync();

        stdout.write("Enter product description: ");
        String? description = stdin.readLineSync();

        stdout.write("Enter product price: ");
        String? priceInput = stdin.readLineSync();
        double price = double.tryParse(priceInput ?? '') ?? 0;

        manager.addNewProduct(Product(id, name, description, price));
        break;

      case '3':
        stdout.write("Enter product id to edit: ");
        String? editIdInput = stdin.readLineSync();
        int? editId = int.tryParse(editIdInput ?? '') ?? 0;

        stdout.write("Enter new name: ");
        String? newName = stdin.readLineSync();

        manager.editProduct(editId, name: newName);
        break;

      case '4':
        stdout.write("Enter product id to delete: ");
        String? deleteIdInput = stdin.readLineSync();
        int? deleteId = int.tryParse(deleteIdInput ?? '') ?? 0;

        manager.deleteProdcut(deleteId);
        break;

      case '5':
        print('Thank you for using eCommerce Product Manager!');
        return;

      default:
        print('Invalid choice! Please enter a number between 1-5.');
    }
  }
}
