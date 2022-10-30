//
//  ProductVC-LoadData.swift
//  RedPandaAssigment
//
//  Created by Arslan Ahmad on 30/10/2022.
//

import UIKit
import SVProgressHUD
import FirebaseDatabase

extension ProductVC {
    
    
    func loadData(){
        SVProgressHUD.show()
        BackendController.sharedConrtoller().getProductIds { success, response in
            SVProgressHUD.dismiss()
            let ids:ProductIds = try! JSONDecoder().decode(ProductIds.self, from: response.rawData())
            ProductService.setProductIds(ids)
            self.getProducts()
        }
    }

    
    func getProducts(){
        
        guard let ids = ProductService.ids else { return }
        
        SVProgressHUD.show()
        ProductService.sharedInstance.getProductDetails(ids: ids) { productsDetail, error in

            SVProgressHUD.dismiss()
            if let error = error {
                print(error)
                return
            }
            
            //NOW SET OBSERVER
            self.observeProducts()
            //
            
            guard let productsDetail = productsDetail else { return }
            self.products = productsDetail.map({ return ProductViewModel(product: $0) })
            self.productCV.reloadData()
            
        }
        
    }
    
    func observeProducts(){
        //TESTED
        for node in ProductCategory.allValues{
            let ref = DatabaseReference.toLocation(.productTb(nodeName: node.rawValue))
            ref.observe(.childChanged) { snapshot in
                
                guard let key = snapshot.ref.parent?.key else { return }
                if let cat = ProductCategory(rawValue: key ) {
                    switch cat {
                    case .Name:
                        self.products.filter({$0.id == snapshot.key}).first?.name = snapshot.value as? String
                        if let rowNumber = self.products.firstIndex(where: {$0.id == snapshot.key}) {
                            DispatchQueue.main.async {
                                let indexPath = IndexPath(item: rowNumber, section: 0)
                                self.productCV.reloadItems(at: [indexPath])
                            }
                        }
                    case .Desc:
                        self.products.filter({$0.id == snapshot.key}).first?.desc = snapshot.value as? String
                        if let rowNumber = self.products.firstIndex(where: {$0.id == snapshot.key}) {
                            DispatchQueue.main.async {
                                let indexPath = IndexPath(item: rowNumber, section: 0)
                                self.productCV.reloadItems(at: [indexPath])
                            }
                        }
                    case .Price:
                        let prc = snapshot.value as! Int
                        self.products.filter({$0.id == snapshot.key}).first?.price = prc
                        if let rowNumber = self.products.firstIndex(where: {$0.id == snapshot.key}) {
                            DispatchQueue.main.async {
                                let indexPath = IndexPath(item: rowNumber, section: 0)
                                self.productCV.reloadItems(at: [indexPath])
                            }
                        }
                    case .Image:
                        self.products.filter({$0.id == snapshot.key}).first?.image = snapshot.value as? String
                        if let rowNumber = self.products.firstIndex(where: {$0.id == snapshot.key}) {
                            DispatchQueue.main.async {
                                let indexPath = IndexPath(item: rowNumber, section: 0)
                                self.productCV.reloadItems(at: [indexPath])
                            }
                        }
                    }
                }
            }
        }
    }
    
}
