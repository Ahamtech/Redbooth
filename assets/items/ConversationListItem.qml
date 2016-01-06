import bb.cascades 1.3


Container {
    property alias title: conversationame.text
    property alias time: timedate.text
//    property alias des: description.text
    property alias user: username.text
    property alias image: img.imageSource
    background: Color.create("#e6e6e6")
    
    leftPadding: ui.du(1)
    rightPadding: ui.du(1)
    topPadding: ui.du(1)

    Container {
        leftPadding: ui.du(1)
        rightPadding: ui.du(1)
        bottomPadding: ui.du(1.3)
        background: Color.White
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        Container {
            leftPadding: ui.du(1)
            rightPadding: ui.du(1)
            topPadding: ui.du(1.3)
            bottomPadding: ui.du(1)
            Label { //conversation name
                multiline: true
//                text: "Conversation Name"
                id: conversationame
            }
        }
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }

            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 1
                }
                Container {
                    verticalAlignment: VerticalAlignment.Center
                    maxWidth: 60
                    maxHeight: 60
                    
                    ImageView { // user photo
                        id: img
                        imageSource: "asset:///images/BBicons/ic_contact.png"
                    }
                }
                Container {
                    leftPadding: ui.du(2)
                    verticalAlignment: VerticalAlignment.Center
                    Label { // user name
                        text: "User Name"
                        id:username
                        textStyle.fontWeight: FontWeight.W200
                        textStyle.fontSize: FontSize.PointValue
                        textStyle.fontSizeValue: 6
                    }
                }
            }
            Container {
                rightPadding: 10
                layoutProperties: StackLayoutProperties {
                    spaceQuota: -1
                }
                verticalAlignment: VerticalAlignment.Center
                Label { // Comment Time
//                    text: "Date"
                    id: timedate
                    textStyle.fontSize: FontSize.PointValue
                    textStyle.fontSizeValue: 5
                    opacity: .5
                }
            }
        }
//        Container { //latest comment
//            leftPadding: 10
//            rightPadding: 10
//            bottomPadding: 10
//            Label {
//                id:description
////                text: "Latest Comment"
//                textStyle.fontWeight: FontWeight.W200
//
//                opacity: .5
//                autoSize.maxLineCount: 2
//            }
//
//        }
    }

}