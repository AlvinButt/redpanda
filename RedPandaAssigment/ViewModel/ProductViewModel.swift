//
//  ProductViewModel.swift
//  RedPandaAssigment
//
//  Created by Arslan Ahmad on 29/10/2022.
//

import UIKit

class ProductViewModel: NSObject {
    var id: String
    var name: String?
    var price: Int?
    var desc: String?
    var image: String?
    
//    DEPENDENCY INJECTION
    
    init(product:ProductModel){
        self.id = product.id
        self.name = product.name
        self.price = product.price
        self.desc = product.desc
        self.image = product.image
    }
    
}
