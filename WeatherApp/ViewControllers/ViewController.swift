//
//  ViewController.swift
//  WeatherApp
//
//  Created by David Rifkin on 10/8/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit
import DataPersistence

class ViewController: UIViewController {
    
    let acceptableCharacters = CharacterSet(charactersIn: "0123456789").inverted
    // var unacceptableEntries: [Character] = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    var zipCode = "11434" {
        didSet {
            collectionView.reloadData()
            
        }
    }
    var weatherInformation = [Details]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    var cityName:String? {
        didSet {
            cityForecastLabel.text = "Weather Forecast for \(cityName ?? "no name")"
        }
    }
    
    var photoDetails: PhotoDetails?
    
    private let dataPersistenece = DataPersistence<PhotoDetails>(filename: "photos.plist")
    @IBOutlet weak var cityForecastLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        textField.delegate = self
        getZipCode(zipCode: zipCode)
        
        
    }
    
    
   
    
    
    func getZipCode(zipCode: String) {
        ZipCodeHelper.getLatLong(fromZipCode: zipCode) { (result) in
            switch result {
            case .failure(let appError):
                print("Unable to retrieve data: \(appError)")
            case .success(let coordinates):
                DispatchQueue.main.async {
                self.cityName = coordinates.placeName
                WeatherAPIClient.fetchWeatherInfo(latitude: coordinates.lat, longitude: coordinates.long) { (result) in
                    switch result {
                    case .failure(let appError):
                        print("Unable to retrieve data: \(appError)")
                    case .success(let weatherInfo):
                        self.weatherInformation = weatherInfo
                        self.fetchDetailPhoto(searchQuery: self.cityName!)
                        
                        
                    }
                }
                }
            }
        }
    }
    
    func fetchDetailPhoto(searchQuery: String) {
           
           
           PixabayAPIClient.fetchPhotos(searchQuery: searchQuery) { [weak self] (result) in
               switch result {
               case .failure:
                   print("Unable to retrieve detail photo")
               case .success(let photoInfo):
                self?.photoDetails = photoInfo.first
                           }
                           
                       }
                   }
    
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherInformation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "forecastCell", for: indexPath) as? ForecastCell else {
            fatalError("Unable to dequeue ForecastCell")
        }
        
        let weatherInfo = weatherInformation[indexPath.row]
        cell.configureCell(weatherInfo: weatherInfo)
        
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxWidth: CGFloat = UIScreen.main.bounds.size.width
        let maxHeight:CGFloat = UIScreen.main.bounds.size.height
        let itemWidth = maxWidth * 0.25
        let itemHeight = maxHeight * 0.30
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photoDetails = photoDetails else {
            return
        }
        
        let forecast = weatherInformation[indexPath.row]
        let detailVC = DetailViewController(dataPersistence: dataPersistenece, photoInfo: photoDetails)
        detailVC.weatherInfo = forecast
        detailVC.cityName = cityName
        
        detailVC.photoInfo = photoDetails
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField.text != nil else {
            return false
        }
        
        
        if textField.text?.count != 5 {
            // TODO: Add some alert here that says please enter valid zip code and remove print statement
            showAlert(title: "Invalid Entry", message: "Please enter a valid zipcode")
        } else {
            
            let zipcode = textField.text ?? "11234"
            getZipCode(zipCode: zipcode)
            zipCode = zipcode
            textField.resignFirstResponder()
            print(zipCode)
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let components = string.components(separatedBy: acceptableCharacters)
        let filtered = components.joined(separator: "")
        if string == filtered  {
            return true
        } else {
            //This line prevents the user from entering anything but a number
            //TODO: Add alert that says please enter a valid zip code
            print("Please enter a valid zipcode")
            return false 
            
            
            // https://riptutorial.com/ios/example/24016/uitextfield---restrict-textfield-to-certain-characters
        }
        
    }
    
}


