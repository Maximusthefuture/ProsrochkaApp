//
//  ViewController.swift
//  ProsrochkaApp
//
//  Created by Maximus on 16.03.2022.
//

import UIKit

class ProductListViewController: UIViewController {
    
    
    
    private let addButton: UIButton = {
        $0.setTitle("+ Добавить", for: .normal)
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 16
        $0.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
        return $0
    }(UIButton(frame: .zero))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initViews()
    }
    
    private func initViews() {
        view.addSubview(addButton)
        addButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 50))
    }
    
    
    @objc private func handleAddButton(_ sender: UIButton) {
        let vc = AddEditProductViewController()
        navigationController?.pushViewController(vc, animated: true)
    }


}

