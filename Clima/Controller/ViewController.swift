//
//  ViewController.swift
//  Clima
//
//  Created by Sai Reddy on 02/08/21.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,WeatherManagerDelegate{

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempValue: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var textInput: UITextField!
    var weatherManager = WeatherManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        textInput.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func searchButton(_ sender: UIButton) {
        textInput.endEditing(true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textInput.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(textField.text != ""){
            return true
        }else{
            textField.placeholder = "Type Something"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = textField.text {
            weatherManager.fetch_weather(name: city)
        }
        textField.text = ""
    }
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
        DispatchQueue.main.async {
            self.tempValue.text = weather.tempString
            self.weatherImage.image = UIImage(systemName: weather.conditionName)
        }
    }
    
    func didFailError(error: Error) {
        print(error)
    }
    
}

