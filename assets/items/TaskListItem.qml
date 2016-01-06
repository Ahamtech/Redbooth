import bb.cascades 1.3

Container {
    signal taskComplete
    signal taskIncomplete
    property alias title: name.text
    property alias time : ddate.text
    property alias image: img.imageSource
    background: Color.create("#e6e6e6")
    topPadding: 5
    bottomPadding: 5
    leftPadding: 10
    rightPadding: 10
    Container {
        topPadding: 10
        bottomPadding: 10
        leftPadding: 10
        
        background: Color.White
        verticalAlignment: VerticalAlignment.Center
        
        horizontalAlignment: HorizontalAlignment.Fill
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        
        Container { // task name container
            verticalAlignment: VerticalAlignment.Center
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            layoutProperties: StackLayoutProperties {
                spaceQuota: 1
            }
            Container {
                verticalAlignment: VerticalAlignment.Center
                leftPadding: 10
                rightPadding: 10
                topPadding: 10
                bottomPadding: 10
                CheckBox { //check box here
                    onCheckedChanged: {
                        if(checked){
                            taskComplete()
                        }
                        else{
                            taskIncomplete()
                        }
                    }
                }
            }
            Container {
                verticalAlignment: VerticalAlignment.Center
                
                Label { // task name here
//                    text: "Task Name"
                    textStyle.fontSize: FontSize.PointValue
                    textStyle.fontSizeValue: 8
                    id: name
                }
            
            }
        }
        
        Container { // date container
            verticalAlignment: VerticalAlignment.Center
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            layoutProperties: StackLayoutProperties {
                spaceQuota: -1
            }
            Container {
                maxHeight: 50
                maxWidth: 50
                verticalAlignment: VerticalAlignment.Center
//                ImageView { //repeat here
//                    imageSource: "asset:///images/BBicons/ic_reload.png"
//                    filterColor: Color.Gray
//                
//                }
            }
            Container {
//                background: Color.create("#e6e6e6")
                leftPadding: 10
                rightPadding: 10
                bottomPadding: 5
                verticalAlignment: VerticalAlignment.Center
                Label { // due date here
//                    text: "Due Date"
                    id: ddate
                    textStyle.fontSize: FontSize.PointValue
                    textStyle.fontSizeValue: 5
                }
            }
            Container {
                maxHeight: 50
                maxWidth: 50
                verticalAlignment: VerticalAlignment.Center
                ImageView { //assignee here
                    id: img
                    onImageSourceChanged: {
                        console.log("From compment " +imageSource)
                    }
                }
            }
        }
    }
}