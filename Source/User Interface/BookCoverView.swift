import SwiftUI

struct BookCoverView: View {
    let accentColor: Color
    let scale: CGFloat
    let gradient: Gradient

    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(
                    accentColor.gradient
                        .opacity(0.5)
                )
            Rectangle()
                .fill(
                    accentColor.gradient
                )
                .frame(width: 10 * scale)
        }
        .frame(width: 75 * scale, height: 100 * scale)
        .clipShape(RoundedRectangle(cornerRadius: 5 * scale))
    }
}

struct BookCoverView_Previews: PreviewProvider {
    static var previews: some View {
        BookCoverView(
            accentColor: Color.blue,
            scale: 1,
            gradient: .init(colors: [Color.blue, Color.clear])
        )
    }
}
