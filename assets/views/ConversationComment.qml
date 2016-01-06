import bb.cascades 1.3

Container {
    property alias title: username.text
    property alias time: datetime.text
    property alias comment: desc.text
    property alias image: img.imageSource
    leftPadding: ui.du(2)
    rightPadding: ui.du(2)
    topPadding: ui.du(2)
    bottomPadding: ui.du(2)
    Container {
        background: Color.White
        horizontalAlignment: HorizontalAlignment.Fill

        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            Container {
                rightMargin: ui.du(2)
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                ImageView { //user image here
                    id: img
                    imageSource: "asset:///images/BBicons/ic_contact.png"
                }
            }
            Container {
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                Container {
                    horizontalAlignment: HorizontalAlignment.Left
                    verticalAlignment: VerticalAlignment.Center
                    Label { // username here
                        text: "Name"
                        id: username
                    }
                }
                Container {
                    horizontalAlignment: HorizontalAlignment.Left
                    verticalAlignment: VerticalAlignment.Center
                    Label { // activity time here
                        text: "Date/time"
                        id: datetime
                        opacity: .5
                        textStyle.fontSize: FontSize.PointValue
                        textStyle.fontSizeValue: 6
                    }
                }
            }
        }
        Container {
            leftPadding: ui.du(11)
            Label { //Comment here
                text: "Comment"
                id: desc
                multiline: true
                textStyle.fontWeight: FontWeight.W300
            }
        }
    }
}