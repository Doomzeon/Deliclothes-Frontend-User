
class ClothesType {

  String _name_type;
  String _image;


  ClothesType(this._image, this._name_type);

  String getImage() {
    return _image;
  }

  String getNameType() {
    return _name_type;
  }
  
  static List<ClothesType> fetchAll(String choice) {
    if (choice == 'Man'){
      return [
            ClothesType('assets/images/filter_man/abiti_man.jpg', 'Dresses'),
            ClothesType('assets/images/filter_man/blazzer_man.jpg', 'Blazer'),
            ClothesType('assets/images/filter_man/borse_man.jpg', 'Bags'),
            ClothesType('assets/images/filter_man/camicie_man.jpg', 'Shirts-tops'),
            ClothesType('assets/images/filter_man/felpa_man.jpg', 'Loungewear'),
            ClothesType('assets/images/filter_man/gilet_man.jpg', 'Waiskots'),
            ClothesType('assets/images/filter_man/giubotti_man.jpg', 'Jackets'),
            ClothesType('assets/images/filter_man/jeans_man.jpg', 'Jeans'),
            ClothesType('assets/images/filter_man/maglieria_man.jpg', 'Sweaters'),
            ClothesType('assets/images/filter_man/maglietta_man.jpg', 'T-shirt'),
            ClothesType('assets/images/filter_man/overshirts_man.jpg', 'Overshirts'),
            ClothesType('assets/images/filter_man/pantaloni_man.jpg', 'Trousers'),
            ClothesType('assets/images/filter_man/polo_man.jpg', 'Polo'),
            ClothesType('assets/images/filter_man/scarpe_man.jpg', 'Shoes'),
            ClothesType('assets/images/filter_man/special_price_man.jpg', 'SpecialPrice'),
            ClothesType('assets/images/filter_man/sportswear_man.jpg', 'Sportswear')
      ];
    }else if (choice == 'Woman'){
      return [
            ClothesType('assets/images/filter_woman/giache_woman.jpg', 'Jackets'),
            ClothesType('assets/images/filter_woman/maglietta_woman.jpg', 'T-Shirt'),
            ClothesType('assets/images/filter_woman/blazzar_woman.jpg', 'Blazers'),
            ClothesType('assets/images/filter_woman/gilete_woman.jpg', 'Waiskots'),
            ClothesType('assets/images/filter_woman/vestiti_woman.jpg', 'Dresses'),
            ClothesType('assets/images/filter_woman/maglieria_woman.jpg', 'Sweaters'),
            ClothesType('assets/images/filter_woman/jeans_woman.jpg', 'Jeans'),
            ClothesType('assets/images/filter_woman/pantaloni_woman.jpg', 'Trousers'),
            ClothesType('assets/images/filter_woman/shorts_woman.jpg', 'Shorts'),
            ClothesType('assets/images/filter_woman/gonne_woman.jpg', 'Skirt'),
            ClothesType('assets/images/filter_woman/camicie_woman.jpg', 'Shirts-tops'),
            ClothesType('assets/images/filter_woman/felpa_woman.jpg', 'Loungewear'),
            ClothesType('assets/images/filter_woman/capotti_woman.jpg', 'Suits'),
            ClothesType('assets/images/filter_woman/seamless_woman.jpg', 'Seamless'),
            ClothesType('assets/images/filter_woman/borse_woman.jpg', 'Bags'),
            ClothesType('assets/images/filter_woman/accesories_woman.jpg', 'Accessories'),
            ClothesType('assets/images/filter_woman/saldi_woman.jpg', 'SpecialPrice'),
            ClothesType('assets/images/filter_woman/intimo_woman.jpg', 'Lingerie')
      ];
    }else {
      return [
            ClothesType('assets/images/felpe.jpg', 'Child'),
            ClothesType('assets/images/camicie.jpg', 'Child'),
            ClothesType('assets/images/felpe.jpg', 'Child'),
            ClothesType('assets/images/camicie.jpg', 'Child'),
            ClothesType('assets/images/felpe.jpg', 'Child'),
            ClothesType('assets/images/camicie.jpg', 'Child')
      ];
    }
  }
}