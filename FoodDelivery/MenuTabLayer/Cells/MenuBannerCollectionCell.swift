//
//  MenuAdsCollectionCell.swift
//  FoodDelivery
//
//  Created by Stanislav Lezovsky on 03.04.2023.
//

import UIKit

final class MenuBannerCollectionCell: UICollectionViewCell {
    
    static let id = String(describing: MenuBannerCollectionCell.self)
    
    private let bannerImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configAppearance()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Config Appearance
private extension MenuBannerCollectionCell {
    
    func configAppearance() {
        bannerImageView.image = UIImage(named: "ad1")
        bannerImageView.layer.cornerRadius = 20
        bannerImageView.contentMode = .scaleAspectFill
        bannerImageView.clipsToBounds = true
    }
}

// MARK: - Make Constraints
private extension MenuBannerCollectionCell {
    
    func makeConstraints() {
        addSubview(bannerImageView)
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bannerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bannerImageView.topAnchor.constraint(equalTo: topAnchor),
            bannerImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
