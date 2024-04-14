//
//  ProductDetailsViewController.swift
//  CodingChallenge
//
//  Created by Veena Chandran on 11/04/24.
//

import Foundation
import UIKit

class ProductDetailsViewController: UIViewController {
    
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var detailsTitleLabel: UILabel!
    @IBOutlet weak var detailsDescriptionLabel: UILabel!
    
    var viewModel: ProductDetailsViewModel
    var items: [Product]?
    
    init(viewModel: ProductDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ProductDetailsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        self.title = "Product Details"
        if let productImageUrl = viewModel.productImage {
            self.detailsImageView.load(url: productImageUrl)
        }
        self.detailsTitleLabel.text = viewModel.title
        self.detailsDescriptionLabel.text = viewModel.description
    }
    
    @IBAction func addToCartAction(_ sender: Any) {
        self.viewModel.addToCart()
        self.showAlert(title: "Success", message: "Added to the cart")
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: "Success", message: "Added to the cart", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
