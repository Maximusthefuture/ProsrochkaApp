//
//  ExpirationDateViewController.swift
//  ProsrochkaApp
//
//  Created by Maximus on 22.03.2022.
//

import Foundation
import UIKit


class ExpirationDateViewController: UIViewController {
    
    let dateSegmentControlPadding: CGFloat = 16
    let numPadCollectionView = NumpadCollectionViewController()
    
    let viewModel = ExpirationDateViewModel()
    
    let createDateTextField: CustomTextField = {
        $0.keyboardType = .numberPad
        $0.placeholder = "Дата изготовления (день-месяц-год)"
        return $0
    }(CustomTextField(frame: .zero))
    
    let expDateLabel: UILabel = {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return $0
    }(UILabel(frame: .zero))
    
    let addItemButton: UIButton = {
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 16
        $0.setTitle("Добавить", for: .normal)
        return $0
    }(UIButton(frame: .zero))
    
    let dateSegmentControl: UISegmentedControl = {
        
        $0.addTarget(self, action: #selector(handleDateSegmentControl), for: .valueChanged)
        $0.selectedSegmentIndex = 0
        return $0
    }(UISegmentedControl(items: ["Day", "Month", "Year"]))
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initViews()
        createDateTextField.delegate = self
        numPadCollectionView.dateDelegate = self
       

    }
    
    @objc private func handleDateSegmentControl(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
    }
    
    
    
    private func initViews() {
        view.addSubview(createDateTextField)
        view.addSubview(dateSegmentControl)
        view.addSubview(addItemButton)
        dateSegmentControl.anchor(top: createDateTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: dateSegmentControlPadding, left: dateSegmentControlPadding, bottom: 0, right: dateSegmentControlPadding))
        createDateTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        view.addSubview(numPadCollectionView.view)
        numPadCollectionView.view.anchor(top: dateSegmentControl.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        addItemButton.anchor(top: numPadCollectionView.view.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 42, bottom: 16, right: 42),size: .init(width: 0, height: 50))
        
    }
}

extension ExpirationDateViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        if textField.text!.count == 2 || textField.text!.count == 5 {
            if string != "" {
                textField.text = textField.text! + "-"
            }
           
            
        } else if textField.text?.count == 8 {
            viewModel.calculateExpDate(date: textField.text ?? "")
        }
        return textField.text?.count == 8 ? false : true
    }
}

extension ExpirationDateViewController: DateHandlerDelegate {
    func getExpDateNumbers(_ nums: String) {
        viewModel.changingDate?(nums)
    }
    
    
}
