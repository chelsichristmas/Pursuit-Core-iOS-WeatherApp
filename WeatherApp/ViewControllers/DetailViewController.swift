//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Chelsi Christmas on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import ImageKit

class DetailViewController: UIViewController {
    
    private let detailView = DetailView()
    
    public var weatherInfo: Details?
    public var cityName: String?
    public var photoInfo: PhotoDetails?

    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        updateUI()
        
 
        
    }
    
   
    func updateUI() {
        self.detailView.forecastLabel.text = "Weather Forecast for \(cityName!)"
        



        self.detailView.imageView.getImage(with: photoInfo!.largeImageURL) { (result) in
            switch result {
            case .failure(let appError):
                print("Error getting image: \(appError)")
            case . success(let image):
                DispatchQueue.main.async {
                self.detailView.imageView.image = image
                }
            }
        }
        
    }
    
   
                
            }
       
