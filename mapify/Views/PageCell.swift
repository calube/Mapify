//
//  PageCell.swift
//  mapify
//
//  Created by Caleb Davis on 9/30/17.
//  Copyright © 2017 Caleb Davis. All rights reserved.
//

import UIKit
import SnapKit

class PageCell: UICollectionViewCell {

    var page: Page? {
        didSet {
            guard let page = page else {
                return
            }

            imageView.image = UIImage(named: page.imageName)

            let color = UIColor(white: 0.2, alpha: 1)

            let attributedText = NSMutableAttributedString(string: page.title, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20, weight: .medium), NSAttributedStringKey.foregroundColor: color])

            attributedText.append(NSAttributedString(string: "\n\n\(page.message)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: color]))

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center

            let length = attributedText.string.characters.count
            attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: length))

            textView.attributedText = attributedText
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .yellow
        iv.image = UIImage(named: "page1")
        iv.clipsToBounds = true
        return iv
    }()

    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "SAMPLE TEXT FOR NOW"
        tv.isEditable = false
        tv.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        return tv
    }()

    let lineSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return view
    }()

    func setupViews() {
        addSubview(imageView)
        addSubview(textView)
        addSubview(lineSeparatorView)

        imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(textView.snp.top)
        }

        textView.snp.makeConstraints { (make) in
            make.height.equalTo(snp.height).multipliedBy(0.3)
            make.left.bottom.right.equalTo(safeAreaLayoutGuide)
        }

        lineSeparatorView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.width.equalTo(snp.width)
            make.bottom.equalTo(textView.snp.top)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


