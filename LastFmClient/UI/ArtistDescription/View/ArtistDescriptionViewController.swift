import UIKit

final class ArtistDescriptionViewController: UIViewController, StoryboardLoadable {
    @IBOutlet private var textView: UITextView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupDependencies(viewModel: ArtistDescriptionViewModel, theme: Theme) {
        self.viewModel = viewModel
        self.theme = theme
    }

    private var viewModel: ArtistDescriptionViewModel?
    private var navigator: SceneNavigator?
    private var theme: Theme?
}

private extension ArtistDescriptionViewController {
    func setupView() {
        guard let viewModel = viewModel else { return }
        textView?.attributedText = viewModel.attributedDescription
        textView?.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
    }
}
