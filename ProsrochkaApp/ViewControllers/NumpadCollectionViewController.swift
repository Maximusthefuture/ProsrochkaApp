//
//  NumpadCollectionViewController.swift
//  ProsrochkaApp
//
//  Created by Maximus on 22.03.2022.
//

import UIKit
import SwiftUI

private let reuseIdentifier = "Cell"

protocol DateHandlerDelegate: AnyObject {
    func getExpDateNumbers(_ nums: String)
}

class NumpadCollectionViewController: UICollectionViewController {
    
    private let headerId = "headerId"
    weak var dateDelegate: DateHandlerDelegate?
    var dateClosure: ((String) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        self.collectionView!.register(NumpadCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(ExpDateHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    private let numArray = ["1","2","3","4","5","6","7","8","9","0"]
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ExpDateHeader
       
        header.label.text = displayData
        
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let height = view.frame.height * 0.15
        return .init(width: view.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    var displayData = ""
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NumpadCollectionViewCell
        let num = numArray[indexPath.row]
        cell.label.text = num
        cell.backgroundColor = .red
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        displayData += numArray[indexPath.row]
        dateDelegate?.getExpDateNumbers(numArray[indexPath.row])
//        dateClosure = { date in
//            print("DATE IS", date)
//            self.displayData = date
//        }
        dateClosure?("fsdf®sdf")
        collectionView.reloadData()
        print(numArray[indexPath.row])
    }
    
    
    
}

extension NumpadCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let leftRightPadding = view.frame.width * 0.13
        let interSpacing = view.frame.width * 0.1
        let cellWidth = (view.frame.width - 2 * leftRightPadding  - 2 * interSpacing) / 3
        return .init(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        
        let leftRightPadding = view.frame.width * 0.15
        let interSpacing = view.frame.width * 0.1
        
        return .init(top: interSpacing, left: leftRightPadding, bottom: interSpacing, right: leftRightPadding)
    }
    
    
}

@available(iOS 13.0.0, *)
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return NumpadCollectionViewController()
    }
}

@available(iOS 13.0, *)
struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            ViewControllerRepresentable()
        }
    }
}

