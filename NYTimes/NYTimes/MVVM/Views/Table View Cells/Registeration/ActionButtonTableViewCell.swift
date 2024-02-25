//
//  ActionButtonTableViewCell.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/26/24.
//

import UIKit

class ActionButtonTableViewCell: UITableViewCell {

    private var actionButton: UIButton!
    private var isActionButtonEnabled: Bool = false {
        didSet {
            actionButtonStateChanged()
        }
    }

    var didTapActionButtonHandler: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSubViews() {
        initActionButton()
    }

    private func initActionButton() {
        actionButton = UIButton()
        contentView.addSubview(actionButton)
        let buttonHeight: CGFloat = 44
        actionButton.backgroundColor = .black
        actionButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.layer.cornerRadius = buttonHeight / 2
        actionButton.anchor(top: contentView.topAnchor,
                            leading: contentView.leadingAnchor,
                            bottom: contentView.bottomAnchor,
                            trailing: contentView.trailingAnchor,
                            padding: UIEdgeInsets(top: 8, left: 16, bottom: -8, right: -16),
                            size: CGSize(width: 0, height: buttonHeight))
        actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
    }

    private func actionButtonStateChanged() {
        actionButton.backgroundColor = isActionButtonEnabled ? .black : .gray
        actionButton.setTitleColor(isActionButtonEnabled ? .white : .lightGray, for: .normal)
        actionButton.isEnabled = isActionButtonEnabled
    }

    @objc private func didTapActionButton() {
        didTapActionButtonHandler?()
    }

    func setupCell(title: String, isEnabled: Bool) {
        actionButton.setTitle(title, for: .normal)
        isActionButtonEnabled = isEnabled
    }
}
