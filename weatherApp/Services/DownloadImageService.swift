//
//  DownloadImageService.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 2.04.22.
//

import UIKit

class DownloadImageService {
    
    private let networkQueue = DispatchQueue(label: "networkQueue", qos: .userInitiated)

    
    //https://apidev.accuweather.com/developers/Media/Default/WeatherIcons/41-s.png
    func downloadImage(imageID: Int, complition: @escaping (UIImage) -> Void) {
        
        let host = "https://apidev.accuweather.com/developers/Media/Default/WeatherIcons/"
        var id: String {
            return imageID < 10 ? "0" + String(imageID) : String(imageID)
        }
        
        guard let url = URL(string: host + String(format: "%@-s.png", id)) else {return}
        
        networkQueue.async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        complition(image)
                    }
                }
            }
        }
    }
    
    
}
