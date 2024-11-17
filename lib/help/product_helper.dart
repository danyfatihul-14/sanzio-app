List<Map<String, String>> getProductsForCategory(String categoryTitle) {
  const allProducts = {
    "T-Shirt": [
      {
        "title": "T-Shirt Classic",
        "price": "Rp 100.000",
        "image": "assets/T-Shirt.png"
      },
      {
        "title": "T-Shirt Modern",
        "price": "Rp 120.000",
        "image": "assets/T-Shirt.png"
      },
    ],
    "Jacket": [
      {
        "title": "Jacket Bomber",
        "price": "Rp 150.000",
        "image": "assets/Jacket.png"
      },
      {
        "title": "Jacket Leather",
        "price": "Rp 250.000",
        "image": "assets/Jacket.png"
      },
    ],
  };

  return allProducts[categoryTitle] ?? [];
}
