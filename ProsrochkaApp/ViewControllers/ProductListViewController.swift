//
//  ViewController.swift
//  ProsrochkaApp
//
//  Created by Maximus on 16.03.2022.
//

import UIKit

class ProductListViewController: UIViewController {
    
    private let tableView = UITableView()
    private let viewModel = ProductListViewModelImp()
    
    private let addButton: UIButton = {
        $0.setTitle("+ Добавить", for: .normal)
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 16
        $0.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
        return $0
    }(UIButton(frame: .zero))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "circles.hexagonpath.fill"), style: .plain, target: self, action: nil)
        } else {
            // Fallback on earlier versions
        }
        view.backgroundColor = #colorLiteral(red: 0.9682769179, green: 0.9684478641, blue: 1, alpha: 1)
        initTableView()
        initViews()
        viewModel.getProducts()
    }
    
    private func initTableView() {
        let padding: CGFloat = 8
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = #colorLiteral(red: 0.9682769179, green: 0.9684478641, blue: 1, alpha: 1)
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
        vc.reload = {
            self.viewModel.getProducts()
            self.tableView.reloadData()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: ProductsCell.self), for: indexPath) as! ProductsCell
        let product = viewModel.listOfProduct[indexPath.row]
       
        cell.productPicture.image = UIImage(data: product.image ?? Data())
        
        cell.configure(viewModel: viewModel, indexPath: indexPath)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listOfProduct.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddEditProductViewController()
        vc.coreDataStack = viewModel.coreDataStack
        vc.productItem = viewModel.listOfProduct[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension ProductListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}


