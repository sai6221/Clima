//
//  WeatherManager.swift
//  Clima
//
//  Created by Sai Reddy on 03/08/21.
//

import Foundation

struct WeatherManager {
    
    var weatherURL = "api.openweathermap.org/data/2.5/weather?units=metric&appid=c1c89d223460e6030ffca9e6762f7034"
    
    func fetch_weather(name: String){
        let url = "\(weatherURL)&q=\(name)"
//        print("\(weatherURL)&q=\(name)")
        performRequest(urlString: url)
    }
    
    func performRequest(urlString: String){
        //1. create URL
        if let url = URL(string: urlString){
            //2. Create URL session
            
            let session = URLSession(configuration: .default)
            
            //3. Give session task
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                if let safeData = data{
                    let dataString = String(data: safeData, encoding: .utf8)
                    print(dataString)
                }
            }
            
            //4. Resume task
            task.resume()
            
        }
    }
}
