//
//  ProductVC.swift
//  RedPandaAssigment
//
//  Created by Arslan Ahmad on 27/10/2022.
//

import UIKit
import SVProgressHUD

class ProductVC: UIViewController {
    
    @IBOutlet weak var productCV: UICollectionView!
    
    var products: [ProductViewModel] = [ProductViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        
        BackendController.sharedConrtoller().getProductIds { success, response in
            SVProgressHUD.dismiss()
            let ids:ProductIds = try! JSONDecoder().decode(ProductIds.self, from: response.rawData())
            ProductService.setProductIds(ids)
            self.observeProducts()
        }
        
    }
    
    func observeProducts() {
        
        guard let ids = ProductService.ids else { return }
        
        SVProgressHUD.show()
        ProductService.sharedInstance.getProductDetails(ids: ids) { productsDetail, error in

            SVProgressHUD.dismiss()
            if let error = error {
                print(error)
                return
            }
            
            guard let productsDetail = productsDetail else { return }
            self.products = productsDetail.map({ return ProductViewModel(product: $0) })
            self.productCV.reloadData()
            
        }
        
    }
    
}
