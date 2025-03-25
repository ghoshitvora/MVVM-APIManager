//
//  Untitled.swift
//  MVVM-APIManager
//
//  Created by Ghoshit.
//

import Foundation
import UIKit

struct AppConstants {
    
    private static var environment: ApiEnvironment = .production
    
    static func setupAPI(env: ApiEnvironment) {
        environment = env
    }
    
    static var BASE_URL: String {
        switch environment {
        case .production:
            return "https://api.restful-api.dev/"
        case .development:
            return "https://api.restful-api.dev/"
        case .staging:
            return "https://api.restful-api.dev/"
        }
    }
}

struct ApiURLS {
    static var objectData: String {
        return "\(AppConstants.BASE_URL)objects"
    }
}
