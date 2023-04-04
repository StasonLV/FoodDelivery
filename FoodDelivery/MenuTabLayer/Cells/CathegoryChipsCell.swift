//
//  MenuCathegoryCollectionCell.swift
//  FoodDelivery
//
//  Created by Stanislav Lezovsky on 03.04.2023.
//

import UIKit

final class CathegoryChipsCell: UICollectionViewCell {
    
    static let id = String(describing: CathegoryChipsCell.self)
    
    private let titleLabel = UILabel()
    
    override var isSelected: Bool {
        didSet {
            isSelected(bool: oldValue)
        }
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize,
                                          withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
                                          verticalFittingPriority: UILayoutPriority) -> CGSize {
        
        return CGSize(width: configCellWidth(),
                      height: targetSize.height)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cellDidNotSelect()
        configAppearance()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CathegoryChipsCell {
    
    func config(_ category: String) {
        self.titleLabel.text = category
    }
}

// MARK: - Logic
private extension CathegoryChipsCell {
    
    func isSelected(bool: Bool) {
        switch isSelected {
        case true:
            cellDidSelect()
        case false:
            cellDidNotSelect()
        }
    }
    
    func cellDidSelect() {
        titleLabel.textColor = Colors.CathegoryChipsColors.cathegorySelectedLabelTextColor
        backgroundColor = Colors.CathegoryChipsColors.cathegorySelectedChipsColor
        titleLabel.font = Fonts.cathegorySelectedFont
        layer.borderWidth = 0
    }
    
    func cellDidNotSelect() {
        backgroundColor = Colors.CathegoryChipsColors.cathegoryNotSelectedChipsColor
        layer.borderWidth = 1
        layer.borderColor = Colors.CathegoryChipsColors.cathegoryNotSelectedBorderColor
        titleLabel.font = Fonts.cathegoryNotSelectedFont
        titleLabel.textColor = Colors.CathegoryChipsColors.cathegoryNotSelectedLabelTextColor
    }
    
    func configCellWidth() -> CGFloat {
        let font = UIFont.systemFont(ofSize: 13)
        let attributes = [NSAttributedString.Key.font : font as Any]
        
        return titleLabel.text!
            .size(withAttributes: attributes).width + 50
    }
}

// MARK: - Config Appearance
private extension CathegoryChipsCell {
    
    func configAppearance() {
        layer.cornerRadius = 16
        titleLabel.textAlignment = .center
    }
}

// MARK: - Make Constraints
private extension CathegoryChipsCell {
    
    func makeConstraints() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
