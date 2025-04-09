import SwiftUI

// MARK: - Pet Mood Enum
enum PetMood {
    case sad
    case normal
    case happy
}

// MARK: - Get Mood From Health
func getMood(from health: Double) -> PetMood {
    switch health {
    case 0...0.3:
        return .sad
    case 0.31...0.7:
        return .normal
    default:
        return .happy
    }
}

// MARK: - Animation Image Mapping
func getImages(for mood: PetMood) -> [UIImage] {
    switch mood {
    case .sad:
        return [
            UIImage(named: "sad1")!,
            UIImage(named: "sad2")!,
            UIImage(named: "sad3")!,
            UIImage(named: "sad2")!,
            UIImage(named: "sad1")!
        ]
    case .normal:
        return [
            UIImage(named: "normal1")!,
            UIImage(named: "normal2")!,
            UIImage(named: "normal1")!
        ]
    case .happy:
        return [
            UIImage(named: "happy1")!,
            UIImage(named: "happy2")!,
            UIImage(named: "happy3")!,
            UIImage(named: "happy2")!,
            UIImage(named: "happy1")!
        ]
    }
}

// MARK: - UIViewRepresentable Wrapper
struct AnimationSequence: UIViewRepresentable {
    let mood: PetMood

    func makeUIView(context: Context) -> UIView {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
        let imageView = UIImageView(frame: container.bounds)
        imageView.image = UIImage.animatedImage(with: getImages(for: mood), duration: 1)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFill
        container.addSubview(imageView)
        return container
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        guard let imageView = uiView.subviews.first as? UIImageView else { return }
        imageView.image = UIImage.animatedImage(with: getImages(for: mood), duration: 1)
    }
}
