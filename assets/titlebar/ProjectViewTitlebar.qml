import bb.cascades 1.4
Container {
    leftPadding: 30
    background: Color.create("#21a5b8")
    maxHeight: 100
    verticalAlignment: VerticalAlignment.Center
    horizontalAlignment: HorizontalAlignment.Center
    layout: StackLayout {
        orientation: LayoutOrientation.LeftToRight
    }
    Container {
        verticalAlignment: VerticalAlignment.Center
        horizontalAlignment: HorizontalAlignment.Center
        maxWidth: 100
        maxHeight: 100
        minHeight: 100
        minWidth: 100
        ImageView {
            imageSource: "asset:///iconw.png"
        }
    }
    Container {
        leftPadding: 30
        verticalAlignment: VerticalAlignment.Center
        horizontalAlignment: HorizontalAlignment.Center
        Label {
            text: "Project Name"
            textStyle.fontSize: FontSize.PointValue
            textStyle.fontSizeValue: 10
            opacity: .8
            textStyle.color: Color.White

        }
    }


}