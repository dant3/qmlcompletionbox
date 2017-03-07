import QtQuick 1.0

FocusScope {
    // --- properties
    property color borderColor: "black"
    property color borderColorFocused: "steelblue"
    property int borderWidth: 1
    property alias borderRadius: borderRect.radius
    property alias backgroundColor: borderRect.color
    property alias hint: hintComponent
    property bool hasClearButton: true
    property alias clearButton: clearButtonComponent
    property alias textInput: textInputComponent

    // --- signals
    signal accepted


    id: focusScope

    Rectangle {
        id: borderRect
        anchors.fill: parent
        border {
            width: focusScope.borderWidth
            color: (parent.activeFocus || textInputComponent.activeFocus) ? focusScope.borderColorFocused : focusScope.borderColor
        }
        radius: 4
        color: "white"
    }

    Text {
        id: hintComponent
        anchors.fill: parent; anchors.leftMargin: 4
        verticalAlignment: Text.AlignVCenter
        text: "Type something..."
        color: "gray"
        font.italic: true
    }

    MouseArea {
        anchors.fill: parent
        onClicked: { focusScope.focus = true; textInput.openSoftwareInputPanel(); }
    }

    TextInput {
        id: textInputComponent
        anchors { left: parent.left; leftMargin: 4; right: clearButtonComponent.left; rightMargin: 4; verticalCenter: parent.verticalCenter }
        focus: true
        selectByMouse: true
        color: "black"
        onAccepted: focusScope.accepted()
    }

    Button {
        id: clearButtonComponent
        opacity: 0
        color: "transparent"

        anchors { right: parent.right; rightMargin: 4; verticalCenter: parent.verticalCenter }

        onClicked: { textInput.text = ''; focusScope.focus = true; textInput.openSoftwareInputPanel(); }

        Image {
            width: 16
            height: 16
            anchors.centerIn: parent
            source: "resources/icons/clear-text-rtl.png"
        }
    }

    states: State {
        name: "hasText"; when: textInput.text != ''
        PropertyChanges { target: hintComponent; opacity: 0 }
        PropertyChanges { target: clearButtonComponent; opacity: 1 }
    }

    transitions: [
        Transition {
            from: ""; to: "hasText"
            NumberAnimation { exclude: hintComponent; properties: "opacity" }
        },
        Transition {
            from: "hasText"; to: ""
            NumberAnimation { properties: "opacity" }
        }
    ]
}
