//
//  EmptyDataView.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 20/04/2022.
//

import UIKit

class EmptyDataView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var verticalCenterConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindData(_ type: EmptyDataType, verticalPostition: CGFloat = 0) {
        imageView.image = type.getImage()
        lblTitle.text = type.getTitle()
        lblDescription.text = type.getDescription()
        verticalCenterConstraint.constant = verticalPostition
    }
    
    func moveVerticalCenter(to position: CGFloat) {
        verticalCenterConstraint.constant = position
    }
}

internal extension EmptyDataView {
    func loadNib() {
        let view = getNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }

    func getNib() -> UIView {
        let bundle = Bundle(for: EmptyDataView.self)
        let nib = UINib(nibName: "EmptyDataView", bundle: bundle)
        guard let customView = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return UIView()
        }
        return customView
    }
}

enum EmptyDataType {
    case general
    
    func getImage() -> UIImage? {
        return #imageLiteral(resourceName: "no_data_found")
    }
    
    func getTitle() -> String {
        switch self {
        case .general:
            return "No Data Found!"
        }
    }
    
    func getDescription() -> String {
        switch self {
        case .general:
            return "When you have data, you will see it here."
        }
    }
}

extension UITableView {
    func showEmptyDataView(_ isShow: Bool, for type: EmptyDataType = .general) {
        let emptyDataView = EmptyDataView()
        emptyDataView.bindData(type, verticalPostition: self.estimatedSectionHeaderHeight/2)
        self.backgroundView = isShow ? emptyDataView : nil
    }
}
