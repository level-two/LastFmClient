// -----------------------------------------------------------------------------
//    Copyright (C) 2020 Yauheni Lychkouski.
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.
// -----------------------------------------------------------------------------

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
