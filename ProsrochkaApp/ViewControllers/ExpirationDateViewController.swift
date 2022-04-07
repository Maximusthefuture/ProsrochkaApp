//
//  ExpirationDateViewController.swift
//  ProsrochkaApp
//
//  Created by Maximus on 22.03.2022.
//

import Foundation
import UIKit



class ExpirationDateViewController: UIViewController {
    
    private let dateSegmentControlPadding: CGFloat = 16
//    private let numPadCollectionView = NumpadCollectionViewController()
    var getDate:((Date?, Date?) -> Void)?
    var dateClosure:((String) -> Void)?
    
    private let viewModel = ExpirationDateViewModel()
    
    private let createDateTextField: CustomTextField = {
        $0.placeholder = "Дата изготовления"
        return $0
    }(CustomTextField(frame: .zero))
    
    private let expDateTextField: CustomTextField = {
        $0.placeholder = "Дата окончания срока годности"
        return $0
    }(CustomTextField(frame: .zero))
    
    private let shelfLifeTextField: CustomTextField = {
        $0.placeholder = "Срок годности"
        return $0
    }(CustomTextField(frame: .zero))
    
    private let expDateLabel: UILabel = {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return $0
    }(UILabel(frame: .zero))
    
    private let addItemButton: UIButton = {
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 16
        $0.setTitle("Добавить", for: .normal)
        $0.addTarget(self, action: #selector(handleAddItemButton), for: .touchUpInside)
        return $0
    }(UIButton(frame: .zero))
    
    var createDatePicker = UIDatePicker()
    
    var expDatePicker = UIDatePicker()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        initViews()
        shelfLifeTextField.delegate = self
        expDateTextField.delegate = self
        
        initStackView()
        datePickerInit()
        setupToolbar()
   
       
    }
    
    @objc private func handleAddItemButton(_ sender: UIButton) {
        dismiss(animated: true)
        getDate?(viewModel.createdDate, viewModel.finalDate)
    }
    
    
    private func datePickerInit() {
        createDatePicker.datePickerMode = .date
        expDatePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            createDatePicker.preferredDatePickerStyle = .wheels
            expDatePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        createDateTextField.inputView = createDatePicker
        expDateTextField.inputView = expDatePicker
    }
    
    private func setupToolbar() {
        let createBar = UIToolbar()
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(hideKeyBoard))
        createBar.items = [done]
        createBar.sizeToFit()
        let expBar = UIToolbar()
        let expDone = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(expTextFieldHandleChange))
        expBar.items = [expDone]
        expBar.sizeToFit()
        createDateTextField.inputAccessoryView = createBar
        expDateTextField.inputAccessoryView = expBar
        
       
    }

    @objc private func expTextFieldHandleChange() {
        self.view.endEditing(true)
        expDateTextField.text = "\(expDatePicker.date)"
//        viewModel.expDate.value = expDatePicker.date
    }
    
    @objc private func hideKeyBoard() {
        self.view.endEditing(true)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let newString = dateFormatter.string(from: createDatePicker.date)
        createDateTextField.text = newString
//        viewModel.createdDate.value = createDatePicker.date
    }

    private func initStackView() {
        let stackView = UIStackView(arrangedSubviews:
                                        [createDateTextField, shelfLifeTextField, expDateTextField, addItemButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        addItemButton.translatesAutoresizingMaskIntoConstraints = false
        addItemButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        view.addSubview(stackView)
        
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
    }
}



extension ExpirationDateViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("text is", textField.text)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
//        print("text is changing", textField.text)
        if textField == expDateTextField {
//            expDateTextField.text = viewModel.getShelfTime(text: createDateTextField.text!)
        } else if textField == createDateTextField {
            
        } else if textField == shelfLifeTextField {
            expDateTextField.text = viewModel.getShelfTime(text: createDateTextField.text!, shelfTime: shelfLifeTextField.text! )
        }
    }
}

extension ExpirationDateViewController: DateHandlerDelegate {
    func getExpDateNumbers(_ nums: String) {
        viewModel.changingDate?(nums)
    }
}
