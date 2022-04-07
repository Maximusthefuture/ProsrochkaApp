//
//  AddEditProductViewController.swift
//  ProsrochkaApp
//
//  Created by Maximus on 16.03.2022.
//


import UIKit
import Foundation
import VisionKit
import Vision

class AddEditProductViewController: UIViewController {
    
    var coreDataStack: CoreDataStack?
    var viewModel: AddEditViewModelImp?
    var reload: (() -> Void)?
    var productItem: Product?
    
    let imageView: UIImageView = {
        $0.backgroundColor = .purple
        return $0
    }(UIImageView(frame: .zero))
    
    let nameTextField: CustomTextField = {
        $0.placeholder = "Название"
        $0.addTarget(self, action: #selector(handleTextChange(textField:)), for: .editingChanged)
        return $0
    }(CustomTextField(frame: .zero))
    
 
    let descriptionTextField: CustomTextField = {
        $0.placeholder = "Description"
        $0.addTarget(self, action: #selector(handleTextChange(textField:)), for: .editingChanged)
        return $0
    }(CustomTextField(frame: .zero))
    
    let quantityTextField: CustomTextField = {
        $0.placeholder = "Количество"
        $0.keyboardType = .numberPad
        $0.addTarget(self, action: #selector(handleTextChange(textField:)), for: .editingChanged)
        return $0
    }(CustomTextField(frame: .zero))
    
    let tagsTextField: CustomTextField = {
        $0.placeholder = "Тэги"
        $0.addTarget(self, action: #selector(handleTextChange(textField:)), for: .editingChanged)
        return $0
    }(CustomTextField(frame: .zero))
    
    let calculatorButton: UIButton = {
        $0.setTitle("Расчитать срок годности", for: .normal)
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 16
        $0.addTarget(self, action: #selector(handleCalculation), for: .touchUpInside)
        return $0
    }(UIButton(frame: .zero))
    
    let saveButton: UIButton = {
        $0.setTitle("Сохранить", for: .normal)
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 16
        $0.addTarget(self, action: #selector(handleSaveButton), for: .touchUpInside)
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
        viewModel = AddEditViewModelImp(coreDataStack: coreDataStack!)
        view.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        setupTapGesture()
        view.resignFirstResponder()
        initImageView()
        initTextFields()
        initProduct()
        setupNotificationObserver()
       
    }
   
    fileprivate func setupTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
    }
    
    @objc func handleTapGesture(tapGesure: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    private func setupNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func handleKeyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.view.transform = .identity
        }
    }
    
    @available(iOS 13.0, *)
    func textRecognition(image: UIImage?) {
        guard let cgImage = image?.cgImage else { return }
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            let recognizedStrings = observations.compactMap({ observation in
                return observation.topCandidates(1).first?.string
            })
            print("STRING IS: ",recognizedStrings)
            DispatchQueue.main.async {
                self.nameTextField.text = recognizedStrings.first
            }
        }
       
        do {
            if #available(iOS 15.0, *) {
                let lang = try request.supportedRecognitionLanguages()
                print("LANG: ", lang)
            } else {
                // Fallback on earlier versions
            }
            try handler.perform([request])
        } catch {
            print("Error in textRecognition", error)
        }
        
        
    }
    
    @objc func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyBoardFrame = value.cgRectValue
        let bottomSpace = view.frame.height - calculatorButton.frame.origin.y - calculatorButton.frame.height
        let difference =  keyBoardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
        print("OBSERVERL: \(keyBoardFrame)")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func handleSaveButton(_ sender: UIButton) {
        viewModel?.saveData()
        reload?()
        navigationController?.popViewController(animated: true)
       
    }
    
    private func initProduct() {
        nameTextField.text = productItem?.name
        descriptionTextField.text = productItem?.productDescription
        if let quantity = productItem?.quantity,
            let items = productItem?.tags {
            quantityTextField.text = "\(Int(quantity))"
            for i in items {
                tagsTextField.text = i
            }
        }
        
        if let image = productItem?.image?.picture {
            imageView.image = UIImage(data: image)
        }
    }
    
    private func initImageView() {
        view.addSubview(imageView)
        view.addSubview(photoIcon)
        imageView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 250))
        photoIcon.anchor(top: imageView.topAnchor, leading: imageView.leadingAnchor, bottom: imageView.bottomAnchor, trailing: imageView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    @objc private func handleCalculation(_ sender: UIButton) {
        let vc = ExpirationDateViewController()
        vc.getDate = { [weak self] createdDate, expDate in
            self?.viewModel?.expiredDate = expDate
            self?.viewModel?.createdDate = createdDate
        }
        present(vc, animated: true, completion: nil)
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
    
    @objc fileprivate func handleTextChange(textField: UITextField) {
        if textField == nameTextField {
            viewModel?.nameProduct = textField.text
           
            
        } else if textField == descriptionTextField {
            viewModel?.productDescription = textField.text
        } else if textField == quantityTextField {
            if let quantityText = textField.text {
                viewModel?.productQuantity = Int16(quantityText)
                print(quantityText)
            }
        } else if textField == tagsTextField {
            viewModel?.tags = textField.text
        }
    }
}

extension AddEditProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        imageView.image = image?.withRenderingMode(.alwaysOriginal)
        viewModel?.imageData = imageView.image?.pngData()
        if #available(iOS 13, *) {
            textRecognition(image: UIImage(data: viewModel?.imageData ?? Data()))
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
       
        dismiss(animated: true)
    }
}

