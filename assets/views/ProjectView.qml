import bb.cascades 1.4

Page {
    titleBar: TitleBar {
        kind: TitleBarKind.FreeForm
        kindProperties: FreeFormTitleBarKindProperties {
            content: Container {

                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }

                Container {
                    leftPadding: 30
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Center
                    Label { // project id here
                        text: "Project Name"
                        textStyle.fontSize: FontSize.PointValue
                        textStyle.fontSizeValue: 10
                        opacity: .8
                        textStyle.color: Color.create("#21a5b8")

                    }
                }

            }
        }
    }
    Container {
        background: Color.create("#e6e6e6")


        //    Container {
        //        horizontalAlignment: HorizontalAlignment.Fill
        //        background: Color.create("#e6e6e6")
        //
        //        verticalAlignment: VerticalAlignment.Fill
        //        margin.bottomOffset: 10
        //        SegmentedControl {
        //
        //            horizontalAlignment: HorizontalAlignment.Fill
        //
        //            id: selectChats
        //            selectedIndex: 0
        //            Option {
        //                text: qsTr("Tasks") + Retranslate.onLanguageChanged
        //                value: "all"
        //            }
        //            Option {
        //                text: qsTr("Conversations") + Retranslate.onLanguageChanged
        //                value: "contact"
        //            }
        //            Option {
        //                text: qsTr("Notes") + Retranslate.onLanguageChanged
        //                value: "contact"
        //            }
        //
        //            onSelectedIndexChanged: {
        //                switch (selectedValue) {
        //                    case 'tasks':
        //                        classifycontacts()
        //                        break;
        //                    case 'conversations':
        //                        classifycontacts()
        //                        break;
        //                    case 'notes':
        //                        classifycontacts()
        //                        break;
        //
        //                }
        //            }
        //        }
        //
        //    }

    }
    actions: [
        ActionItem {
            title: "Add Task"
            ActionBar.placement: ActionBarPlacement.OnBar

            imageSource: "asset:///images/BBicons/ic_add.png"
            onTriggered: {
                project_navigation.push(createProjectPage.createObject())

            }
        },
        ActionItem {
            title: "Add Conversation"
            ActionBar.placement: ActionBarPlacement.OnBar

            imageSource: "asset:///images/BBicons/ic_bbm.png"
            onTriggered: {
                project_navigation.push(archivedProgectPage.createObject())
            }
        }
    ]
}
