//
//  ProductCellViewModel.swift
//  CodingChallenge
//
//  Created by Veena Chandran on 10/04/24.
//

import Foundation

struct ProductCellViewModel {
    var id: Int16
    var title: String
    var description: String
    var price: Int
    var rating: Double
    var thumbnail: String?

    
    init(product: ProductDetail) {
        self.id = product.id
        self.title = product.title ?? ""
        self.description = product.description ?? ""
        self.price = Int(product.price)
        self.rating = product.rating
        self.thumbnail = product.thumbnail
    }
}
