//
//  ProductListResponse.swift
//  CodingChallenge
//
//  Created by Veena Chandran on 08/04/24.
//

import Foundation

struct ProductListResponse: Decodable {
    var products: [ProductDetail]
    let total: Int
    let skip: Int
    let limit: Int
}

struct ProductDetail: Decodable {
    let id: Int16
    let title: String?
    let description: String?
    let price: Double
    let rating: Double
    let thumbnail: String?
    let images: [String]?
}
