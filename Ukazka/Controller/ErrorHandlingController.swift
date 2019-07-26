//
//  ErrorHandlingController.swift
//  Ukazka
//
//  Created by Jiří Chlum on 26/07/2019.
//  Copyright © 2019 Jiří Chlum. All rights reserved.
//

import UIKit

protocol ErrorHandlingController {
    func handle(error: APIError)
}

extension ErrorHandlingController where Self: UIViewController {

    func handle(error: APIError) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}
