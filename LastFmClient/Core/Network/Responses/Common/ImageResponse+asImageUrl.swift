extension ImageResponse {

    var asImageUrl: (size: ImageSize, url: String)? {
        switch size {
        case "small":
            return (.small, url)
        case "medium":
            return (.medium, url)
        case "large":
            return (.large, url)
        default:
            return nil
        }
    }

}
