//
//  CustomHeaderView.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/26/24.
//

import UIKit

class CustomHeaderView: UIView {

    private var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        initSubViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initSubViews() {
        initTitleLabel()
    }

    private func initTitleLabel() {
        titleLabel = UILabel()
        addSubview(titleLabel)
        titleLabel.anchor(leading: leadingAnchor,
                          trailing: trailingAnchor,
                          centerY: centerYAnchor,
                          padding: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 0),
                          size: CGSize(width: 0, height: 16))

        titleLabel.font = UIFont.boldSystemFont(ofSize: 16) // Customize the font
    }

    func setupView(title: String) {
        titleLabel.text = title
    }
}
