import bb.cascades 1.4
Container {
    property alias title: info.text
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill
    background: Color.create("#e6e6e6")
    topPadding: 5
    bottomPadding: 5
    rightPadding: 10
    leftPadding: 10
    Container {
        topPadding: 20
        bottomPadding: 10
        leftPadding: 10
        rightPadding: 10
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        background: Color.White
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        Container {

            background: Color.create("#21a5b8")
            minWidth: 5
            maxWidth: 5
            verticalAlignment: VerticalAlignment.Fill
        }

        Container {
            leftPadding: 10
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            minHeight: 50
            minWidth: 60
            maxHeight: 50
            maxWidth: 60
            ImageView {
                imageSource: "asset:///images/new/accountsmain.png"
            }
        }

        Container {
            leftPadding: 10

            verticalAlignment: VerticalAlignment.Top
            horizontalAlignment: HorizontalAlignment.Center
            Label {
//                text: "Project Name"
                    id: info
            }
        }

    }

}
