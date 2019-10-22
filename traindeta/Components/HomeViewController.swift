//
//  HomeViewController.swift
//  TrainOpendata
//
//  Created by 熊谷里哉 on 2019/09/29.
//  Copyright © 2019 熊谷里哉. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON
import Alamofire

class HomeViewController: UIViewController,CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
    let alarm = Alarm()
    var currenttime = CurrentTime()
    let weather = WeatherConnect()
    var weatherinfo: [[String: String?]] = []
    var tenkiarray: Array<String> = []
    var weatherarray: Array<String> = []
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var tenki1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currenttime.hoge = self
        setupLocationManager()
        net(url:"https://api.openweathermap.org/data/2.5/forecast?zip=100-0005,JP&units=metric&lang=ja&cnt=6&APPID=667086c7c86aacbf61429ad78a5023b3")
        print(weatherinfo)
    }
    override func viewDidAppear(_ animated: Bool) {
           if alarm.sleepTimer != nil{
               alarm.stopTimer()
           }
    }
    
    func updateTime(_ time:String) {
        Time.text = time
    }
    func setupLocationManager() {
           locationManager = CLLocationManager()
           guard let locationManager = locationManager else { return }
           locationManager.requestWhenInUseAuthorization()

           let status = CLLocationManager.authorizationStatus()
           if status == .authorizedWhenInUse {
               locationManager.delegate = self
               locationManager.distanceFilter = 10
               locationManager.startUpdatingLocation()
           }
       }

       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           let location = locations.first
           let latitude = location?.coordinate.latitude
           let longitude = location?.coordinate.longitude
           print("latitude: \(latitude!)\nlongitude: \(longitude!)")
       }
    func net(url:String){
           Alamofire.request(url, method: .get).responseJSON { response in
           switch response.result {
            case.success(let value):
                  let json = JSON(value)
                  for i in 0 ..< 5{
                    let dt_txt = json["list"][i]["dt_txt"].stringValue
                    let weatherMain = json["list"][i]["weather"][0]["main"].stringValue
                    //let weatherDescription = json["list"][i]["weather"][0]["description"].stringValue
                    self.tenkiarray.append(dt_txt)
                    self.weatherarray.append(weatherMain)
                    if i == 0{
                        let time1 = self.tenkiarray[i]
                        //self.tenki1.text = time1.suffix(8)
                    }
                    if i == 1{
                
                    }
                    if i == 2{
                        
                    }
                    if i == 3{
                        
                    }
                    if i == 4 {
                        
                    }
                   
                  }
            case .failure(let error):
                         print(error)
            }
        }
    }
}
