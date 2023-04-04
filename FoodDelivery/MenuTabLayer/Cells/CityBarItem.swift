//
//  CityBarItem.swift
//  FoodDelivery
//
//  Created by Stanislav Lezovsky on 03.04.2023.
//

import UIKit

final class CityBarItem: UIView {
    
    private let title = UILabel()
    private let imageView = UIImageView()
    
    init() {
        super.init(frame: .zero)
        configAppearance()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup UI
private extension CityBarItem {
    
    func configAppearance() {
        imageView.image = SFSymbols.MenuTabSymbols.citySymbol
        imageView.contentMode = .scaleAspectFill
        
        title.text = "Москва"
        title.textColor = Colors.CityBarItemColors.cityTextColor
        title.font = Fonts.cityBarFont
    }
}

// MARK: - Constraints
private extension CityBarItem {
    
    func makeConstraints() {
        addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.topAnchor.constraint(equalTo: topAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 8),
            imageView.heightAnchor.constraint(equalToConstant: 8),
            imageView.widthAnchor.constraint(equalToConstant: 14),
        ])
    }
}

