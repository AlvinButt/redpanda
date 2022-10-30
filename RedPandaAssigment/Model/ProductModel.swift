//
//  ProductModel.swift
//  RedPandaAssigment
//
//  Created by Arslan Ahmad on 29/10/2022.
//


import UIKit

class ProductModel: Decodable {
    var id: String
    var name: String?
    var price: Int?
    var desc: String?
    var image: String?
    
    init(id:String, name:String?, price:Int?, desc:String?, image:String?){
        self.id = id
        self.name = name
        self.price = price
        self.desc = desc
        self.image = image
    }
}

class ProductResultModel: Decodable {
    var products = [ProductModel]()
    init(results: [ProductModel]) {
        self.products = results
    }
}
