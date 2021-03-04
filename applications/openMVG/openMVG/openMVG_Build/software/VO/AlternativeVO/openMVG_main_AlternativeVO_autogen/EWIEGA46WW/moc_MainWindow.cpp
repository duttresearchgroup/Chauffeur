/****************************************************************************
** Meta object code from reading C++ file 'MainWindow.hpp'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.9.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../../../src/software/VO/AlternativeVO/MainWindow.hpp"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'MainWindow.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.9.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_alternative_vo__MainWindow_t {
    QByteArrayData data[9];
    char stringdata0[145];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_alternative_vo__MainWindow_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_alternative_vo__MainWindow_t qt_meta_stringdata_alternative_vo__MainWindow = {
    {
QT_MOC_LITERAL(0, 0, 26), // "alternative_vo::MainWindow"
QT_MOC_LITERAL(1, 27, 21), // "onMenuOpenImageFolder"
QT_MOC_LITERAL(2, 49, 0), // ""
QT_MOC_LITERAL(3, 50, 10), // "onMenuQuit"
QT_MOC_LITERAL(4, 61, 15), // "onPlayVOProcess"
QT_MOC_LITERAL(5, 77, 15), // "onStopVOProcess"
QT_MOC_LITERAL(6, 93, 22), // "onStepForwardVOProcess"
QT_MOC_LITERAL(7, 116, 16), // "onResetVOProcess"
QT_MOC_LITERAL(8, 133, 11) // "onTimerTick"

    },
    "alternative_vo::MainWindow\0"
    "onMenuOpenImageFolder\0\0onMenuQuit\0"
    "onPlayVOProcess\0onStopVOProcess\0"
    "onStepForwardVOProcess\0onResetVOProcess\0"
    "onTimerTick"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_alternative_vo__MainWindow[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       7,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0,   49,    2, 0x0a /* Public */,
       3,    0,   50,    2, 0x0a /* Public */,
       4,    0,   51,    2, 0x0a /* Public */,
       5,    0,   52,    2, 0x0a /* Public */,
       6,    0,   53,    2, 0x0a /* Public */,
       7,    0,   54,    2, 0x0a /* Public */,
       8,    0,   55,    2, 0x0a /* Public */,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

       0        // eod
};

void alternative_vo::MainWindow::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        MainWindow *_t = static_cast<MainWindow *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->onMenuOpenImageFolder(); break;
        case 1: _t->onMenuQuit(); break;
        case 2: _t->onPlayVOProcess(); break;
        case 3: _t->onStopVOProcess(); break;
        case 4: _t->onStepForwardVOProcess(); break;
        case 5: _t->onResetVOProcess(); break;
        case 6: _t->onTimerTick(); break;
        default: ;
        }
    }
    Q_UNUSED(_a);
}

const QMetaObject alternative_vo::MainWindow::staticMetaObject = {
    { &QMainWindow::staticMetaObject, qt_meta_stringdata_alternative_vo__MainWindow.data,
      qt_meta_data_alternative_vo__MainWindow,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *alternative_vo::MainWindow::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *alternative_vo::MainWindow::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_alternative_vo__MainWindow.stringdata0))
        return static_cast<void*>(this);
    return QMainWindow::qt_metacast(_clname);
}

int alternative_vo::MainWindow::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QMainWindow::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 7)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 7;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 7)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 7;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
