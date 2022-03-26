//
//  NumpadCollectionViewCell.swift
//  ProsrochkaApp
//
//  Created by Maximus on 22.03.2022.
//

import UIKit

class NumpadCollectionViewCell: UICollectionViewCell {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.textColor = .black
        label.textAlignment = .center
        label.fillSuperview()

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
