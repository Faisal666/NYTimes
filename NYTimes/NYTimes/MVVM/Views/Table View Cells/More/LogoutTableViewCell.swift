//
//  LogoutTableViewCell.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/26/24.
//

import UIKit

class LogoutTableViewCell: UITableViewCell {

    private var logoutButton: UIButton!
    var didTapLogoutHandler: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initSubViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initSubViews() {
        initLogoutButton()
    }

    private func initLogoutButton() {
        logoutButton = UIButton()
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.backgroundColor = .black
        logoutButton.layer.cornerRadius = 6
        logoutButton.clipsToBounds = true

        logoutButton.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
        contentView.addSubview(logoutButton)
        logoutButton.anchor(top: contentView.topAnchor,
                            leading: contentView.leadingAnchor,
                            bottom: contentView.bottomAnchor,
                            padding: UIEdgeInsets(top: 8, left: 16, bottom: -8, right: 0),
                            size: CGSize(width: 100, height: 40))
    }

    @objc private func didTapLogout() {
        didTapLogoutHandler?()
    }
}
