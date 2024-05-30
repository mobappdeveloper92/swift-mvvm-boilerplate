//
//  Created by Faizan Mahmood on 25/05/2022.
//

import UIKit

class CountrySelectionTableViewCell: UITableViewCell {
    
    static let id: String = "CountrySelectionTableViewCell"
    static let nib: UINib = UINib(nibName: "CountrySelectionTableViewCell", bundle: nil)
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCode: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        prepareImageView()
    }
    
    func bindData(data: Country?, type: CountrySelectionType) {
        guard let data = data else {
            return
        }
        if type == .country {
            lblName.text = data.name
            lblCode.isHidden = true
        } else {
            lblName.text = data.name
            lblCode.text = "(\(data.code ?? ""))"
        }
        imgView.image = data.flag
    }
}

// MARK: - View Related
private extension CountrySelectionTableViewCell {
    func prepareImageView() {
//        imgView.roundCorners(corners: .allCorners, radius: 5.0)
    }
}
