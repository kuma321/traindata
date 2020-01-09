//
//  SelectViewController.swift
//  traindeta
//
//  Created by 熊谷里哉 on 2019/10/08.
//  Copyright © 2019 熊谷里哉. All rights reserved.
//UITableViewDelegate, UITableViewDataSource

import UIKit

class SelectViewController: UIViewController {


    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "iPhone XR-XS Max –　統一.png")!)
        // Do any additional setup after loading the view.
    }
    @IBAction func favgo(_ sender: UIButton) {
    }
    
    func t(key: String) -> Bool{
           return UserDefaults.standard.object(forKey:key) != nil
       }

    
}
