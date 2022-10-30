//
//  ProductCell.swift
//  RedPandaAssigment
//
//  Created by Arslan Ahmad on 29/10/2022.
//

import UIKit
import Kingfisher

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var productIMV: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var productPrice: UILabel!
    
    
    @IBOutlet weak var prodcutDesc: UILabel!
    
    
    
    var product: ProductViewModel? {
        didSet{
            guard let product = product else {return}
            productName.text = product.name
            prodcutDesc.text = product.desc ?? "-"
            if let price = product.price {
                productPrice.text = "₹ \(price)"
            }else{
                productPrice.text = "-"
            }
            if let imgURL = product.image {
                productIMV.loading()
                productIMV.kf.setImage(with: URL(string: imgURL))
            }
        }
    }
    
}
