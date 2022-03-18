//
//  AddEditProductViewController.swift
//  ProsrochkaApp
//
//  Created by Maximus on 16.03.2022.
//

import Foundation
import UIKit


class AddEditProductViewController: UIViewController {
    
    
    let imageView: UIImageView = {
        $0.backgroundColor = .systemGray
        return $0
    }(UIImageView(frame: .zero))
    
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
        } else {
            // Fallback on earlier versions
        }
        $0.addTarget(self, action: #selector(imageChoiceActionSheet), for: .touchUpInside)
        return $0
    }(UIButton(frame: .zero))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        initImageView()
        initTextFields()
    }
    
    private func initImageView() {
        view.addSubview(imageView)
        view.addSubview(photoIcon)
        imageView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 250))
        photoIcon.anchor(top: imageView.topAnchor, leading: imageView.leadingAnchor, bottom: imageView.bottomAnchor, trailing: imageView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    @objc private func imageChoiceActionSheet() {
        let picker = UIImagePickerController()
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            picker.sourceType = .camera
            picker.allowsEditing = true
            picker.delegate = self
            self.present(picker, animated: true)
        }
        
        let imageGalleryAction = UIAlertAction(title: "Image gallery", style: .default) { alert in
            picker.delegate = self
            self.present(picker, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(imageGalleryAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
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

extension AddEditProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        imageView.image = image?.withRenderingMode(.alwaysOriginal)
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}

