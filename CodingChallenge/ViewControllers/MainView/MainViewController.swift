//
//  MainViewController.swift
//  CodingChallenge
//
//  Created by Veena Chandran on 11/04/24.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var productsTableView: UITableView!
    var viewCartButton: UIBarButtonItem!
    let viewModel = MainViewModel()
    let placeholderImage = UIImage(named: "placeholder")
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bindViewModel()
        viewModel.getProductList()
    }
    
    func configureView() {
        title = "Products"
        setupTableView()
        setupViewCartButton()
        setupActiivtyView()
    }
    
    func setupViewCartButton() {
        let cartButton = UIButton(type: .custom)
        cartButton.setTitle("View Cart", for: .normal)
        cartButton.setTitleColor(.black, for: .normal)
        cartButton.addTarget(self, action: #selector(navigationButtonTapped), for: .touchUpInside)
        viewCartButton = UIBarButtonItem(customView: cartButton)
        navigationItem.rightBarButtonItem = viewCartButton
    }
    
    func setupActiivtyView() {
        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    @objc func navigationButtonTapped() {
        viewModel.toggleView()
        updateViewCartButtonTitle()
    }
    
    func updateViewCartButtonTitle() {
        let newTitle = viewModel.isViewingCart ? "View List" : "View Cart"
        if let cartButton = viewCartButton.customView as? UIButton {
            cartButton.setTitle(newTitle, for: .normal)
        }
        title = viewModel.isViewingCart ? "Cart" : "Products"
    }
    
    func bindViewModel() {
        viewModel.updateView = { [weak self] data in
            guard let self = self else { return }
            if viewModel.isViewingCart {
                self.viewModel.productListFromCart = data
            } else {
                self.viewModel.productListFromService = data
            }
            DispatchQueue.main.async {
                self.productsTableView.reloadData()
                self.viewModel.isLoadingData = false
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func openDetails(ProductId: Int) {
        guard let product = viewModel.retriveProduct(with: ProductId) else {
            return
        }
        let productDetailsViewModel = ProductDetailsViewModel(product: product)
        let productDetailsViewController = ProductDetailsViewController(viewModel: productDetailsViewModel)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(productDetailsViewController, animated: true)
        }
    }
}

