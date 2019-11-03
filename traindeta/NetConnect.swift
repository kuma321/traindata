//
//  NetConnect.swift
//  traindeta
//
//  Created by 熊谷里哉 on 2019/10/11.
//  Copyright © 2019 熊谷里哉. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NetConnect{
    
    var articles: [[String: String?]] = []
    func connect(){
        net(url: "https://api-tokyochallenge.odpt.org/api/v4/odpt:TrainInformation?odpt:operator=odpt.Operator:TokyoMetro&acl:consumerKey=dec8c179df3f39d48cfb49b072b0a63e08603e983acc06ae177f26307a8020ac")
        net(url: "https://api-tokyochallenge.odpt.org/api/v4/odpt:TrainInformation?odpt:operator=odpt.Operator:Odakyu&acl:consumerKey=dec8c179df3f39d48cfb49b072b0a63e08603e983acc06ae177f26307a8020ac")
    net(url:"https://api-tokyochallenge.odpt.org/api/v4/odpt:TrainInformation?odpt:operator=odpt.Operator:JR-East&acl:consumerKey=dec8c179df3f39d48cfb49b072b0a63e08603e983acc06ae177f26307a8020ac")
        
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
                                        "train":json["odpt:trainInformationText"]["ja"].stringValue,
                                    ]
                                    self.articles.append(article)
                                }
                        
                            
             case .failure(let error):
                print(error)
            }
        }
    }
    
}
