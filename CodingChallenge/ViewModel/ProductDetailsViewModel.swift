//
//  ProductDetailsViewModel.swift
//  CodingChallenge
//
//  Created by Veena Chandran on 11/04/24.
//

import Foundation

struct ProductDetailsViewModel {
        
    var id: Int16
    var productImage: URL?
    var title: String
    var description: String
    var thumbnail: URL?
    let price: Double
    let rating: Double
    
    init(product: ProductDetail) {
        self.id = product.id
        self.title = product.title ?? ""
        self.description = product.description ?? ""
        self.price = product.price
        self.rating = product.rating
        
        if let productImages = product.images,
           let mainImage = productImages.first,
           let mainImageurl = URL(string: mainImage) {
            self.productImage = mainImageurl
        }
        if let thumbnail = product.thumbnail {
            self.thumbnail = URL(string: thumbnail)
        }
    }
    
    func addToCart() {
        CoreDataManager.shared.addToCart(selectedProduct: self)
    }
}
