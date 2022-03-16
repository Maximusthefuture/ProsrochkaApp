//
//  CustomTextField.swift
//  InformationApp
//
//  Created by Maximus on 04.03.2022.
//

import UIKit

class CustomTextField: UITextField {

    private let padding: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        borderStyle = .line
        layer.cornerRadius = 6
        layer.borderWidth = 1
        layer.masksToBounds = true
        layer.borderColor = UIColor.systemGray.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: .init(top: padding, left: padding, bottom: padding, right: 0))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: .init(top: padding, left: padding, bottom: padding, right: 0))
    }
    
}
