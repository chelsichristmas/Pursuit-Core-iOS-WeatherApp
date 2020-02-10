//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Chelsi Christmas on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let detailView = DetailView()
    
    public var weatherInfo: Details?
    public var cityName: String?

    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        
 
        
    }
    
    func updateUI() {
        self.detailView.forecastLabel.text = "Weather Forecast for \(cityName!)"
        
        
    }
    
     
    

}
