//
//  ImageLoader.swift
//  NYTimes
//
//  Created by Faisal AlSaadi on 2/26/24.
//

import UIKit
import Kingfisher

class ImageLoader {

    static let shared = ImageLoader()

    private init() {}

    func loadImage(from url: String?, into imageView: UIImageView) {
        guard let url else {
            print("Empty URL")
            imageView.image = nil
            return
        }
        guard let url = URL(string: url) else {
            print("Invalid URL")
            imageView.image = nil
            return
        }

        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
