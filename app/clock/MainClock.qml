/*
 * Copyright (C) 2014 Canonical Ltd
 *
 * This file is part of Ubuntu Clock App
 *
 * Ubuntu Clock App is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * Ubuntu Clock App is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.3
import Ubuntu.Components 1.1
import "../components"

Clock {
    id: mainClock

    fontSize: units.dp(62)
    periodFontSize: units.dp(12)
    innerCircleWidth: units.gu(23)

    isMainClock: true

    isDigital: clockModeDocument.contents.digitalMode ? true : false

    Component.onCompleted: {
        clockOpenAnimation.start()
    }

    /*
      The clockOpenAnimation is only executed once when the clock app is
      opened.
    */
    SequentialAnimation {
        id: clockOpenAnimation

        /*
          On startup, first ensure that the correct mode is loaded into memory,
          and then only proceed to start the startup animation.
        */

        ScriptAction {
            script: {
                if (isDigital) {
                    digitalModeLoader.setSource
                            ("../components/DigitalMode.qml",
                             {
                                 "maxWidth": innerCircleWidth,
                                 "maxTimeFontSize": fontSize,
                                 "maxPeriodFontSize": periodFontSize,
                             })
                }
                else {
                    analogModeLoader.setSource
                            ("../components/AnalogMode.qml",
                             {
                                 "maxWidth": innerCircleWidth,
                                 "showSeconds": isMainClock
                             })
                }
            }
        }

        ParallelAnimation {
            PropertyAnimation {
                target: mainClock
                property: "width"
                to: units.gu(32)
                duration: 900
            }

            ScriptAction {
                script: {
                    if (isDigital) {
                        digitalModeLoader.item.startAnimation()
                    }
                    else {
                        analogModeLoader.item.startAnimation()
                    }
                }
            }
        }
    }

    /*
     Only when the startup animation is complete, proceed to load the
     alarm model
    */
    Connections {
        target: digitalModeLoader.item
        onAnimationComplete: {
            alarmModelLoader.source = Qt.resolvedUrl("../alarm/AlarmModelComponent.qml")
        }
    }

    Connections {
        target: analogModeLoader.item
        onAnimationComplete: {
            alarmModelLoader.source = Qt.resolvedUrl("../alarm/AlarmModelComponent.qml")
        }
    }
}
