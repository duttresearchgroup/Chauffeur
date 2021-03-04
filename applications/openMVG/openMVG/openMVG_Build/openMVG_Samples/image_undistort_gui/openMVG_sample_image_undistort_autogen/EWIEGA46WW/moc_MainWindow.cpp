/****************************************************************************
** Meta object code from reading C++ file 'MainWindow.hh'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.9.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../../src/openMVG_Samples/image_undistort_gui/MainWindow.hh"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'MainWindow.hh' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.9.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_image_undistort_gui__MainWindow_t {
    QByteArrayData data[13];
    char stringdata0[217];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_image_undistort_gui__MainWindow_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_image_undistort_gui__MainWindow_t qt_meta_stringdata_image_undistort_gui__MainWindow = {
    {
QT_MOC_LITERAL(0, 0, 31), // "image_undistort_gui::MainWindow"
QT_MOC_LITERAL(1, 32, 11), // "onOpenImage"
QT_MOC_LITERAL(2, 44, 0), // ""
QT_MOC_LITERAL(3, 45, 14), // "onProcessImage"
QT_MOC_LITERAL(4, 60, 13), // "onExportImage"
QT_MOC_LITERAL(5, 74, 21), // "onSelectIntrinsicType"
QT_MOC_LITERAL(6, 96, 16), // "onChangeCheckBox"
QT_MOC_LITERAL(7, 113, 18), // "onMenuSelectNoDist"
QT_MOC_LITERAL(8, 132, 19), // "onMenuSelectRadial1"
QT_MOC_LITERAL(9, 152, 19), // "onMenuSelectRadial3"
QT_MOC_LITERAL(10, 172, 17), // "onMenuSelectBrown"
QT_MOC_LITERAL(11, 190, 19), // "onMenuSelectFisheye"
QT_MOC_LITERAL(12, 210, 6) // "onQuit"

    },
    "image_undistort_gui::MainWindow\0"
    "onOpenImage\0\0onProcessImage\0onExportImage\0"
    "onSelectIntrinsicType\0onChangeCheckBox\0"
    "onMenuSelectNoDist\0onMenuSelectRadial1\0"
    "onMenuSelectRadial3\0onMenuSelectBrown\0"
    "onMenuSelectFisheye\0onQuit"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_image_undistort_gui__MainWindow[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      11,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0,   69,    2, 0x0a /* Public */,
       3,    0,   70,    2, 0x0a /* Public */,
       4,    0,   71,    2, 0x0a /* Public */,
       5,    0,   72,    2, 0x0a /* Public */,
       6,    0,   73,    2, 0x0a /* Public */,
       7,    0,   74,    2, 0x0a /* Public */,
       8,    0,   75,    2, 0x0a /* Public */,
       9,    0,   76,    2, 0x0a /* Public */,
      10,    0,   77,    2, 0x0a /* Public */,
      11,    0,   78,    2, 0x0a /* Public */,
      12,    0,   79,    2, 0x0a /* Public */,

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
    QMetaType::Void,

       0        // eod
};

void image_undistort_gui::MainWindow::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        MainWindow *_t = static_cast<MainWindow *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->onOpenImage(); break;
        case 1: _t->onProcessImage(); break;
        case 2: _t->onExportImage(); break;
        case 3: _t->onSelectIntrinsicType(); break;
        case 4: _t->onChangeCheckBox(); break;
        case 5: _t->onMenuSelectNoDist(); break;
        case 6: _t->onMenuSelectRadial1(); break;
        case 7: _t->onMenuSelectRadial3(); break;
        case 8: _t->onMenuSelectBrown(); break;
        case 9: _t->onMenuSelectFisheye(); break;
        case 10: _t->onQuit(); break;
        default: ;
        }
    }
    Q_UNUSED(_a);
}

const QMetaObject image_undistort_gui::MainWindow::staticMetaObject = {
    { &QMainWindow::staticMetaObject, qt_meta_stringdata_image_undistort_gui__MainWindow.data,
      qt_meta_data_image_undistort_gui__MainWindow,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *image_undistort_gui::MainWindow::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *image_undistort_gui::MainWindow::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_image_undistort_gui__MainWindow.stringdata0))
        return static_cast<void*>(this);
    return QMainWindow::qt_metacast(_clname);
}

int image_undistort_gui::MainWindow::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QMainWindow::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 11)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 11;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 11)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 11;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
