//
//  ViewController.swift
//  ProsrochkaApp
//
//  Created by Maximus on 16.03.2022.
//

import UIKit

class ProductListViewController: UIViewController {
    
    private let tableView = UITableView()
    private let viewModel = ProductListViewModel()
    
    private let addButton: UIButton = {
        $0.setTitle("+ Добавить", for: .normal)
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 16
        $0.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
        return $0
    }(UIButton(frame: .zero))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getProducts()
        view.backgroundColor = .white
        initTableView()
        initViews()
    }
    
    private func initTableView() {
        let padding: CGFloat = 8
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(ProductsCell.self, forCellReuseIdentifier: String.init(describing: ProductsCell.self))
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: padding, left: padding, bottom: padding, right: padding))
    }
    
    private func initViews() {
        view.addSubview(addButton)
        addButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 50))
    }
    
    @objc private func handleAddButton(_ sender: UIButton) {
        let vc = AddEditProductViewController()
        //MARK: Move to DI
        vc.coreDataStack = viewModel.coreDataStack
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: ProductsCell.self), for: indexPath) as! ProductsCell
        let product = viewModel.listOfProduct[indexPath.row]
        cell.name.text = product.name
        cell.expDate.text = "\(product.expiredDate)"
        cell.toDate.text = "Осталось 5 из 14 дней"
        cell.configure(viewModel: viewModel)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listOfProduct.count
    }
}


extension ProductListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}


