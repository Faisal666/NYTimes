//
//  DetailsTableViewCell.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/26/24.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    private var stackView: UIStackView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initSubViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initSubViews() {
        initNameLabel()
        initEmailLabel()
        initStackView()
    }

    private func initNameLabel() {
        titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 14)
    }

    private func initEmailLabel() {
        subtitleLabel = UILabel()
        subtitleLabel.font = .systemFont(ofSize: 16)
    }

    private func initStackView() {
        stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        contentView.addSubview(stackView)
        stackView.anchor(top: contentView.topAnchor,
                         leading: contentView.leadingAnchor,
                         bottom: contentView.bottomAnchor,
                         padding: UIEdgeInsets(top: 8, left: 16, bottom: -8, right: 0))
    }

    func setupCell(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
