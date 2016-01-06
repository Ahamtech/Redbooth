import bb.cascades 1.3
import bb.system 1.2

Container {
    background: Color.create("#d4262c")
    Container {
        topPadding: 50
        leftPadding: 70
        rightPadding: 70

        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            layoutProperties: StackLayoutProperties {
                spaceQuota: 1
            }
            Container {
                Label {
                    text: "Welcome"
                    textStyle.fontSize: FontSize.PointValue
                    textStyle.fontSizeValue: 13
                    textStyle.color: Color.White
                    textStyle.fontWeight: FontWeight.W500

                }
            }
            Container {
                Label {
                    text: "Log in Here"

                    textStyle.fontSize: FontSize.PointValue
                    textStyle.fontSizeValue: 10
                    textStyle.color: Color.White
                    textStyle.fontWeight: FontWeight.W100
                }
            }
        }
        Container {
            maxHeight: 150
            maxWidth: 150
            ImageView {
                imageSource: "asset:///iconw.png"
            }
        }
    }
    Container {
        topPadding: 50
        leftPadding: 70
        rightPadding: 70
        background: Color.create("#d4262c")

        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            Container {
                verticalAlignment: VerticalAlignment.Bottom
                maxWidth: 2
                maxHeight: 10
                minHeight: 10
                minWidth: 2
                background: Color.White
            }
            Container {
                background: Color.create("#d4262c")
                opacity: 0
                TextArea {
                    hintText: "Username"
                }
            }
            Container {
                verticalAlignment: VerticalAlignment.Bottom
                maxWidth: 2
                maxHeight: 10
                minHeight: 10
                minWidth: 2
                background: Color.White
            }
        }
        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            maxHeight: 2
            minHeight: 2
            background: Color.White
        }

    }
    Container {
        topPadding: 50
        leftPadding: 70
        rightPadding: 70
        background: Color.create("#d4262c")

        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            Container {
                verticalAlignment: VerticalAlignment.Bottom
                maxWidth: 2
                maxHeight: 10
                minHeight: 10
                minWidth: 2
                background: Color.White
            }
            Container {
                background: Color.create("#d4262c")
                opacity: 0
                TextArea {
                    hintText: "Username"
                }
            }
            Container {
                verticalAlignment: VerticalAlignment.Bottom
                maxWidth: 2
                maxHeight: 10
                minHeight: 10
                minWidth: 2
                background: Color.White
            }
        }
        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            maxHeight: 2
            minHeight: 2
            background: Color.White
        }

    }
    Container {
        horizontalAlignment: HorizontalAlignment.Right
        topPadding: 10
        leftPadding: 70
        rightPadding: 70
        background: Color.create("#d4262c")
        Label {
            textStyle.fontSize: FontSize.PointValue
            textStyle.fontSizeValue: 7
            textStyle.color: Color.White
            text: "Forgot Password?"
        }
    }
    Container {
        topPadding: 40
        horizontalAlignment: HorizontalAlignment.Center
        maxWidth: 200
        Button {
            text: "Login"
            color: Color.create("#d4262c")

        }
    }
    Container {

    }

}