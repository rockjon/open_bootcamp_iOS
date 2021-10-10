//
//  CardView.swift
//  iOS Bootcamp Challenge
//
//  Created by Marlon David Ruiz Arroyave on 28/09/21.
//

import UIKit

class CardView: UIView {

    enum LabelInfoWithStyle {
        case regularlText             (_ text: String)
        case highlightedText          (_ text: String)
        public var style: (font: UIFont, color: UIColor)? {
            switch self {
            case .highlightedText(_):
                return (.systemFont(ofSize: 14,
                                    weight: .bold),
                        UIColor(red: 0.40, green: 0.41, blue: 0.44, alpha: 1.00))
            case .regularlText(_):
                return (.systemFont(ofSize: 18,
                                    weight: .medium),
                        UIColor(red: 0.22, green: 0.22, blue: 0.22, alpha: 1.00))
            }
        }
    }
    private let margin: CGFloat = 30
    var card: Card?
    lazy private var sectionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = margin/2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 27)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    required init(card: Card) {
        self.card = card
        super.init(frame: .zero)
        setup()
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        setupUI()
    }

    private func setup() {
        guard let card = card else { return }

        card.items.forEach { stringLAbel in
            setStackContent([.highlightedText(stringLAbel.title), .regularlText(stringLAbel.description)])
        }

        titleLabel.text = card.title
        backgroundColor = .white
        layer.cornerRadius = 20
    }

    private func setupUI() {
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: margin * 2).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin).isActive = true
        titleLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.70).isActive = true
        addSubview(sectionsStackView)
        sectionsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: margin).isActive = true
        sectionsStackView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        sectionsStackView.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.7).isActive = true

        // TODO: Display pokemon info (eg. types, abilities)
    }

    public func setStackContent(_ content: [LabelInfoWithStyle]) {
        sectionsStackView.spacing = margin/2
        for element in content {
            sectionsStackView.addArrangedSubview(createLabel(with: element))
        }
    }
    private func createLabel(with labelStyle: LabelInfoWithStyle) -> UILabel {
        let label = UILabel()
        switch labelStyle {
        case .highlightedText(let text),
             .regularlText(let text):
            label.text          = text
            label.numberOfLines = 0
            if let style = labelStyle.style {
                label.font          = style.font
                label.textColor     = style.color
            }
        }
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }
    private func createStack() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis         = .vertical
        stackView.alignment    = .fill
        stackView.distribution = .fill
        stackView.spacing = 4
        return stackView
    }
}
