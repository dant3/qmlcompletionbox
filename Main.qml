import QtQuick 1.1

Rectangle {
    width: 640
    height: 480
    color: "black"

    Suggestions {
        id: suggestions
    }

    Item {
        id: contents
        width: parent.width - 100
        height: parent.height - 100
        anchors.centerIn: parent

        LineEdit {
            id: inputField
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 18

            hint.text: "Enter text. It will be completed with lines below"
            borderColor: "white"
        }

        SuggestionsPreview {
            // just to show you what you can type in
            model: suggestions
        }

        SuggestionBox {
            id: suggestionsBox
            model: suggestions
            width: 200
            anchors.top: inputField.bottom
            anchors.left: inputField.left
            filter: inputField.textInput.text
            property: "name"
        }

    }

}
