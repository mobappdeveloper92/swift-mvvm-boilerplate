//
//  SearchView.swift
//  Jood
//
//  Created by Faizan Mahmood on 15/06/2022.
//

import Foundation
import UIKit

protocol SearchViewDelegate: NSObjectProtocol {
    func didTapFilter(from searchView: SearchView)
    func didTapSearchField(from searchView: SearchView)
    func didTapSearchButton(from searchView: SearchView, text: String?)
    func didChangeInText(from searchView: SearchView, text: String)
}

extension SearchViewDelegate {
    func didTapFilter(from searchView: SearchView) {}
    func didTapSearchField(from searchView: SearchView) {}
    func didTapSearchButton(from searchView: SearchView, text: String?) {}
    func didChangeInText(from searchView: SearchView, text: String) {}
}

class SearchView: BaseView {

    @IBInspectable private var isShowFilter: Bool = true
    @IBInspectable private var isTapable: Bool = false

    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var tfSearch: UITextField!

    weak var delegate: SearchViewDelegate?

    var text: String? {
        get { return tfSearch.text }
        set { tfSearch.text = newValue }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        prepareViews()
    }

    func setPlaceholder(_ placeholder: String) {
        tfSearch.placeholder = placeholder
    }

    func resetField() {
        tfSearch.text = ""
    }
}

// MARK: - Actions
extension SearchView {
    @IBAction func didTapSearchField(_ sender: Any) {
        delegate?.didTapSearchField(from: self)
    }

    @IBAction func didTapFilter(_ sender: Any) {
        delegate?.didTapFilter(from: self)
    }
}

// MARK: - Actions
private extension SearchView {
    func prepareViews() {
        self.addShadow()
        filterView.isHidden = !isShowFilter
        btnSearch.isUserInteractionEnabled = isTapable
    }
}

extension SearchView: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.didTapSearchButton(from: self, text: textField.text)
        textField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self else { return }
            self.delegate?.didChangeInText(from: self, text: textField.text ?? "")
        }
        return true
    }
}
