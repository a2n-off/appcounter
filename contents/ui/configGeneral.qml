import QtQuick 2.0
import QtQuick.Controls 2.0
import org.kde.kirigami 2.5 as Kirigami


Kirigami.FormLayout {
    property alias cfg_countSticky: countStickyCheckBox.checked

    anchors {
        left: parent.left
        right: parent.right
    }

    CheckBox {
        id: countStickyCheckBox
        text: i18n("Count sticky windows (-1 in wmctrl)")
        Kirigami.FormData.label: i18n("General:")
    }
}
