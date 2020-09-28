//
//  PostTableViewCell.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 26.09.2020.
//

import UIKit

extension PostTableViewCell {
    
    struct Config {
        let post: Post
    }
}

final class PostTableViewCell: UITableViewCell, ConfigurableView {
    
    // MARK: - Views
    
    private var authorImageView = UIImageView()
    private var authorName = HeavyLabel17()
    private var postImageView = UIImageView()
    private var postText = RegularLabel12()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func prepareForReuse() {
        authorImageView.image = nil
        authorImageView.cancelImageLoad()
    }
    
    // MARK: - Configurable
    
    func configure(with config: Config) {
        if let url = config.post.author.thumbnailURL {
            authorImageView.loadImage(at: url)
        } else {
            authorImageView.image = UIImage(named: "empty_photo")
        }
  
        authorName.text = config.post.author.name
        postImageView.loadImage(at: config.post.thumbnailURL)
        postText.text = config.post.text
    }
    
    // MARK: - Private helpers
    
    private func setupUI() {
        selectionStyle = .none
        setupAuthorImageView()
        setupAuthorName()
        setupPostImageView()
        setupPostText()
    }
    
    private func setupAuthorImageView() {
        contentView.add(
            subview: authorImageView,
            withPinEdges: [
                .top(Constants.defaultOffset),
                .leading(Constants.defaultOffset)
            ]
        )
        authorImageView.widthConstraintConstant = 40
        authorImageView.heightConstraintConstant = 40
        authorImageView.layer.cornerRadius = 20
        authorImageView.layer.masksToBounds = true
    }
    
    private func setupAuthorName() {
        contentView.add(
            subview: authorName,
            withPinEdges: [.trailing(Constants.defaultOffset)]
        )
        authorName.edgeConstraints(to: authorImageView, on: [
            .top,
            .bottom
        ]).activate()
        
        authorName.leadingAnchor.constraint(
            equalTo: authorImageView.trailingAnchor,
            constant: Constants.defaultOffset
        ).isActive = true
    }
    
    private func setupPostImageView() {
        contentView.add(
            subview: postImageView,
            withPinEdges: [
                .centerX
            ]
        )
        postImageView.topAnchor.constraint(
            equalTo: authorImageView.bottomAnchor,
            constant: Constants.defaultOffset
        ).isActive = true
        postImageView.widthConstraintConstant = 200
        postImageView.heightConstraintConstant = 200
        postImageView.contentMode = .scaleAspectFill
        postImageView.layer.cornerRadius = 5
        postImageView.layer.masksToBounds = true
    }
    
    private func setupPostText() {
        contentView.add(
            subview: postText,
            withPinEdges: [
                .leading(Constants.defaultOffset),
                .trailing(Constants.defaultOffset),
                .bottom(Constants.defaultOffset)
            ]
        )
        postText.topAnchor.constraint(
            equalTo: postImageView.bottomAnchor,
            constant: Constants.defaultOffset
        ).isActive = true
        postText.numberOfLines = 4
    }
}
