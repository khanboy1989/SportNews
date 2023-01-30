//
//  UITableViewCell + Extensions.swift
//  SportNews
//
//  Created by Serhan Khan on 28.01.23.
//

import UIKit

//Extension class for UITableViewCell in order to return the Identifier
//and creation of the TableViewCell
//quite handy way in order to create tableviewcell
extension UITableViewCell {

    //return identifier
    static var identifier: String {
        return String(describing: self)
    }
    //create tableviewcell
    static func create(tableView: UITableView,reuseIdentifier: String? = nil) -> Self {
        return create(tableView: tableView, reuseIdentifier: (reuseIdentifier ?? identifier), type: self)
    }
    
    fileprivate static func create<T: UITableViewCell>(tableView: UITableView, reuseIdentifier: String,type: T.Type) -> T {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? T else {
            let nib = UINib(nibName: reuseIdentifier, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
            return create(tableView: tableView,reuseIdentifier: reuseIdentifier, type: type)
        }
        return cell
    }
}
