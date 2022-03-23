//
//  ViewController.swift
//  UIKit-components
//
//  Created by jpineros on 17/02/22.
//

import UIKit

class ViewController: UIViewController {

    var sender:String? = nil

    @IBSegueAction func detailInfo(_ coder: NSCoder, sender: Any?, segueIdentifier: String?) -> ViewController? {
        
        if segueIdentifier == "SequeStackView" {
            print("detail for stacks")
        }
        return ViewController(coder: coder)
    }
    private var selectedInfo = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        
    }
    
}

