//
//  NewOverviewTableViewCell.swift
//  SportNews
//
//  Created by Serhan Khan on 28.01.23.
//

import UIKit
import Kingfisher

class NewOverviewTableViewCell: UITableViewCell {
  
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var iconImageView: UIImageView! 
    
    private func fill(item: NewOverviewViewModel) {
        titleLabel.text = item.item.title
        dateLabel.text = item.item.readableDate
        guard let imageUrl = item.item.image.imageLargeUrl else { return }
        iconImageView.kf.setImage(with: imageUrl)
    }

    static func create(tableView: UITableView, item: NewOverviewViewModel) -> NewOverviewTableViewCell {
        let cell = NewOverviewTableViewCell.create(tableView: tableView)
        cell.fill(item: item)
        cell.selectionStyle = .none
        return cell
    }

}
