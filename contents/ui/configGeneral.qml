import QtQuick 2.0
import QtQuick.Controls 2.3 as QtControls
import QtQuick.Layouts 1.0 as QtLayouts
import org.kde.kirigami 2.5 as Kirigami

QtLayouts.ColumnLayout {
    id: appearancePage

    property string cfg_displayFormat: "desktopCount"
    property alias cfg_showTotal: showTotal.checked
    property alias cfg_showDesktop: showDesktop.checked

    QtControls.ComboBox {
      id: displayFormat
      Kirigami.FormData.label: i18n("Display format :")
      QtLayouts.Layout.fillWidth: true
      textRole: "label"
      model: [
          {
              'label': i18n("Total count (X)"),
              'name': "totalCount"
          },
          {
              'label': i18n("Desktop count (Y)"),
              'name': "desktopCount"
          }
      ]

      onCurrentIndexChanged: cfg_displayFormat = model[currentIndex]["name"]

      Component.onCompleted: {
            for (var i = 0; i < model.length; i++) {
                if (model[i]["name"] == plasmoid.configuration.displayFormat) {
                    displayFormat.currentIndex = i;
                }
            }
        }

    }

    Item {
      Kirigami.FormData.isSection: true
    }

    Kirigami.FormLayout {
        QtLayouts.Layout.fillWidth: true
        enabled: cfg_displayFormat === "desktopCount"

        QtControls.CheckBox {
            id: showTotal
            text: i18n("Add total count (Y/A)")
        }

        QtControls.CheckBox {
            id: showDesktop
            text: i18n("Add desktop id (Y~B)")
        }
    }

    Item {
        QtLayouts.Layout.fillHeight: true
    }

}
