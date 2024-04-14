//
//  MainViewModel.swift
//  CodingChallenge
//
//  Created by Veena Chandran on 08/04/24.
//

import Foundation

class MainViewModel {
    
    var productListFromService: [ProductDetail]?
    var productListFromCart: [ProductDetail]?
    var isViewingCart: Bool = false
    var updateView: (([ProductDetail]) -> Void)?
    var totalProducts: Int = 0
    let skip: Int = 10
    var limit: Int = 10
    var isLoadingData = false
    
    func getProductList() {
        isLoadingData = true
        Network.getPoductsFromSerice(skip: skip, limit: limit) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let productData):
                guard self.updateView != nil else { return }
                self.productListFromService = productData.products
                self.totalProducts = productData.total
                self.updateView?(productData.products)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getNextPageList() {
        limit += 10
        getProductList()
    }
    
    func getCartList() {
        let products = CoreDataManager.shared.getCartProducts()
        var productDetail = products.map { coreDataObject in
            return ProductDetail(
                id: coreDataObject.id,
                title: coreDataObject.title,
                description: coreDataObject.details,
                price: coreDataObject.price,
                rating: coreDataObject.rating,
                thumbnail: coreDataObject.thumbnail,
                images: [coreDataObject.imageString ?? ""]
            )
        }
        self.productListFromCart = productDetail
        self.updateView?(productDetail)
    }
    
    func retriveProduct(with id: Int) -> ProductDetail? {
        return productListFromService?.first(where: { $0.id == id })
    }
    
    func toggleView() {
        isViewingCart.toggle()
        isViewingCart ? getCartList() : getProductList()
    }
}
