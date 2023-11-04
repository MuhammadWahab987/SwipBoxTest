//
//  UICollectionView.swift
//  MVVM Architecture
//
//  Created by Zeshan on 19/04/2021.
//

import UIKit

extension UICollectionView {
    
    func showEmptyView(withMessage text: String) {
//        let noTasksView = NoTaskView.instanceFromNib()
////        noTasksView.showMessage(text)
//        self.backgroundView = noTasksView
    }
}

extension UICollectionView {
    
    func registerCell<T: UICollectionViewCell>(class: T.Type) {
        self.register(UINib(nibName: T.className(), bundle: Bundle.main), forCellWithReuseIdentifier: T.className())
    }
    
    
//    func dequeReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
//        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier!, for: indexPath) as? T else {
//            fatalError("Unable to deque reusable cell with identifier " +  T.reuseIdentifier)
//        }
//        return cell
//    }
}
