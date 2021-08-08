//
//  ViewController.swift
//  Clima
//
//  Created by Sai Reddy on 02/08/21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController{

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempValue: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var textInput: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weatherManager.delegate = self
        textInput.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

//MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate{
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
}

//MARK: - WeatherManagerDelegate

extension ViewController: WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
        DispatchQueue.main.async {
            self.tempValue.text = weather.tempString
            self.weatherImage.image = UIImage(systemName: weather.conditionName)
            self.locationLabel.text = weather.name
        }
    }
    
    func didFailError(error: Error) {
        print(error)
    }
}


//MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetch_weather(latitude: lat,longitude: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
