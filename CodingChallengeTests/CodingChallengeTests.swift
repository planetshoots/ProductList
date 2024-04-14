//
//  CodingChallengeTests.swift
//  CodingChallengeTests
//
//  Created by Veena Chandran on 07/04/24.
//

import XCTest
@testable import CodingChallenge

final class CodingChallengeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func loadProductSampleData() throws -> ProductListResponse {
        guard let filePath = Bundle.main.path(forResource: "productResponseJSON", ofType: "json") else {
            XCTFail("Missing JSON file")
            throw NSError(domain: "Test", code: 404, userInfo: nil)
        }
        let requestData = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .mappedIfSafe)
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode(ProductListResponse.self, from: requestData)
    }

    func testProductDetailsViewModel() throws {
        let sampleProductData = try loadProductSampleData()
        if let firtProduct = sampleProductData.products.first {
            let productDetailsViewModel = ProductDetailsViewModel(product: firtProduct)
            XCTAssertEqual(productDetailsViewModel.id, firtProduct.id)
            XCTAssertEqual(productDetailsViewModel.title, firtProduct.title ?? "")
            XCTAssertEqual(productDetailsViewModel.description, firtProduct.description ?? "")
            XCTAssertNotNil(productDetailsViewModel.productImage)
            XCTAssertNotNil(productDetailsViewModel.thumbnail)
        }
    }
    
    func testProductCellViewModel() throws {
        let sampleProductData = try loadProductSampleData()
        if let firtProduct = sampleProductData.products.first {
            let productCellViewModel = ProductCellViewModel(product: firtProduct)
            XCTAssertEqual(productCellViewModel.id, firtProduct.id)
            XCTAssertEqual(productCellViewModel.title, firtProduct.title)
            XCTAssertEqual(productCellViewModel.description, firtProduct.description)
            XCTAssertEqual(productCellViewModel.price, Int(firtProduct.price))
            XCTAssertEqual(productCellViewModel.rating, firtProduct.rating)
            XCTAssertEqual(productCellViewModel.thumbnail, firtProduct.thumbnail)
        }
    }

    func testMainViewModel() throws {
        let sampleProductData = try loadProductSampleData()
        let mainViewModel = MainViewModel()
        mainViewModel.productListFromService = sampleProductData.products
        XCTAssertEqual(mainViewModel.skip, 10)
        XCTAssertEqual(mainViewModel.limit, 10)
    }
    
    func testRetriveProduct() throws {
        let sampleProductData = try loadProductSampleData()
        let mainViewModel = MainViewModel()
        mainViewModel.productListFromService = sampleProductData.products
        let product = mainViewModel.retriveProduct(with: 11)
        XCTAssertNotNil(product)
        XCTAssertEqual(product?.id, 11)
        XCTAssertEqual(product?.title, "perfume Oil")
        XCTAssertEqual(product?.description, "Mega Discount, Impression of Acqua Di Gio by GiorgioArmani concentrated attar perfume Oil")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
