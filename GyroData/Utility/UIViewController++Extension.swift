//
//  UIViewController++Extension.swift
//  GyroData
//
//  Created by 강민수 on 2023/06/15.
//

import UIKit

extension UIViewController {
    func showErrorAlertController(_ error: Error) {
        let alertController = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}
