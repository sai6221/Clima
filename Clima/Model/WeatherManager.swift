//
//  WeatherManager.swift
//  Clima
//
//  Created by Sai Reddy on 03/08/21.
//

import Foundation

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=c1c89d223460e6030ffca9e6762f7034"
    
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
                    self.parseJSON(weatherData: safeData)
                }
            }
            
            //4. Resume task
            task.resume()
            
        }
    }
    
    func parseJSON(weatherData: Data){
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.name)
            print(decodedData.main.temp)
            let id = decodedData.weather[0].id
            getConditionName(weatherid: id)
        } catch{
            print(error)
        }
    }
    func getConditionName(weatherid: Int) -> String{
        switch weatherid{
            case 200...232:
                return "cloud.bolt"

            case 300...321:
                return "cloud.bolt"
        
            case 500...531:
                return "cloud.bolt"
            case 600...622:
                return "cloud.bolt"

            case 701...781:
                return "cloud.bolt"

            case 800:
                return "cloud.bolt"

            case 801...804:
                return "cloud.bolt"

            default:
                return "cloud"
    }
}

}
