//
//  WeatherManager.swift
//  Clima
//
//  Created by Sai Reddy on 03/08/21.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailError(error: Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=c1c89d223460e6030ffca9e6762f7034"
    
    var delegate: WeatherManagerDelegate?
    
    func fetch_weather(name: String){
        let url = "\(weatherURL)&q=\(name)"
//        print("\(weatherURL)&q=\(name)")
        performRequest(with: url)
    }
    
    func performRequest(with urlString: String){
        //1. create URL
        if let url = URL(string: urlString){
            //2. Create URL session
            
            let session = URLSession(configuration: .default)
            
            //3. Give session task
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailError(error: error!)
                    return
                }
                if let safeData = data{
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            //4. Resume task
            task.resume()
            
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let name = decodedData.name
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            
            let weather = WeatherModel(name: name,id: id, temp: temp)
            return weather
            
        } catch{
            delegate?.didFailError(error: error)
            return nil
        }
    }
        

}
