//
//  PriceView.swift
//  FoodDelivery
//
//  Created by Stanislav Lezovsky on 03.04.2023.
//

import UIKit

final class PriceView: UIView {
    
    private let titleLabel = UILabel()
    
    var text: String? {
        get {
            nil
        }
        set {
            titleLabel.text = "От " + String(Int.random(in: 250...650)) + " ₽"
        }
    }
    
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
private extension PriceView {
    
    func configAppearance() {
        layer.borderWidth = 1
        layer.borderColor = Colors.PriceViewColors.priceViewBorderColor
        layer.cornerRadius = 6
        
        titleLabel.font = Fonts.priceFont
        titleLabel.textAlignment = .center
        titleLabel.textColor = Colors.PriceViewColors.priceViewTextColor
    }
}

// MARK: - Constraints
private extension PriceView {
    
    func makeConstraints() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
        ])
    }
}
