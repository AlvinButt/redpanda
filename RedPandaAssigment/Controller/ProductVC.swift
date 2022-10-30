//
//  ProductVC.swift
//  RedPandaAssigment
//
//  Created by Arslan Ahmad on 27/10/2022.
//

import UIKit

class ProductVC: UIViewController {
    
    @IBOutlet weak var productCV: UICollectionView!
    
    var products: [ProductViewModel] = [ProductViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    
}
