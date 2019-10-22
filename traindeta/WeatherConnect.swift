//
//  WeatherConnect.swift
//  traindeta
//
//  Created by 熊谷里哉 on 2019/10/18.
//  Copyright © 2019 熊谷里哉. All rights reserved.impo
import UIKit
import Alamofire
import SwiftyJSON

class WeatherConnect{
    var weatherinfo: [[String: String?]] = []
    
    func net(url:String){
        Alamofire.request(url, method: .get).responseJSON { response in
        switch response.result {
            case.success:
                guard let object = response.result.value else {
                    return
                }
                let json = JSON(object)
                           json.forEach { (_, json) in
                                let weather: [String: String?] = [
                                    "info": json["list"]["dt_txt"].stringValue,
                            ]
                        self.weatherinfo.append(weather)
            }
        case .failure( _):
                print("接続失敗")
            }
        }
    }
}
