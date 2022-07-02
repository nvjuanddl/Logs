//
//  LogInfoCell.swift
//  Logs
//
//  Created by Juan Dario Delgado L on 1/07/22.
//

import UIKit
import Kingfisher

struct LogInfoViewModel {
    let title: String
    let imageURL: URL?
}

class LogInfoCell: UITableViewCell {
    
    // MARK: - Private properties -
    private lazy var customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.backgroundColor = .clear
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    // MARK: - Lifecycle -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setUpConstraints()
        backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addViews()
        setUpConstraints()
        backgroundColor = .black
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        customImageView.image = nil
    }
    
    // MARK: - Private methods -
    private func addViews() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(customImageView)
        stackView.addArrangedSubview(titleLabel)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            NSLayoutConstraint(
                item: customImageView,
                attribute: .height,
                relatedBy: .equal,
                toItem: imageView,
                attribute: .width,
                multiplier: 1,
                constant: 0
            )
        ])
    }
    
    // MARK: - Public methods -
    func configure(with viewModel: LogInfoViewModel) {
        titleLabel.text = viewModel.title
        customImageView.kf.setImage(with: viewModel.imageURL)
    }
}

