//
//  ConnectionAlert.swift
//  FoodDelivery
//
//  Created by Stanislav Lezovsky on 04.04.2023.
//

import UIKit

enum AppAlerts {
    static let connectionAlert: UIAlertController = {
        let alert = UIAlertController(
            title: "Не удалось загрузить меню",
            message: "У Вас отсутствует доступ к сети. Пожалуйста, проверьте соединение",
            preferredStyle: .alert
        )
        let actionClose = UIAlertAction(title: "Хорошо", style: .default)
        alert.addAction(actionClose)
        return alert
    }()
}
