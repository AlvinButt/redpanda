//
//  ProductService.swift
//  RedPandaAssigment
//
//  Created by Arslan Ahmad on 29/10/2022.
//

import Foundation
import FirebaseDatabase


typealias ProductIds = [String]

enum ProductCategory : String {
     case Name = "product-name", Desc = "product-desc", Price = "product-price", Image = "product-image"

     static let allValues = [Name, Desc, Price, Image]
}

class ProductService: NSObject {
        
    static let sharedInstance = ProductService()
    
    static var ids: ProductIds?

    static func setProductIds(_ _ids: ProductIds) {
        ids = _ids
    }
    
    
    func getProductDetails(ids:ProductIds,  completion: @escaping([ProductModel]?, Error?) -> ()){
        
        
        let dispatchGroup = DispatchGroup()
        
        var arrProduct = [ProductModel]()

        for id in ids {
            
            for val in ProductCategory.allValues {
                
                dispatchGroup.enter()
                
                let node = val
                let ref = DatabaseReference.toLocation(.product(nodeName: node.rawValue, pid: id))
                ref.observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    if arrProduct.count > 0 {
                        
                        var containPs = arrProduct.filter { $0.id == id }
                        
                        if containPs.count > 0 {
                            //EXISTING PRODUCT WITH SOME DATA
                            let name = node == .Name ? snapshot.value as? String : ""
                            containPs[0].name = containPs[0].name == "" ? name : containPs[0].name
                            
                            let price = node == .Price ? snapshot.value as? Int ?? 0 : nil
                            containPs[0].price = containPs[0].price == nil ? price : containPs[0].price
                            
                            let desc =  node == .Desc ? snapshot.value as? String : ""
                            containPs[0].desc = containPs[0].desc == "" ? desc : containPs[0].desc
                            
                            let image = node == .Image ? snapshot.value as? String : ""
                            containPs[0].image = containPs[0].image == "" ? image : containPs[0].image
                            
                            arrProduct = arrProduct.filter { $0.id != id }
                            arrProduct.append(containPs[0])
                            
                        }else{
                            //NEW PRODUCT
                            let product = ProductModel(id: id,
                                                       name: node == .Name ? snapshot.value as? String : "" ,
                                                       price: node == .Price ? snapshot.value as? Int ?? 0 : nil,
                                                       desc: node == .Desc ? snapshot.value as? String : "",
                                                       image: node == .Image ? snapshot.value as? String : "")
                            arrProduct.append(product)
                        }
                        
                        
                    }else{
                        //FIRST TIME
                        let product = ProductModel(id: id,
                                                   name: node == .Name ? snapshot.value as? String : "" ,
                                                   price: node == .Price ? snapshot.value as? Int ?? 0 : nil,
                                                   desc: node == .Desc ? snapshot.value as? String : "",
                                                   image: node == .Image ? snapshot.value as? String : "")
                        arrProduct.append(product)
                    }
                    
                    
                    dispatchGroup.leave()
                })
                
            }
            
        }
        
        dispatchGroup.notify(queue: .main, execute: {
            completion(arrProduct,nil)
        })
        
        
    }
    
}
