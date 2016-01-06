import bb.cascades 1.3
import bb.system 1.2
import  "../titlebar"
import "../views"
import "../moment.js" as Moment
Page {
    signal deleted
    actionBarAutoHideBehavior: ActionBarAutoHideBehavior.HideOnScroll

    titleBar: ConversationViewTitlebar {

    }
    onCreationCompleted: {
        render()
    }
    function render(){
        var info = activeconversation
        watchers.text = info['watcher_ids'].length
        title.text = info.name
        getComments()
    }
    Container {
        layout: StackLayout {

        }

        Container {
            topPadding: 20
            leftPadding: 40
            rightPadding: 20
            Label { //conversation name here
                multiline: true
                text: "Conversation Name"
                id: title
            }
        }

        Container {
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }

            Container {
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 1
                }
                leftPadding: 40
                rightPadding: 20
                bottomPadding: 20
                Label { // project name here
                    //                    text: "Project Name"
                    opacity: .5
                    textStyle.fontSize: FontSize.PointValue
                    textStyle.fontSizeValue: 6

                }
            }

            Container {
                layoutProperties: StackLayoutProperties {
                    spaceQuota: -1
                }
                Container {
                    rightPadding: 30
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Center
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    Container {
                        maxWidth: 50
                        maxHeight: 50
                        verticalAlignment: VerticalAlignment.Center
                        horizontalAlignment: HorizontalAlignment.Center
                        ImageView {

                            imageSource: "asset:///images/BBicons/ic_contact.png"
                        }
                    }
                    Container {
                        verticalAlignment: VerticalAlignment.Center
                        horizontalAlignment: HorizontalAlignment.Center
                        Label { // member count here
                            //                            text: "3"
                            id: watchers
                        }
                    }
                }

            }
        }
        Divider {

        }
        ListView {
            id: comments
            dataModel: ArrayDataModel {

            }
            listItemComponents: [
                ListItemComponent {
                    type: ""
                    CustomListItem {

                        ConversationComment {
                            title: Qt.getUserNameFromId(ListItemData.user_id)
                            comment: ListItemData.body
                            time: Moment.moment.unix(ListItemData['updated_at']).format('lll')
                            image: Qt.app.isImageAvailabel(ListItemData['user_id'])
                        }
                    }
                }
            ]

        }
    }

    actions: [
        ActionItem {
            title: "Edit Title"
            onTriggered: {
                edit.show()
            }
        },
        ActionItem {
            title: "Add Comment"
            ActionBar.placement: ActionBarPlacement.Signature
            imageSource: "asset:///images/BBicons/ic_add.png"
            onTriggered: {
                commentbox.show()
            }
        },
        DeleteActionItem {
            title: "Delete"
            onTriggered: {
                deleteTaskDilog.show()
            }
        }
        
    ]
    attachedObjects: [
        SystemPrompt {
            id: commentbox
            title: qsTr("Enter Comment")
            rememberMeChecked: false
            includeRememberMe: false
            confirmButton.enabled: true
            cancelButton.enabled: true
            inputField.emptyText: qsTr("Comment")
            onFinished: {
                if (result == SystemUiResult.ConfirmButtonSelection) {
                    postComments(commentbox.inputFieldTextEntry())
                }
            }
        },
        SystemDialog {
            id: deleteTaskDilog
            title: qsTr("Delete")
            body: qsTr("Do you want to Delete this item ?")
            confirmButton.enabled: true
            confirmButton.label: qsTr("Yes")
            cancelButton.enabled: true
            onFinished: {
                if (result == SystemUiResult.ConfirmButtonSelection) {
                    deleteConversations()
                }
            }
        },
        SystemPrompt {
            id: edit
            title: qsTr("edit Title")
            rememberMeChecked: false
            includeRememberMe: false
            confirmButton.enabled: true
            cancelButton.enabled: true
            onFinished: {
                if (result == SystemUiResult.ConfirmButtonSelection) {
                    editTitle(inputFieldTextEntry())
                }
            }
        }
    ]
    function getComments() {
        var doc = new XMLHttpRequest();
        var url = endpoint + "comments?order=id&target_type=conversation&target_id=" + activeconversation.id
        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status == 200) {
                    var info = JSON.parse(doc.responseText)
                    info.reverse()
                    comments.dataModel.clear()
                    comments.dataModel.append(info)
                } else {
                    parseErrorResp(doc)
                }
            }
        }
        doc.open("get", url);
        doc.setRequestHeader("Authorization", "Bearer " + app.getToken());
        doc.setRequestHeader("Content-Type", "application/json");
        doc.setRequestHeader("User-Agent", "BB10");
        doc.setRequestHeader("Content-Encoding", "UTF-8");
        doc.send();
    }
    function postComments(content) {
        var doc = new XMLHttpRequest();
        var url = endpoint + "comments?&target_type=conversation&target_id=" + activeconversation.id
        url += "&body="
        url += content
        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status == 201) {
                    var info = JSON.parse(doc.responseText)
                    comments.dataModel.insert(0, info)
                } else {
                    parseErrorResp(doc)
                }
            }
        }
        doc.open("post", url);
        doc.setRequestHeader("Authorization", "Bearer " + app.getToken());
        doc.setRequestHeader("Content-Type", "application/json");
        doc.setRequestHeader("User-Agent", "BB10");
        doc.setRequestHeader("Content-Encoding", "UTF-8");
        doc.send();
    }
    function editTitle(content) {
        var doc = new XMLHttpRequest();
        var url = endpoint + "conversations/"+ activeconversation.id + "?name="
        url += content
        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status == 200) {
                    updateConversation()
                    activeconversation = JSON.parse(doc.responseText)
                    render()
                } else {
                    parseErrorResp(doc)
                }
            }
        }
        doc.open("put", url);
        doc.setRequestHeader("Authorization", "Bearer " + app.getToken());
        doc.setRequestHeader("Content-Type", "application/json");
        doc.setRequestHeader("User-Agent", "BB10");
        doc.setRequestHeader("Content-Encoding", "UTF-8");
        doc.send();
    }
    function deleteConversations(){
        var doc = new XMLHttpRequest();
        var url = endpoint + "conversations/"+activeconversation.id
        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status == 204) {
                    updateConversation()
                    navcon.pop()
                } else {
                    parseErrorResp(doc)
                }
            }
        }
        doc.open("delete", url);
        doc.setRequestHeader("Authorization", "Bearer " + app.getToken());
        doc.setRequestHeader("Content-Type", "application/json");
        doc.setRequestHeader("User-Agent", "BB10");
        doc.setRequestHeader("Content-Encoding", "UTF-8");
        doc.send();
    }
}