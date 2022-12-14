import SwiftUI

struct BookCoverView: View {
    let accentColor: Color
    let scale: CGFloat
    let gradient: Gradient

    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Material.thin)
                .background(
                    LinearGradient(
                        gradient: gradient,
                        startPoint: UnitPoint(x: 0, y: 0),
                        endPoint: UnitPoint(x: 2, y: 0)
                    )
                    .saturation(1.25)
                )
            Rectangle()
                .fill(accentColor)
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
