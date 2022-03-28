//
//  ExpDateHeader.swift
//  ProsrochkaApp
//
//  Created by Maximus on 24.03.2022.
//

import Foundation
import UIKit

class ExpDateHeader: UICollectionReusableView {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(label)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        label.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
