/****************************************************************************
** Meta object code from reading C++ file 'MainWindow.hpp'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.9.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../../src/openMVG_Samples/describe_and_match_GUI/MainWindow.hpp"
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
struct qt_meta_stringdata_features_pair_demo__MainWindow_t {
    QByteArrayData data[12];
    char stringdata0[171];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_features_pair_demo__MainWindow_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_features_pair_demo__MainWindow_t qt_meta_stringdata_features_pair_demo__MainWindow = {
    {
QT_MOC_LITERAL(0, 0, 30), // "features_pair_demo::MainWindow"
QT_MOC_LITERAL(1, 31, 12), // "onOpenImage1"
QT_MOC_LITERAL(2, 44, 0), // ""
QT_MOC_LITERAL(3, 45, 12), // "onOpenImage2"
QT_MOC_LITERAL(4, 58, 17), // "onComputeMatching"
QT_MOC_LITERAL(5, 76, 15), // "onMoveSomething"
QT_MOC_LITERAL(6, 92, 13), // "onExportImage"
QT_MOC_LITERAL(7, 106, 13), // "onCloseImage1"
QT_MOC_LITERAL(8, 120, 13), // "onCloseImage2"
QT_MOC_LITERAL(9, 134, 10), // "onCloseAll"
QT_MOC_LITERAL(10, 145, 6), // "onQuit"
QT_MOC_LITERAL(11, 152, 18) // "onClearComputation"

    },
    "features_pair_demo::MainWindow\0"
    "onOpenImage1\0\0onOpenImage2\0onComputeMatching\0"
    "onMoveSomething\0onExportImage\0"
    "onCloseImage1\0onCloseImage2\0onCloseAll\0"
    "onQuit\0onClearComputation"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_features_pair_demo__MainWindow[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      10,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0,   64,    2, 0x0a /* Public */,
       3,    0,   65,    2, 0x0a /* Public */,
       4,    0,   66,    2, 0x0a /* Public */,
       5,    0,   67,    2, 0x0a /* Public */,
       6,    0,   68,    2, 0x0a /* Public */,
       7,    0,   69,    2, 0x0a /* Public */,
       8,    0,   70,    2, 0x0a /* Public */,
       9,    0,   71,    2, 0x0a /* Public */,
      10,    0,   72,    2, 0x0a /* Public */,
      11,    0,   73,    2, 0x0a /* Public */,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

       0        // eod
};

void features_pair_demo::MainWindow::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        MainWindow *_t = static_cast<MainWindow *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->onOpenImage1(); break;
        case 1: _t->onOpenImage2(); break;
        case 2: _t->onComputeMatching(); break;
        case 3: _t->onMoveSomething(); break;
        case 4: _t->onExportImage(); break;
        case 5: _t->onCloseImage1(); break;
        case 6: _t->onCloseImage2(); break;
        case 7: _t->onCloseAll(); break;
        case 8: _t->onQuit(); break;
        case 9: _t->onClearComputation(); break;
        default: ;
        }
    }
    Q_UNUSED(_a);
}

const QMetaObject features_pair_demo::MainWindow::staticMetaObject = {
    { &QMainWindow::staticMetaObject, qt_meta_stringdata_features_pair_demo__MainWindow.data,
      qt_meta_data_features_pair_demo__MainWindow,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *features_pair_demo::MainWindow::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *features_pair_demo::MainWindow::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_features_pair_demo__MainWindow.stringdata0))
        return static_cast<void*>(this);
    return QMainWindow::qt_metacast(_clname);
}

int features_pair_demo::MainWindow::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QMainWindow::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 10)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 10;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 10)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 10;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
