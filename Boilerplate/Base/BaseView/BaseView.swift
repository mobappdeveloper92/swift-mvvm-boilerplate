import Foundation
import UIKit

@IBDesignable
class BaseView: UIView {

    var controller: UIViewController?

    // MARK: - Border
    @IBInspectable var isRounded: Bool = false
    @IBInspectable public var borderColor: UIColor = UIColor.clear {
        didSet { layer.borderColor = borderColor.cgColor }
    }
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet { layer.borderWidth = borderWidth }
    }
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet { layer.cornerRadius = cornerRadius }
    }

    // MARK: - Shadow
    @IBInspectable public var shadowOpacity: Float = 0 {
        didSet { layer.shadowOpacity = shadowOpacity }
    }
    @IBInspectable public var shadowColor: UIColor = UIColor.clear {
        didSet { layer.shadowColor = shadowColor.cgColor }
    }
    @IBInspectable public var shadowRadius: CGFloat = 0 {
        didSet { layer.shadowRadius = shadowRadius }
    }
    @IBInspectable public var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromNib()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if isRounded {
            self.cornerRadius = self.frame.size.height / 2
        }
    }

    func setBorders(borderColor: UIColor = .clear, borderWidth: CGFloat = 0, cornerRadius: CGFloat = 5) {
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.cornerRadius = cornerRadius
    }
}

extension UIView {
    @discardableResult
    func loadFromNib<T: UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self))
                .loadNibNamed(String(describing: type(of: self)),
                              owner: self,
                              options: nil)?
                .first as? T else {
            fatalError("xib not loaded, or its top view is of the wrong type")
        }
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(contentView)
        return contentView
    }
}
