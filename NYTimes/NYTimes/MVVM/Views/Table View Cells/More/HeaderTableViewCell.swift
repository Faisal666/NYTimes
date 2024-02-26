//
//  HeaderTableViewCell.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/26/24.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    private var profileImageView: UIImageView!
    private var nameLabel: UILabel!
    private var emailLabel: UILabel!
    private var stackView: UIStackView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initSubViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSubViews() {
        initImageView()
        initNameLabel()
        initEmailLabel()
        initStackView()
    }

    private func initImageView() {
        profileImageView = UIImageView()
        profileImageView.backgroundColor = .black
        contentView.addSubview(profileImageView)
        profileImageView.anchor(top: contentView.topAnchor,
                                leading: contentView.leadingAnchor,
                                bottom: contentView.bottomAnchor,
                                padding: UIEdgeInsets(top: 8, left: 16, bottom: -8, right: 0),
                                size: CGSize(width: 55, height: 55))
    }

    private func initNameLabel() {
        nameLabel = UILabel()
        nameLabel.font = .boldSystemFont(ofSize: 16)
    }

    private func initEmailLabel() {
        emailLabel = UILabel()
        emailLabel.font = .systemFont(ofSize: 14)
    }

    private func initStackView() {
        stackView = UIStackView(arrangedSubviews: [nameLabel, emailLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        contentView.addSubview(stackView)
        stackView.anchor(leading: profileImageView.trailingAnchor,
                         centerY: profileImageView.centerYAnchor,
                         padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0))
    }

    func setupCell(name: String?, email: String?) {
        nameLabel.text = name
        emailLabel.text = email
    }
}
