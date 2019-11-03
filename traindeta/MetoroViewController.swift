//
//  MetoroViewController.swift
//  traindeta
//
//  Created by 熊谷里哉 on 2019/10/17.
//  Copyright © 2019 熊谷里哉. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MetoroViewController: UIViewController,UITableViewDataSource{
        let table = UITableView()
       var articles: [[String: String?]] = []
       var addBtn: UIBarButtonItem!
        let train = ["副都心線","南北線","半蔵門線","千代田線","銀座線","有楽町線","東西線","丸ノ内線","日比谷線"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.popViewController(animated: true)
                     title = "遅延情報"
              addBtn = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(self.onClick))
                      self.navigationItem.leftBarButtonItem = addBtn
                     table.frame = view.frame
                     view.addSubview(table)
                     table.dataSource = self
                    net(url: "https://api-tokyochallenge.odpt.org/api/v4/odpt:TrainInformation?odpt:operator=odpt.Operator:TokyoMetro&acl:consumerKey=dec8c179df3f39d48cfb49b072b0a63e08603e983acc06ae177f26307a8020ac")

    }
    

    func net(url:String) {
               Alamofire.request(url, method: .get).responseJSON { response in
                    switch response.result {
                    case.success:
                        print("成功")
                        guard let object = response.result.value else {
                            return
                        }
                        let json = JSON(object)
                                       json.forEach { (_, json) in
                                           let article: [String: String?] = [
                                            "train":json["odpt:trainInformationStatus"]["ja"].stringValue,
                                            "traininfo":json["odpt:trainInformationText"].stringValue
                                           ]
                                           self.articles.append(article)
                                       }
                                  
                                   self.table.reloadData()
                                   
                                   
                   case .failure(let error):
                       print(error)
                   }
               }
           }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
            }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            let article = articles[indexPath.row]
            let train0 = train[indexPath.row]
           cell.detailTextLabel?.text = article["train"]!
            cell.textLabel?.text = train0
            cell.accessoryType = UITableViewCell.AccessoryType.detailButton
           return cell
        
        }
        @objc func onClick() {
              let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "Select") as! SelectViewController
              self.present(secondViewController, animated: true, completion: nil)
            
    }

    

}
