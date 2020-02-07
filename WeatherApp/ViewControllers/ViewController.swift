//
//  ViewController.swift
//  WeatherApp
//
//  Created by David Rifkin on 10/8/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

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
                
                WeatherAPIClient.fetchWeatherInfo(latitude: coordinates.lat, longitude: coordinates.long) { (result) in
                    switch result {
                    case .failure(let appError):
                        print("Unable to retrieve data: \(appError)")
                    case .success(let weatherInfo):
                        self.weatherInformation = weatherInfo
                        
                    }
                }
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
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            fatalError("No Valid entry")
        }
        if text.count == 0 || text.count > 5 {
            // TODO: Add some alert here that says please enter valid zip code and remove print statement
            print("Please enter a valid zip code")
        } else {
            getZipCode(zipCode: text)
            zipCode = text
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
