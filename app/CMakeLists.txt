if(NOT "${CMAKE_CURRENT_SOURCE_DIR}" STREQUAL "${CMAKE_CURRENT_BINARY_DIR}")
  file(GLOB QML_JS_FILES *.qml *.js *.png)
  add_custom_target(ubuntu-clock-app_QMlFiles ALL SOURCES ${QML_JS_FILES})
endif(NOT "${CMAKE_CURRENT_SOURCE_DIR}" STREQUAL "${CMAKE_CURRENT_BINARY_DIR}")


if(CLICK_MODE)
  set(ICON ${ICON})
  install(FILES ${ICON} DESTINATION ${CMAKE_INSTALL_PREFIX})
else(CLICK_MODE)
  install(FILES ${ICON_FILE} DESTINATION ${UBUNTU-CLOCK_APP_DIR})
endif(CLICK_MODE)

install(FILES ${MAIN_QML} DESTINATION ${UBUNTU-CLOCK_APP_DIR})
install(FILES "MainPage.qml" DESTINATION ${UBUNTU-CLOCK_APP_DIR})

add_subdirectory(clock)
add_subdirectory(alarm)
add_subdirectory(stopwatch)
add_subdirectory(graphics)
add_subdirectory(components)
add_subdirectory(worldclock)
add_subdirectory(upstreamcomponents)
add_subdirectory(timer)
