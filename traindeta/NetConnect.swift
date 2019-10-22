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
    
    func jrnet(url:String) {
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
                                        "title": json["@id"].stringValue,
                                        "userId": json["@type"].stringValue,
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
