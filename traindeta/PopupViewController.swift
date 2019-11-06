//
//  PopupViewController.swift
//  traindeta
//
//  Created by 熊谷里哉 on 2019/11/02.
//  Copyright © 2019 熊谷里哉. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

    var train = ""
    var result = ""
    var sta = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.line.text = train
        self.info.text = result
        self.status.text = sta
    }
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
       }
    @IBOutlet weak var line: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBAction func didTapClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
     }
     // MARK: - Navigation

}
