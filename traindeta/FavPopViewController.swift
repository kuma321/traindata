//
//  FavPopViewController.swift
//  traindeta
//
//  Created by 熊谷里哉 on 2019/11/10.
//  Copyright © 2019 熊谷里哉. All rights reserved.
//

import UIKit

class FavPopViewController: UIViewController {
    
    @IBOutlet weak var line: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var status: UILabel!
    var train = ""
    var result = ""
    var sta = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.line.text = train
        self.info.text = result
        self.status.text = sta
        
    }
    
    @IBAction func close(_ sender: UIButton) {
         dismiss(animated: true, completion: nil)
    }
    
    
    

}
