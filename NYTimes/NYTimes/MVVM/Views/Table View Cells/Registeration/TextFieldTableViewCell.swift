//
//  TextFieldTableViewCell.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/25/24.
//

import UIKit

protocol TextFieldCellDelegate: AnyObject {
    func textFieldCell(_ cell: TextFieldTableViewCell, didChangeText text: String)
    func textFieldCell(_ cell: TextFieldTableViewCell, didChangeDate date: Date)
}

class TextFieldTableViewCell: UITableViewCell {

    private var stackView: UIStackView!
    var textField: UITextField!
    private var titleLabel: UILabel!
    private var errorLabel: UILabel!
    weak var delegate: TextFieldCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initTitleLabel()
        initStackView()
        initTextField()
        initErrorLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initStackView() {
        stackView = UIStackView(arrangedSubviews: [titleLabel])
        stackView.spacing = 8
        stackView.axis = .vertical
        contentView.addSubview(stackView)
        stackView.anchor(top: contentView.topAnchor,
                         leading: contentView.leadingAnchor,
                         trailing: contentView.trailingAnchor,
                         padding: UIEdgeInsets(top: 8, left: 16, bottom: 0, right: -16))
    }

    private func initTextField() {
        textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.delegate = self
        contentView.addSubview(textField)
        textField.anchor(top: stackView.bottomAnchor,
                         leading: contentView.leadingAnchor,
                         trailing: contentView.trailingAnchor,
                         padding: UIEdgeInsets(top: 8, left: 16, bottom: -16, right: -16))
    }

    private func initTitleLabel() {
        titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 14)
    }

    private func initErrorLabel() {
        errorLabel = UILabel()
        errorLabel.textColor = .systemRed
        errorLabel.font = .systemFont(ofSize: 12)
        contentView.addSubview(errorLabel)
        errorLabel.numberOfLines = 2
        errorLabel.anchor(top: textField.bottomAnchor,
                          leading: contentView.leadingAnchor,
                          bottom: contentView.bottomAnchor,
                          trailing: contentView.trailingAnchor,
                          padding: UIEdgeInsets(top: 2, left: 16, bottom: 0, right: -16))
        errorLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
    }

    func setupCell(with type: AuthFormCellTypes) {
        textField.keyboardType = type.keyboardType
        textField.isSecureTextEntry = type.isSecureTextEntry
        textField.placeholder = type.placeholder
        titleLabel.text = type.title

    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        delegate?.textFieldCell(self, didChangeText: textField.text ?? "")
    }

    func configure(with errorMessage: String?) {
        errorLabel.isHidden = errorMessage == nil
        errorLabel.text = errorMessage
    }
}

extension TextFieldTableViewCell: UITextFieldDelegate {
}
