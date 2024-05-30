//
//  SwiftyJSON+Extension.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 19/04/2022.
//

import Foundation
import UIKit

protocol FloatingTextFieldDelegate: NSObjectProtocol {
    func didTapField(_ field: FloatingTextField)
    func floatingTextField(_ floatingTextField: FloatingTextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
}

extension FloatingTextFieldDelegate {
    func didTapField(_ field: FloatingTextField) { }
    func floatingTextField(_ floatingTextField: FloatingTextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

@IBDesignable
class FloatingTextField: BaseView {

    @IBOutlet weak private var labelTitle: UILabel!
    @IBOutlet weak private var labelPlaceholder: UILabel!
    @IBOutlet weak private var stackViewInput: UIStackView!
    @IBOutlet weak private var imageViewLeftIcon: UIImageView!
    @IBOutlet weak private var textField: UITextField!
    @IBOutlet weak private var trailingConstraintTextField: NSLayoutConstraint!
    @IBOutlet weak private var imageViewRightIcon: UIImageView!
    @IBOutlet weak private var viewSeparator: UIView!
    @IBOutlet weak private var labelError: UILabel!
    @IBOutlet weak private var btnAction: UIButton!

    @IBInspectable var title: String? {
        get { return labelTitle.text }
        set { labelTitle.text = newValue }
    }
    @IBInspectable var placeholder: String? {
        get { return labelPlaceholder.text }
        set {
            textField.placeholder = newValue
            textField.placeHolderColor = .clear
            labelPlaceholder.text = newValue
        }
    }
    @IBInspectable var text: String? {
        get { return textField.text }
        set {
            if isTapable {
                guard !(newValue?.isEmpty ?? true) else {
                    textField.text = ""
                    setFieldActive(false)
                    return
                }
                setFieldActive(true)
            }
            textField.text = newValue
            if textField.hasText {
                movePlaceholderToTitle(duration: 0.0)
                labelError.isHidden = true
            } else {
                labelPlaceholder.frame = getTextFieldFrame()
            }
        }
    }

    @IBInspectable private var titleColor: UIColor = .getColor(.lightGrey)
    @IBInspectable private var placeholderColor: UIColor = .getColor(.placeholder)
    @IBInspectable private var textFieldColor: UIColor = .getColor(.darkGrey)

    @IBInspectable private var separatorColor: UIColor = .getColor(.separator)
    @IBInspectable private var activeColor: UIColor = .getColor(.primary)

    @IBInspectable private var isSecureTextEntry: Bool = false

    @IBInspectable private var leftIcon: UIImage?
    @IBInspectable private var rightIcon: UIImage?
    @IBInspectable private var iconTintColor: UIColor = .getColor(.lightGrey)

    @IBInspectable private var isTapable: Bool = false

    private let titleFont: UIFont = .getFont(.regular, size: 14)
    private let placeholderFont: UIFont = .getFont(.regular, size: 16)
    private let textFieldFont: UIFont = .getFont(.regular, size: 16)
    private let errorFont: UIFont = .getFont(.regular, size: 10)

    weak var delegate: FloatingTextFieldDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        prepareViews()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        labelPlaceholder.frame = getTextFieldFrame()
        if textField.hasText {
            movePlaceholderToTitle(duration: 0.0)
        }
    }

    func resetViews() {
        textField.text = ""
        textField.isSecureTextEntry = true
        updateEyeIcon()
        setFieldActive(false)
    }

    func showError(_ text: String?) {
        labelError.text = text
        labelError.isHidden = false
        self.shake()
    }

    func setContentType(_ contentType: UITextContentType? = nil, keyboardType: UIKeyboardType = .default) {
        textField.textContentType = contentType
        textField.keyboardType = keyboardType
        if let contentType = contentType {
            textField.autocapitalizationType = contentType == .name ? .words : .none
        }
    }

    func setContent(title: String, placeholder: String? = nil) {
        labelTitle.text = title
        labelPlaceholder.text = placeholder ?? title
        labelPlaceholder.frame = getTextFieldFrame()
        textField.placeholder = placeholder ?? title
        textField.placeHolderColor = .clear
        setFieldActive(false)
    }

    func setPickerData(value: String?) {
        setFieldActive(true)
        textField.text = value
    }

    func setRightIcon(image: UIImage?) {
        guard let image = image else {
            return
        }
        rightIcon = image
        setIcons()
    }

    func setTrailingConstraint(_ value: CGFloat) {
        trailingConstraintTextField.constant = value
    }
}

// MARK: - Prepare Views
private extension FloatingTextField {
    func prepareViews() {
        setIcons()
        prepareTitleLabel()
        prepareSeparator()
        prepareTextField()
        preparePlaceholderLabel()
        prepareForTapping()
        prepareErrorLabel()
    }

    func prepareTitleLabel() {
        labelTitle.text = title
        labelTitle.font = titleFont
        labelTitle.textColor = titleColor
    }

    func preparePlaceholderLabel() {
        labelPlaceholder.text = placeholder
        labelPlaceholder.font = placeholderFont
        labelPlaceholder.textColor = placeholderColor
    }

    func prepareTextField() {
        textField.text = text
        textField.font = textFieldFont
        textField.textColor = textFieldColor
        textField.tintColor = activeColor
        textField.isSecureTextEntry = isSecureTextEntry
    }

    func prepareErrorLabel() {
        labelError.textAlignment = .left // LanguageManager.shared.isRightToLeft ? .left : .right
        labelError.font = errorFont
    }

    func prepareSeparator() {
        viewSeparator.backgroundColor = separatorColor
    }

    func getTextFieldFrame() -> CGRect {
        return stackViewInput.convert(textField.frame, to: self)
    }

    func prepareForTapping() {
        guard isTapable else { return }
        textField.isUserInteractionEnabled = false
        btnAction.isUserInteractionEnabled = true
    }
}

// MARK: - Icons
private extension FloatingTextField {
    func setIcons() {
        setLeftIcon()
        setRightIcon()
    }

    func setLeftIcon() {
        guard let icon = leftIcon else { return }
        imageViewLeftIcon.isHidden = false
        imageViewLeftIcon.image = icon
        imageViewLeftIcon.tintColor = iconTintColor
    }

    func setRightIcon() {
        if isSecureTextEntry {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rightIconTapped(_:)))
            imageViewRightIcon.image = UIImage.init(systemName: "eye.fill")
            imageViewRightIcon.isHidden = false
            imageViewRightIcon.isUserInteractionEnabled = true
            imageViewRightIcon.addGestureRecognizer(tapGestureRecognizer)
        } else {
            guard let icon = rightIcon else {
                imageViewRightIcon.image = nil
                return
            }
            imageViewRightIcon.isHidden = false
            imageViewRightIcon.isHidden = false
            imageViewRightIcon.image = icon
        }
    }

    @objc func rightIconTapped(_ imageViewIcon: UIImageView) {
        let isSecure = textField?.isSecureTextEntry ?? false
        textField?.isSecureTextEntry = !isSecure
        updateEyeIcon()
    }

    func updateEyeIcon() {
        let isSecure = textField?.isSecureTextEntry ?? false
        let image = isSecure ?
        UIImage.init(systemName: "eye.fill") :
        UIImage.init(systemName: "eye.slash.fill")
        imageViewRightIcon.image = image
    }
}

// MARK: - Action
extension FloatingTextField {
    @IBAction func didTapButton(_ sender: Any) {
        self.endEditing(true)
        if !labelError.isHidden { labelError.isHidden = true }
        delegate?.didTapField(self)
    }
}

// MARK: - UITextFieldDelegate
extension FloatingTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setFieldActive(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        setFieldActive(false)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !labelError.isHidden { labelError.isHidden = true }
        if string == "\r" || string == "\n" { return true }
        if textField.textContentType == .name {
            if string.isEmpty {
                return true
            }
            let textCount = textField.text?.count ?? 0
            let maxNameChar = ValidationConstants.maxName
            let isValidated = textCount < maxNameChar
            return string.isEmpty || isValidated &&
            delegate?.floatingTextField(self,
                                        shouldChangeCharactersIn: range,
                                        replacementString: string) ?? true
        }
        return delegate?.floatingTextField(self,
                                           shouldChangeCharactersIn: range,
                                           replacementString: string) ?? true
    }
}

// MARK: - Animations
private extension FloatingTextField {

    func setFieldActive(_ isActive: Bool) {
        guard !textField.hasText else {
            if !isTapable {
                viewSeparator.backgroundColor = isActive ? activeColor : UIColor.systemGray5
                labelPlaceholder.textColor = isActive ? activeColor : titleColor
            }
            return
        }
        if isActive {
            movePlaceholderToTitle()
        } else {
            moveTitleToPlaceholder()
        }
        if !isTapable {
            viewSeparator.backgroundColor = isActive ? activeColor : UIColor.systemGray5
            labelPlaceholder.textColor = isActive ? activeColor : placeholderColor
        }
    }

    func movePlaceholderToTitle(duration: TimeInterval = 0.25) {
        UIView.transition(with: labelPlaceholder,
                          duration: duration,
                          options: [.transitionCrossDissolve]) { [weak self] in
            guard let self = self else { return }
            self.labelPlaceholder.textColor = self.titleColor
            self.labelPlaceholder.font = self.titleFont
            self.labelPlaceholder.text = self.title
            self.labelPlaceholder.frame = self.labelTitle.frame
        }
    }

    func moveTitleToPlaceholder() {
        UIView.transition(with: labelTitle,
                          duration: 0.25,
                          options: [.transitionCrossDissolve]) { [weak self] in
            guard let self = self else { return }
            self.labelPlaceholder.textColor = self.placeholderColor
            self.labelPlaceholder.font = self.placeholderFont
            self.labelPlaceholder.text = self.placeholder
            self.labelPlaceholder.frame = self.getTextFieldFrame()
        }
    }
}

// MARK: - Connect fields for keyboard
extension FloatingTextField {

    class func connectFields(fields: [BaseView], returnKeyType: UIReturnKeyType = .done) {

        func getTextField(from field: BaseView) -> UITextField? {
            return (field as? FloatingTextField)?.textField ??
            (field as? FloatingPhoneField)?.textField
        }

        guard let last = fields.last else {
            return
        }
        for index in 0 ..< fields.count - 1 {

            let textField = getTextField(from: fields[index])

            textField?.tag = index + 1
            textField?.returnKeyType = .next

            let nextTextField = getTextField(from: fields[index + 1])

            textField?.addTarget(nextTextField,
                                 action: #selector(UIResponder.becomeFirstResponder),
                                 for: .editingDidEndOnExit)
        }
        let lastTextField = getTextField(from: last)
        lastTextField?.returnKeyType = returnKeyType
        lastTextField?.addTarget(lastTextField,
                                 action: #selector(UIResponder.resignFirstResponder),
                                 for: .editingDidEndOnExit)
    }

    // Only FloatingTextField
    /*
    class func connectFields(fields: [FloatingTextField], returnKeyType: UIReturnKeyType = .done) {
        guard let last = fields.last else {
            return
        }
        for index in 0 ..< fields.count - 1 {
            let textField = fields[index].textField
            textField?.tag = index + 1
            textField?.returnKeyType = .next
            textField?.addTarget(fields[index + 1].textField,
                                 action: #selector(UIResponder.becomeFirstResponder),
                                 for: .editingDidEndOnExit)
        }
        last.textField.returnKeyType = returnKeyType
        last.textField.addTarget(last.textField,
                                 action: #selector(UIResponder.resignFirstResponder),
                                 for: .editingDidEndOnExit)
    }
     */
}

extension FloatingTextField {
    func validatedText(validationType: ValidatorType) -> String? {
        let validator = ValidatorFactory.validatorFor(type: validationType)
        do {
            let validatedText = try validator.validated(self.text ?? "")
            return validatedText
        } catch(let error) {
            self.showError((error as? ValidationError)?.message)
            self.shake()
            return nil
        }
    }
}
