//
//  SwiftyJSON+Extension.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 19/04/2022.
//

import Foundation
import UIKit

protocol FloatingPhoneFieldDelegate: NSObjectProtocol {
    func floatingPhoneField(_ floatingPhoneField: FloatingPhoneField, shouldChangeCharactersIn range: NSRange, replacementString string: String)
    func floatingPhoneField(_ floatingPhoneField: FloatingPhoneField, didSelectCountry country: Country, type: CountrySelectionType)
}

extension FloatingPhoneFieldDelegate {
    func floatingPhoneField(_ floatingPhoneField: FloatingPhoneField, shouldChangeCharactersIn range: NSRange, replacementString string: String) { }
    func floatingPhoneField(_ floatingPhoneField: FloatingPhoneField, didSelectCountry country: Country, type: CountrySelectionType) { }
}

@IBDesignable
class FloatingPhoneField: BaseView {

    @IBOutlet weak private var labelTitle: UILabel!
    @IBOutlet weak private var imageViewLeftIcon: UIImageView!
    @IBOutlet weak private var labelCountryCode: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak private var viewSeparatorCode: UIView!
    @IBOutlet weak private var viewSeparatorField: UIView!
    @IBOutlet weak private var labelError: UILabel!

    @IBInspectable var title: String? {
        get { return labelTitle.text }
        set { labelTitle.text = newValue }
    }
    @IBInspectable var countryCode: String? {
        get { return labelCountryCode.text }
        set { labelCountryCode.text = newValue }
    }
    @IBInspectable var text: String? {
        get { return textField.text }
        set { textField.text = newValue }
    }

    @IBInspectable var placeholder: String? {
        get { return textField.placeholder }
        set { textField.placeholder = newValue }
    }

    @IBInspectable private var titleColor: UIColor = .getColor(.lightGrey)
    @IBInspectable private var textFieldColor: UIColor = .getColor(.darkGrey)

    @IBInspectable private var separatorColor: UIColor = .getColor(.separator)
    @IBInspectable private var activeColor: UIColor = .getColor(.primary)

    @IBInspectable private var leftIcon: UIImage?
    @IBInspectable private var iconTintColor: UIColor = .getColor(.lightGrey)

    @IBInspectable private var isReadOnly: Bool = false

    private let titleFont: UIFont = UIFont.getFont(.regular, size: 14.0)
    private let textFieldFont: UIFont = UIFont.getFont(.regular, size: 16.0)

    private var selectedCountry: Country?
    private var shouldSelectDefault: Bool = true
    private var isDefaultCountrySet: Bool = false

    weak var delegate: FloatingPhoneFieldDelegate?

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        prepareViews()
    }

    func getCountryName() -> String? {
        return selectedCountry?.name
    }

    func showError(_ text: String?) {
        labelError.text = text
        labelError.isHidden = false
        self.shake()
    }

    public func getNumber() -> String {
        return "\(countryCode ?? "")\(text ?? "")"
    }

    public func setNumber(code: String?, nummber: String?) {
        shouldSelectDefault = false
        isDefaultCountrySet = true
        self.selectedCountry = CountryHelper.shared.getCountryByCode(code: code ?? "SA")
        leftIcon = self.selectedCountry?.flag
        imageViewLeftIcon.image = self.selectedCountry?.flag
        self.countryCode = code
        self.labelCountryCode.text = code
        self.text = nummber
    }
}

// MARK: - Actions
extension FloatingPhoneField {
    @IBAction func didTapCode(_ sender: Any) {
        self.endEditing(true)
        showCountrySelectionViewController()
    }
}

// MARK: - Prepare Views
private extension FloatingPhoneField {
    func prepareViews() {
        prepareTitleLabel()
        prepareLabelCountryCode()
        prepareSeparators()
        prepareTextField()
        prepareErrorLabel()
        setIcons()
        setAccessibility()
        prepareDefaultCountryData()
    }

    func prepareTitleLabel() {
        labelTitle.text = title
        labelTitle.font = titleFont
        labelTitle.textColor = titleColor
    }

    func prepareErrorLabel() {
        labelError.textAlignment = LanguageManager.shared.isRightToLeft ? .left : .right
    }

    func prepareLabelCountryCode() {
        guard shouldSelectDefault else {
            return
        }
        labelCountryCode.text = countryCode
        labelCountryCode.font = textFieldFont
        labelCountryCode.textColor = textFieldColor
    }

    func prepareTextField() {
        textField.text = text
        textField.font = textFieldFont
        textField.textColor = textFieldColor
        textField.tintColor = activeColor
        textField.placeHolderColor = titleColor
    }

    func prepareSeparators() {
        viewSeparatorCode.backgroundColor = separatorColor
        viewSeparatorField.backgroundColor = separatorColor
    }

    func setAccessibility() {
        guard isReadOnly else { return }
        self.isUserInteractionEnabled = false
        labelCountryCode.textColor = .getColor(.lightGrey)
        textField.textColor = .getColor(.lightGrey)
    }
}

// MARK: - Country Code
private extension FloatingPhoneField {
    func prepareDefaultCountryData() {
        guard !isDefaultCountrySet else {
            return
        }
        isDefaultCountrySet = true
        guard let regionCode = Locale.current.regionCode else {
            return
        }
        setCountryByCode(code: regionCode)
    }

    func setCountryByCode(code: String) {
        let data = CountryHelper.shared.getCountriesForPhone()
        guard let country = data.filter({
            $0.id.lowercased() == code.lowercased()
        }).first ?? data.filter({
            $0.id.lowercased() == "sa"
        }).first else { return }
        selectedCountry = country
        leftIcon = country.flag
        labelCountryCode.text = country.getCode()
        imageViewLeftIcon.image = country.flag
    }
}

// MARK: - Icons
private extension FloatingPhoneField {
    func setIcons() {
        setLeftIcon()
    }

    func setLeftIcon() {
        guard let icon = leftIcon else { return }
        imageViewLeftIcon.isHidden = false
        imageViewLeftIcon.image = icon
        imageViewLeftIcon.tintColor = iconTintColor
    }
}

// MARK: - UITextFieldDelegate
extension FloatingPhoneField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setFieldActive(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        setFieldActive(false)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !labelError.isHidden { labelError.isHidden = true }
        if string.isEmpty {
            delegate?.floatingPhoneField(self, shouldChangeCharactersIn: range, replacementString: string)
            return true
        }
        let code = countryCode ?? ""
        let mobile = code + (textField.text ?? "")
        let isValidated = Regex.numbers.contains(string)
           && (mobile).count < ValidationConstants.maxPhone
        if isValidated {
            delegate?.floatingPhoneField(self, shouldChangeCharactersIn: range, replacementString: string)
        }
        return isValidated
    }
}

// MARK: - Animations
private extension FloatingPhoneField {

    func setFieldActive(_ isActive: Bool) {
        viewSeparatorField.backgroundColor = isActive ? activeColor : UIColor.systemGray5
        labelTitle.textColor = isActive ? activeColor : titleColor
    }
}

// MARK: - CountrySelectionViewControllerDelegate
extension FloatingPhoneField: CountrySelectionViewControllerDelegate {
    private func showCountrySelectionViewController() {
        let controller = CountrySelectionViewController.init()
        controller.type = .code
        controller.delegate = self
        controller.modalPresentationStyle = .overCurrentContext
//        guard let parentController = self.parentContainerViewController() else {
//            return
//        }
//        parentController.present(controller, animated: true, completion: nil)
    }

    func didSelectCountry(from: CountrySelectionViewController, country: Country, type: CountrySelectionType) {
        guard selectedCountry?.code != country.code else { return }
        delegate?.floatingPhoneField(self, didSelectCountry: country, type: type)
        selectedCountry = country
        leftIcon = country.flag
        imageViewLeftIcon.image = country.flag
        labelCountryCode.text = country.getCode()
        textField.text = ""
    }
}
