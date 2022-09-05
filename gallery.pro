QT += quick
QT += core
QT += widgets
SOURCES += \
        imagetable.cpp \
        main.cpp \

resources.files = main.qml \
MyButton.qml \
MyDelegate.qml
resources.prefix = /$${TARGET}
RESOURCES += resources

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    imagetable.h

DISTFILES += \
    MyButton.qml \
    MyDelegate.qml \
    qml/MyButton.qml
