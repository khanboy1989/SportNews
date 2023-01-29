//
//  CustomSegmentItem.swift
//  SportNews
//
//  Created by Serhan Khan on 29.01.23.
//

import UIKit

final class CustomSegmentItemView: UIView, NibOwnerLoadable {
    
    //MARK: - UI Elements
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var indicator: UIView!
    @IBOutlet private weak var selectButton: UIButton! 
    
    //MARK: - On Tap Closure
    var onTap: ( ( CustomSegmentItem?, Int?) -> Void)?
    
    //MARK: - Parameters
    var item: CustomSegmentItem? {
        didSet {
            refresh()
        }
    }
    
    var isSelected: Bool = false {
        didSet {
            refresh()
        }
    }
    
    var index: Int?

    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNibContent()
        sharedInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadNibContent()
        sharedInit()
    }
    
    init(item: CustomSegmentItem, index: Int) {
        super.init(frame: .zero)
        self.loadNibContent()
        self.item = item
        self.index = index
        sharedInit()
    }
    
    private func sharedInit() {
        indicator.backgroundColor = Asset.Colors.segmentSelected.color
        indicator.layer.cornerRadius = indicator.layer.frame.height / 2.0
        selectButton.setTitle("", for: .normal)
    }
    
    //MARK: - Refresh
    //refeshes the view depending on selected item
    private func refresh() {
        titleLabel.text = item?.title
        switch isSelected {
        case true:
            titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
            titleLabel.textColor = Asset.Colors.black.color
            setView(view: indicator, hidden: false)
        case false:
            titleLabel.font = UIFont.systemFont(ofSize: 16)
            titleLabel.textColor = Asset.Colors.segmentTitleUnSelected.color
            setView(view: indicator, hidden: true)
        }
    }
    
    private func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
    
    //MARK: - IBAction
    @IBAction private func didTap(sender: UIButton) {
        onTap?(item, index)
    }
}

struct CustomSegmentItem {
    var title: String
    var isSelected: Bool
    var type: DefaultNewsOverviewViewModel.Section
}
