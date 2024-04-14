//
//  ProductCell.swift
//  CodingChallenge
//
//  Created by Veena Chandran on 10/04/24.
//

import UIKit

class ProductCell: UITableViewCell {

    public static var identifier: String {
        get {
            return "ProductCell"
        }
    }
    public static func register() -> UINib {
        UINib(nibName: "ProductCell", bundle: nil)
    }
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productRating: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.addBorder(color: .label, width: 1)
        backView.round()
        imageView?.round(2)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.productNameLabel.text = nil
        self.productDescription.text = nil
        self.productRating.text = nil
        self.productPrice.text = nil
        self.productImageView.image = nil
    }

    func setupCell(viewModel: ProductDetail) {
        self.productNameLabel.text = viewModel.title
        self.productDescription.text = viewModel.description
        self.productRating.text = String(viewModel.rating)
        self.productPrice.text = String(viewModel.price)
        if let thumbImageStr = viewModel.thumbnail, let url = URL(string: thumbImageStr) {
            self.productImageView?.load(url: url)
        }
    }
}
