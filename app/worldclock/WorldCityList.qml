/*
 * Copyright (C) 2014 Canonical Ltd
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import Timezone 1.0
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 1.0 as ListItem

Page {
    id: worldCityList

    title: i18n.tr("Select a city")
    visible: false

    state: "default"
    states: [
        PageHeadState {
            name: "default"
            head: worldCityList.head
            actions: [
                Action {
                    iconName: "search"
                    text: i18n.tr("City")
                    onTriggered: {
                        worldCityList.state = "search"
                    }
                },

                Action {
                    /*
                      TODO: Enable this action when add a custom city as shown
                      in the design specs is implemented.
                    */
                    enabled: false
                    iconName: "add"
                    text: i18n.tr("City")
                    onTriggered: {
                        console.log("Not Yet Implemented")
                    }
                }
            ]
        },

        PageHeadState {
            name: "search"
            head: worldCityList.head
            backAction: Action {
                iconName: "back"
                text: i18n.tr("Back")
                onTriggered: {
                    worldCityList.state = "default"
                }
            }
            contents: TextField {
                /*
                  #TODO: Enable textfield after searching through listview is
                  implemented.
                */
                enabled: false
                anchors {
                    left: parent ? parent.left : undefined
                    right: parent ? parent.right : undefined
                    rightMargin: units.gu(2)
                }
            }
        }
    ]

    XmlTimeZoneModel {
        id: timeZoneModel
        updateInterval: 1000
        source: Qt.resolvedUrl("world-city-list.xml")
    }

    ListView {
        id: cityList

        anchors.fill: parent
        model: timeZoneModel

        Component {
            id: sectionHeading
            ListItem.Header {
                Label {
                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        leftMargin: units.gu(2)
                    }

                    text: section
                    color: Theme.palette.normal.baseText
                    fontSize: "medium"
                }
            }
        }

        section.property: "city"
        section.criteria: ViewSection.FirstCharacter
        section.delegate: sectionHeading;
        section.labelPositioning: ViewSection.InlineLabels

        delegate: ListItem.Base {

            height: units.gu(7)

            Column {
                id: _labelColumn

                anchors.verticalCenter: parent.verticalCenter

                Label {
                    id: _cityName
                    fontSize: "medium"
                    text: city
                    color: UbuntuColors.midAubergine
                }

                Label {
                    id: _countryName
                    text: country
                    fontSize: "xx-small"
                }
            }

            Label {
                id: _localTime
                text: localTime
                fontSize: "medium"
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
            }

            onClicked: {
                console.log("Add city to U1DB Model")
            }
        }
    }
}
