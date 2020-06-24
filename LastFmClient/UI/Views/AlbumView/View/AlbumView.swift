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
import RxSwift
import RxCocoa

final class AlbumView: UIView, NibLoadable {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromNib()
    }

    func set(viewModel: AlbumViewModel?) {
        self.viewModel = viewModel
        setupView()
    }

    func style(with theme: Theme?) {
        theme?.apply(style: .normal, to: artist)
        theme?.apply(style: .normal, to: title)
        theme?.apply(style: .darkBackground, to: self)
    }

    private var viewModel: AlbumViewModel?
    private var disposeBag = DisposeBag()

    @IBOutlet private weak var artist: UILabel?
    @IBOutlet private weak var title: UILabel?
    @IBOutlet private weak var cover: UIImageView?
}

private extension AlbumView {
    func setupView() {
        setupStaticData()
        bindDynamicData()
    }

    func setupStaticData() {
        artist?.text = viewModel?.artist
        title?.text = viewModel?.title
    }

    func bindDynamicData() {
        cleanPreviousBindings()

        guard let viewModel = viewModel, let cover = cover else { return }

        viewModel.onCover
            .bind(to: cover.rx.image)
            .disposed(by: disposeBag)

        viewModel.showHud
            .bind(to: cover.rx.showHud)
            .disposed(by: disposeBag)
    }

    func cleanPreviousBindings() {
        disposeBag = DisposeBag()
    }
}
