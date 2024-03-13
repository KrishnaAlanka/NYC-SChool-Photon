//
//  Utility.swift
//  NYCSchool
//
//  Created by Krishna on 3/13/24.
//

import Foundation
import SwiftUI

class Utility {
    static func showAlert(message: String) {
        if let windoScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let rootviewController = windoScene.windows .first?.rootViewController {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            rootviewController.present(alert, animated: true, completion: nil)
        }
    }
}
