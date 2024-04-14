//
//  MainViewController+TableView.swift
//  CodingChallenge
//
//  Created by Veena Chandran on 12/04/24.
//

import Foundation
import UIKit

extension MainViewController: UITableViewDataSource {
    
    func setupTableView() {
        productsTableView.dataSource = self
        productsTableView.delegate = self
        productsTableView.register(ProductCell.register(), forCellReuseIdentifier: ProductCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.isViewingCart ? viewModel.productListFromCart?.count ?? 0 : viewModel.productListFromService?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell else {
            return UITableViewCell()
        }
        if let product: ProductDetail = viewModel.isViewingCart ? viewModel.productListFromCart?[indexPath.row] : viewModel.productListFromService?[indexPath.row] {
            cell.productImageView.image = placeholderImage
            cell.setupCell(viewModel: product)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = viewModel.isViewingCart ? viewModel.productListFromCart?[indexPath.row] : viewModel.productListFromService?[indexPath.row]
        if let productId = product?.id {
            self.openDetails(ProductId: Int(productId))
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - screenHeight {
            if !viewModel.isLoadingData && viewModel.productListFromService?.count ?? 0 < viewModel.totalProducts && !viewModel.isViewingCart {
                viewModel.getNextPageList()
            }
        }
    }
}
