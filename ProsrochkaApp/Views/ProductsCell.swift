//
//  ProductsCell.swift
//  ProsrochkaApp
//
//  Created by Maximus on 16.03.2022.
//

import UIKit

class ProductsCell: UITableViewCell {

    let name: UILabel = {
        return $0
    }(UILabel(frame: .zero))
    
    let productPicture: UIImageView = {
        $0.layer.cornerRadius = 9
        $0.image?.withRenderingMode(.alwaysTemplate)
        $0.clipsToBounds = true
        $0.image = UIImage(named: "fish")
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView(frame: .zero))
    
    let expDate: UILabel = {
        return $0
    }(UILabel(frame: .zero))
    
    
    let toDate: UILabel = {
        return $0
    }(UILabel(frame: .zero))
    
    lazy var stackView: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 5
        return $0
    }(UIStackView(frame: .zero))
    
    let roundedView: UIView =  {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
        return $0
    }(UIView(frame: .zero))
    
    
    
    
    func configure(viewModel: ProductListViewModelImp?, indexPath: IndexPath) {
        let product = viewModel?.listOfProduct[indexPath.row]
        stackView.isAccessibilityElement = false
        stackView.accessibilityIdentifier = "StackView"
        guard let count = product?.tags else { return }
        for title in count {
            if stackView.subviews.count == (count.count) {
                break
            }
            let tagView = TagUIView()
            tagView.label.text = title
            tagView.label.textColor = .white
            tagView.backgroundColor = .blue
            
            stackView.addArrangedSubview(tagView)
        }
        name.text = product?.name
        expDate.text = "До: \((viewModel?.convertData(date: product?.expiredDate ?? Date()))!)"
        let remainDaysFromToday = viewModel!.calculateTotalDaysUntilExp(Date(), product?.expiredDate)
        if remainDaysFromToday.starts(with: "-") {
            let days = remainDaysFromToday.dropFirst()
            toDate.text = "Просрочено на \(String(days)) дней"
        } else {
            toDate.text = "Осталось \(remainDaysFromToday)  из \(viewModel!.calculateTotalDaysUntilExp(product?.createdDate, product?.expiredDate)) дней"
            if Int(remainDaysFromToday)! < 4 {
                roundedView.backgroundColor = .red
            }
            
        }
    }
    
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = #colorLiteral(red: 0.9682769179, green: 0.9684478641, blue: 1, alpha: 1)
        addSubview(roundedView)
        roundedView.applyShadows(cornedRadius: 8)
        backgroundColor = .clear
        roundedView.addSubview(name)
        roundedView.addSubview(expDate)
        roundedView.addSubview(toDate)
        contentView.addSubview(stackView)
        roundedView.addSubview(productPicture)
        roundedView.backgroundColor = .white
        roundedView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 8, bottom: 0, right: 8))
        productPicture.anchor(top: roundedView.topAnchor, leading: roundedView.leadingAnchor, bottom: roundedView.bottomAnchor, trailing: nil, padding: .init(top: 8, left: 8, bottom: 8, right: 0), size: .init(width: 100, height: 100))
        name.anchor(top: roundedView.topAnchor, leading: productPicture.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 8, bottom: 0, right: 0))
        expDate.anchor(top: name.bottomAnchor, leading: productPicture.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 8, bottom: 0, right: 0))
        toDate.anchor(top: expDate.bottomAnchor, leading: productPicture.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 8, bottom: 0, right: 0))
        stackView.anchor(top: toDate.bottomAnchor, leading: productPicture.trailingAnchor, bottom: roundedView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 8, bottom: 8, right: 0))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    override func prepareForReuse() {
        super.prepareForReuse()
        productPicture.image = nil
        name.text = nil
        expDate.text = nil
        toDate.text = nil
       
    }
    
}
