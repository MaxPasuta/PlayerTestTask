//
//  Alerts.swift
//  PlayerTestTask
//
//  Created by Максим Пасюта on 06.04.2022.
//

import Foundation

import UIKit

struct Alerts{
    
    private static func showSimpleAlert(vc: UIViewController, title: String, message: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(ok)
        
        DispatchQueue.main.async {
            vc.present(alertController, animated: true, completion: nil)
        }
    }
    
    static func showErrortAlert(vc: UIViewController, message: String){
        showSimpleAlert(vc: vc,title: "Ошибка", message: message)
    }
    

    static func showSuccessAlert(vc: UIViewController, message: String){
        showSimpleAlert(vc: vc,title: "Сообщение", message: message)
    }
}
