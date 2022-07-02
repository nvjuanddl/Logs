//
//  Describable.swift
//  Logs
//
//  Created by Juan Dario Delgado L on 1/07/22.
//

import UIKit

protocol Describable {
    static var name: String { get }
}

extension Describable {
    static var name: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Describable { }

extension UICollectionReusableView: Describable { }

extension UITableViewHeaderFooterView: Describable { }
