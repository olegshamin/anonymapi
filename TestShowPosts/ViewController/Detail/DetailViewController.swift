//
//  DetailViewController.swift
//  TestShowPosts
//
//  Created by Oleg Shamin on 28.09.2020.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: - Views
    
    private var scrollView = UIScrollView()
    private var authorImageView = UIImageView()
    private var authorName = HeavyLabel17()
    private var postImageView = UIImageView()
    private var postText = RegularLabel12()
    private var stackView = UIStackView()
    private var authorView = UIView()
    private var postView = UIView()
    
    // MARK: - Private properties
    
    private var post: Post!
    
    // MARK: - Initialization
    
    static func create(
        post: Post
    ) -> DetailViewController {

        let viewController = DetailViewController()
        viewController.post = post
        
        return viewController
    }
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
    }
    
    // MARK: - Private helpers
    
    private func setupUI() {
        setupScrollView()
        setupStackView()
        setupAuthorImageView()
        setupAuthorName()
        setupPostImageView()
        setupPostText()
    }
    
    private func setupScrollView() {
        view.add(subview: scrollView)
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = Constants.defaultOffset
        scrollView.add(subview: stackView)
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    private func setupAuthorImageView() {
        authorView.add(subview: authorImageView, withPinEdges: [
            .top(Constants.defaultOffset),
            .bottom(Constants.defaultOffset),
            .leading(Constants.defaultOffset)
        ])
        authorImageView.widthConstraintConstant = 40
        authorImageView.heightConstraintConstant = 40
        authorImageView.layer.cornerRadius = 20
        authorImageView.layer.masksToBounds = true
        
        if let url = post.author.thumbnailURL {
            authorImageView.loadImage(at: url)
        } else {
            authorImageView.image = UIImage(named: "empty_photo")
        }
    }
    
    private func setupAuthorName() {
        authorView.add(
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
        
        authorName.text = post.author.name
        stackView.addArrangedSubview(authorView)
    }
    
    private func setupPostImageView() {
        postImageView.loadImage(at: post.originalURL ?? post.thumbnailURL)
        stackView.addArrangedSubview(postImageView)
    }
    
    private func setupPostText() {
        postView.add(
            subview: postText, withPinEdges: [
                .top,
                .bottom,
                .leading(Constants.doubleOffset),
                .trailing(Constants.doubleOffset)
            ])
        postText.text = post.text
        stackView.addArrangedSubview(postView)
    }
}
