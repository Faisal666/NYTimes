//
//  DateTextFieldTableViewCell.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/25/24.
//

import UIKit

class DateTextFieldTableViewCell: TextFieldTableViewCell {

    var datePicker: UIDatePicker?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initDatePicker()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initDatePicker() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.maximumDate = Date()
        datePicker?.preferredDatePickerStyle = .wheels
        textField.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)

    }

    @objc private func dateChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        textField.text = formatter.string(from: sender.date)
        delegate?.textFieldCell(self, didChangeDate: sender.date)
    }

    override func setupCell(with type: AuthFormCellTypes) {
        super.setupCell(with: type)
    }
}

extension DateTextFieldTableViewCell {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
