import UIKit

class ArtistInformationCell: UICollectionViewCell, NibLoadable {
    @IBOutlet weak var artistInformation: UILabel?
    @IBOutlet weak var readMoreButton: UIButton?

    fileprivate let defaultCellHeight: CGFloat = 100.0

    override public func awakeFromNib() {
        setupCell()
    }
}

extension ArtistInformationCell {
    func setupCell() {
        artistInformation?.text = """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut
            labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco
            laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in
            voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat
            non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        """

        readMoreButton?.layer.shadowColor = readMoreButton?.backgroundColor?.cgColor
        readMoreButton?.layer.shadowOffset = CGSize(width: 0, height: -12)
        readMoreButton?.layer.shadowOpacity = 0.8
    }
}

extension ArtistInformationCell {
    @IBAction func onReadMore(_ sender: UIButton) {

    }
}
