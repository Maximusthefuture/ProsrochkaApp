//
//  AddEditProductViewController.swift
//  ProsrochkaApp
//
//  Created by Maximus on 16.03.2022.
//

import Foundation
import UIKit


class AddEditProductViewController: UIViewController {
    
    
    let imageView: UIView = {
        $0.backgroundColor = .systemGray
        return $0
    }(UIView(frame: .zero))
    
    let nameTextField: CustomTextField = {
        $0.placeholder = "Название"
        return $0
    }(CustomTextField(frame: .zero))
    
    let descriptionTextField: CustomTextField = {
        $0.placeholder = "Description"
        return $0
    }(CustomTextField(frame: .zero))
    
    let quantityTextField: CustomTextField = {
        $0.placeholder = "Количество"
        $0.keyboardType = .numberPad
        return $0
    }(CustomTextField(frame: .zero))
    
    let tagsTextField: CustomTextField = {
        $0.placeholder = "Тэги"
        $0.keyboardType = .numberPad
        return $0
    }(CustomTextField(frame: .zero))
    
    let calculatorButton: UIButton = {
        $0.setTitle("Расчитать срок годности", for: .normal)
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 16
        return $0
    }(UIButton(frame: .zero))
    
    let saveButton: UIButton = {
        $0.setTitle("Сохранить", for: .normal)
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 16
        return $0
    }(UIButton(frame: .zero))
    
    let photoIcon: UIButton = {
        if #available(iOS 13.0, *) {
            $0.setImage(UIImage(systemName: "camera.fill"), for: .normal)
            $0.imageView?.tintColor = .white
//            $0.backgroundColor = .black
        } else {
            // Fallback on earlier versions
        }
        return $0
    }(UIButton(frame: .zero))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isOpaque = true
        initImageView()
        initTextFields()
    
    }
    
    private func initImageView() {
        view.addSubview(imageView)
        imageView.addSubview(photoIcon)
        imageView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 250))
        photoIcon.anchor(top: imageView.topAnchor, leading: imageView.leadingAnchor, bottom: imageView.bottomAnchor, trailing: imageView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    
    
    private func initTextFields() {
        
        let stackView = UIStackView(arrangedSubviews: [nameTextField, descriptionTextField, quantityTextField])
        
        view.addSubview(nameTextField)
        view.addSubview(descriptionTextField)
        view.addSubview(quantityTextField)
        view.addSubview(tagsTextField)
        view.addSubview(calculatorButton)
        view.addSubview(saveButton)
        nameTextField.anchor(top: imageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        descriptionTextField.anchor(top: nameTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        quantityTextField.anchor(top: descriptionTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        tagsTextField.anchor(top: quantityTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        calculatorButton.anchor(top: tagsTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 100))
        saveButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 50))
    }
}
