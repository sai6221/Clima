//
//  WeatherModel.swift
//  Clima
//
//  Created by Sai Reddy on 07/08/21.
//

import Foundation

struct WeatherModel{
    let name: String
    let id: Int
    let temp: Double
    
    var tempString: String {
        return String(format:"%0.1f",temp)
    }
    
    var conditionName: String{
        switch id{
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
