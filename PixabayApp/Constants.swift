//
//  Constants.swift
//  PixabayApp
//
//  Created by Askar on 14.02.2023.
//

import Foundation
import UIKit

struct Constants {
    
    struct Identifiers {
        static let mediaCollectionViewCell = "MediaCollectionViewCell"
    }
    
    struct Values {
        static let screenWidth = UIScreen.main.bounds.width
    }
    
    struct Colors {
        static let imageCell = UIColor(red: 237/255, green: 248/255, blue: 235/255, alpha: 1)
        static let videoCell = UIColor(red: 30/255, green: 107/255, blue: 223/255, alpha: 0.2)
    }
}

enum MediaType: String {
    case image = "Image"
    case video = "Video"
}
