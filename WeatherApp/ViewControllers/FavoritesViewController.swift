//
//  FavoritesViewController.swift
//  WeatherApp
//
//  Created by Chelsi Christmas on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import DataPersistence

class FavoritesViewController: UIViewController {

    private var photos = [PhotoDetails]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private var dataPersistence = DataPersistence<PhotoDetails>(filename: "photos.plist")
    @IBOutlet weak var tableView: UITableView!
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadPhotos()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    private func loadPhotos() {
        
        do {
         try  photos = dataPersistence.loadItems()
        } catch {
            print("Unable to load photos")
        }
        
    }
    



}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PhotoCell else {
            fatalError("Unable to deque phot cell")
        }
        
        let photo = photos[indexPath.row]
        cell.configureCell(photo: photo)
        return cell
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        240
    }
}
