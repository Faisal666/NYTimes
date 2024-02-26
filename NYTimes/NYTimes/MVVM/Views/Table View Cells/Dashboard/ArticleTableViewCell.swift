//
//  ArticleTableViewCell.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/26/24.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    private var articleImageView: UIImageView!
    private var titleLabel: UILabel!
    private var postedDateLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSubViews() {
        initImageView()
        initTitleLabel()
        initPostedDateLabel()
    }

    private func initImageView() {
        articleImageView = UIImageView()
        articleImageView.layer.cornerRadius = 6
        articleImageView.clipsToBounds = true
        contentView.addSubview(articleImageView)
        articleImageView.anchor(top: contentView.topAnchor,
                                leading: contentView.leadingAnchor,
                                bottom: contentView.bottomAnchor,
                                padding: UIEdgeInsets(top: 8, left: 16, bottom: -8, right: 0),
                                size: CGSize(width: 60, height: 60))
    }

    private func initTitleLabel() {
        titleLabel = UILabel()
        titleLabel.numberOfLines = 2
        titleLabel.font = .boldSystemFont(ofSize: 14)
        contentView.addSubview(titleLabel)
        titleLabel.anchor(top: articleImageView.topAnchor,
                          leading: articleImageView.trailingAnchor,
                          trailing: contentView.trailingAnchor,
                          padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -16))
    }

    private func initPostedDateLabel() {
        postedDateLabel = UILabel()
        postedDateLabel.font = .systemFont(ofSize: 12)
        contentView.addSubview(postedDateLabel)
        postedDateLabel.anchor(leading: articleImageView.trailingAnchor,
                               bottom: articleImageView.bottomAnchor,
                               trailing: contentView.trailingAnchor,
                               padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -16))
    }

    func setupCell(article: Article) {
        titleLabel.text = article.title
        postedDateLabel.text = article.publishedDate?.timeAgo()
        ImageLoader.shared.loadImage(from: article.imageUrl, into: articleImageView)
    }
}
