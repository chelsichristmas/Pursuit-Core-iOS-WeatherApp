//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Chelsi Christmas on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import ImageKit
import DataPersistence

class DetailViewController: UIViewController {
    
    private let detailView = DetailView()
    
    public var weatherInfo: Details?
    public var cityName: String?
    public var photoInfo: PhotoDetails
    private var dataPersistence: DataPersistence<PhotoDetails>
    
    
    
    init(dataPersistence: DataPersistence<PhotoDetails>, photoInfo: PhotoDetails) {
        self.dataPersistence = dataPersistence
        self.photoInfo = photoInfo
        super.init(nibName: "ViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        view = detailView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        updateUI()
        detailView.favoriteButton.addTarget(self, action: #selector(favoriteButtonPressed(sender:)), for: .touchUpInside)
        
        updateFavoriteBookmark(photoInfo: photoInfo)
    }
    
    
    @objc func favoriteButtonPressed(sender: UIButton) {
        print("Button Pressed")
        
        if dataPersistence.hasItemBeenSaved(photoInfo) {
            
            detailView.favoriteButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            if let index = try? dataPersistence.loadItems().firstIndex(of: photoInfo) {
                do {
                    try dataPersistence.deleteItem(at: index)
                } catch {
                    print("error deleting photo")
                }
            }
        } else {
            do {
                detailView.favoriteButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                try dataPersistence.createItem(photoInfo)
                print("Photo Saved Successfully")
            } catch {
                print("error saving photo")
            }
        }
        
    }
    
    private func updateFavoriteBookmark(photoInfo: PhotoDetails) {
        if dataPersistence.hasItemBeenSaved(photoInfo) {
            detailView.favoriteButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            detailView.favoriteButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
    }
    
    
    
    
    func updateUI() {
        self.detailView.forecastLabel.text = "Weather Forecast for \(cityName!)"
        guard let weatherInfo = weatherInfo else { return }
        self.detailView.imageView.getImage(with: photoInfo.largeImageURL) { (result) in
            switch result {
            case .failure(let appError):
                print("Error getting image: \(appError)")
            case . success(let image):
                DispatchQueue.main.async {
                    self.detailView.imageView.image = image
                }
            }
        }
        
        self.detailView.descriptionLabel.text = "Description: \(weatherInfo.summary)"
        self.detailView.temperatureHighLabel.text = "High Temp: \(weatherInfo.temperatureHigh)"
        self.detailView.temperatureLowLabel.text = "Low Temp:\(weatherInfo.temperatureLow)"
        self.detailView.humidityLabel.text = "Humidity: \(weatherInfo.humidity)"
        self.detailView.windspeedLabel.text = "Windspeed: \(weatherInfo.windGust)"
        self.detailView.precipitationLabel.text = "Precipitation: \(weatherInfo.precipType ?? "No precipitation")"
        
        
    }
    
    
    
}

